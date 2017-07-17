//
//  MainViewController.swift
//  Situps
//
//  Created by 毛汉卿 on 2017/7/6.
//  Copyright © 2017年 毛汉卿. All rights reserved.
//

import UIKit
import SnapKit




class MainViewController: UIViewController {
    
    var pauseSec  = 0
    
    var lastSelectedButton: UIButton? {
        willSet{
            print("will set  == \(String(describing: lastSelectedButton?.tag))")
            guard lastSelectedButton != nil else {
                return
            }
            lastSelectedButton?.isSelected = false
            
        }
        didSet{
            
            print("did set ==\(String(describing: lastSelectedButton?.tag)) ")
            
            self.setActivityNum(num: (lastSelectedButton?.currentTitle)!)
            
            lastSelectedButton?.isSelected = true
            
        }
    }
    //MARK: lazy
    private lazy var buttons : Array<UIButton> = {
        var arr = Array<UIButton>()
        return arr
    }()
    private lazy var backgroundImage:UIImageView = {
        let image = UIImageView()
        self.view.addSubview(image)
        image.image = UIImage.init(named: "backGroundImage")
        return image
    }()
    
    private lazy var topBar:UIView = {
       let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:#selector(topBarViewAction) ))
        return view
    }()
    private lazy var numLabel:UILabel = {
       let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        label.textColor = UIColor.orange
        return label
    }()
    private lazy var countDownView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(view)
        
        let backStyle = UIBlurEffect(style: .light)
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.addSubview(blur)
        blur.snp.makeConstraints({ (make) in
            make.top.bottom.left.right.equalToSuperview()
        })
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.countDownTap)))
        return view
    }()
    private lazy var leftNavigationItem : UIButton = {
       let button  = UIButton(type:.custom)
        self.topBar.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        })
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(leftNavigationItemAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var countDownLabel: UILabel = {
        let label = UILabel()
        self.countDownView.addSubview(label)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = NSTextAlignment.center
        label.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        return label
    }()
    private lazy var complete:UIButton = {
       let button = UIButton()
        self.countDownView.addSubview(button)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("完成", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button .addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        button.snp.makeConstraints({ (make) in
            
            make.top.left.right.bottom.equalToSuperview()
        })
        return button
    }()
    var datas  = Array<String>()
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.makeLayout()
        let trainningData = Util.getTrainnings()
        
        pauseSec = Int(trainningData[.pauseSec]! as! String)!
        
        datas = trainningData[.trainning]! as! Array<String>
        
    self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewTouch)))
        guard !datas.isEmpty else {
            return
        }
        self.setButtons(data: datas)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    //MARK: - priviteMethod
    func setButtons(data:Array<String>)  {
        let width = 25
        let gap   = 10
        
        for (index,value) in  data.enumerated() {
            print("index === \(index)")
            let button  = self.topbarButton(title: value)
            button.tag = index
            let rightOffset = index - data.count+1
            button.snp.makeConstraints({ (make) in
                make.bottom.equalToSuperview().offset(-10)
                make.right.equalToSuperview().offset(-gap+rightOffset * (width+gap))
                make.width.equalTo(width)
                make.height.equalTo(25)
            })
            self.buttons.append(button)
            if index == 0 {
               self.buttonAction(sender: button)
            }
        }
        
    }
    
    private func makeLayout() {
        backgroundImage.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        self.leftNavigationItem.snp.makeConstraints { (make) in
            
        }
        topBar.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(60)
            
        }
    }
    private func setActivityNum(num:String)  {
        let sufix = "\n个仰卧起坐"
        let lastSufix = "\n需要完成"
        let totalString = num+sufix+lastSufix
        
        let attributed = NSMutableAttributedString(string: totalString)
        attributed.addAttributes([.font: UIFont.systemFont(ofSize: 150),.foregroundColor:UIColor.orange], range: (totalString as NSString).range(of: num))
        attributed.addAttributes([.font:UIFont.systemFont(ofSize: 20),.foregroundColor:UIColor.black], range: (totalString as NSString).range(of: sufix))
        attributed.addAttributes([.font:UIFont.systemFont(ofSize: 30),.foregroundColor:UIColor.black], range: (totalString as NSString).range(of: lastSufix))
        
        self.numLabel.attributedText = attributed
    }
    
    private func topbarButton(title:String) -> UIButton {
        let button = UIButton()
        self.topBar.addSubview(button)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.backgroundColor = UIColor.lightGray
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }
    
    private func changeToNext() {
        
    }
    
    
    var countDown = 0
    
    private func countDownBegin(){
        self.view.addSubview(self.countDownView)
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        countDown = self.pauseSec
        
        let tag = (self.lastSelectedButton?.tag)!+1
        guard tag < self.buttons.count else{
            self.countDownLabel.isHidden = true
            self.complete.isHidden = false
            return
        }
       let timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
        
            if self.countDown == 0 {
                timer.invalidate()
                
               self.countDown = self.pauseSec
                
                self.countDownView.removeFromSuperview()
                self.buttonAction(sender: self.buttons[tag])
                return
            }
            self.countDownLabel.text = "\(self.countDown) s"
            self.countDown = self.countDown-1
        }
        timer.fire();
    }
    
    //MARK: - action
    @objc
    func buttonAction(sender:UIButton) {
        lastSelectedButton = sender
    }
    @objc func countDownTap() {
        self.countDown = 5
        
    }
    @objc func viewTouch(){
        
        self .countDownBegin()
    }
    @objc func leftNavigationItemAction(){
    self.dismiss(animated: true, completion: nil)
    }
    @objc func completeAction(){
        Util.trainningComplete()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func topBarViewAction(){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

