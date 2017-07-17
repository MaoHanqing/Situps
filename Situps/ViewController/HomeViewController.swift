//
//  HomeViewController.swift
//  Situps
//
//  Created by 毛汉卿 on 2017/7/11.
//  Copyright © 2017年 毛汉卿. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
   lazy var backGround : UIImageView = {
       let image = UIImageView(image: UIImage(named: "backGroundImage"))
        self.view.addSubview(image)
    image.snp.makeConstraints({ (make) in
        make.center.equalToSuperview()
    })
        return image
    }()
    lazy var trainningTimes: UILabel = {
       let label  = UILabel()
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(80)
            make.centerX.equalTo(UIScreen.main.bounds.size.width/4)
            
        })
        self.labelSyle(label: label, font: 18)
        return label
    }()
    lazy var totalTrainningTime: UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerX.equalTo(UIScreen.main.bounds.size.width*3/4)
            make.top.equalTo(80)
        })
        self.labelSyle(label: label, font: 18)
        return label
    }()
    lazy var trainning : UIButton = {
        let button = UIButton(type: .custom)
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
            make.width.equalTo(150)
            make.height.equalTo(40)
        })
        button.setTitle("开始训练", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
        return button
    }()
   private func labelSyle(label:UILabel ,font:CGFloat){
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = UIColor.white
        label.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backGround.isHidden = false
        
        
        self.trainning.addTarget(self, action: #selector(trainningAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.updateUI()
    }
    private func updateUI(){
        self.title = "第\(Util.shareUtil.trainningDay+1)天"
        self.trainningTimes.text = "第\(Util.shareUtil.trainningTime)次训练"
        self.totalTrainningTime.text = "总训练\(Util.shareUtil.TotalTrainTime)次"
        
    }
    
    @IBAction func selecteTrainningPlan(_ sender: UIBarButtonItem) {
        
//        Util.shareUtil.trainningDay = Int(arc4random()%30)
//        self.updateUI()
        self.navigationController?.pushViewController(TrainningPlanViewController(), animated: true)
    }
    @objc func trainningAction(){
        
        self.navigationController?.present(MainViewController(), animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
