//
//  TrainningPlanViewController.swift
//  Situps
//
//  Created by 毛汉卿 on 2017/7/11.
//  Copyright © 2017年 毛汉卿. All rights reserved.
//

import UIKit
import SnapKit
class TrainningPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var backImage : UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "backGroundImage"))
        self.view.addSubview(imageView)
        return imageView
    }()
    lazy var tableView : UITableView = {
       let table = UITableView()
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(64)
        }
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.dataSource = self
        return table
    }()
    var trainning :Array<Dictionary<String,AnyObject>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "训练计划"
        self.view.layer.masksToBounds = true
        self.trainning =  Util.getAllTrainnings()
        self.view.backgroundColor = UIColor.white
        backImage.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK :tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainning.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
            cell?.backgroundColor = UIColor.clear
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
        }
        let trainnings  = self.trainning[indexPath.row]
        
        let trainning = trainnings["trainnings"] as! Array<String>
        let trainningString = self.trainningString(plans: trainning)
        
        cell?.textLabel?.text = "第\(indexPath.row+1)天     "+trainningString
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Util.shareUtil.trainningDay = indexPath.row
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    private func trainningString(plans:Array<String>) -> String  {
        var result = ""
        for  (index,value) in plans.enumerated() {
            result = index == 0 ?"\(value)":"\(result)-\(value)"
        }
    return result
    
    
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
