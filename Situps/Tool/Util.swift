//
//  Util.swift
//  Situps
//
//  Created by 毛汉卿 on 2017/7/11.
//  Copyright © 2017年 毛汉卿. All rights reserved.
//

import UIKit
public enum TrainningKey : String {
   case pauseSec            = "pauseSec"
   case trainning           = "trainnings"
   case trainningDay        = "trainningDay"
   case trainningTimes      = "trainningTimes"
   case totalTrainningTimes = "totalTrainningTimes"
}


class Util: NSObject {
  static let shareUtil = Util()
    var trainningDay :Int {
        set{
            Util.saveData(key:.trainningDay, value: newValue)
        }
        get{
          return Util.getData(key: .trainningDay)
        }
    }
    var trainningTime :Int{
        set{
            
            var tranningDay = UserDefaults.standard.object(forKey: TrainningKey.trainningTimes.rawValue) as? Dictionary<String,Int>
            
            
                tranningDay?["\(Util.shareUtil.trainningDay)"] = newValue
            
            
            
            
            
            
            Util.saveData(key: .trainningTimes, value:tranningDay)
        }
        get{
            return Util.getData(key: .trainningTimes)
        }
    }
    var TotalTrainTime :Int{
        set{
            Util.saveData(key: .totalTrainningTimes, value: newValue)
        }
        get{
            return Util.getData(key: .totalTrainningTimes)
        }
    }
    class func  getAllTrainnings() -> Array<Dictionary<String,AnyObject>> {
        let path = Bundle.main.path(forResource: "pushups", ofType: "json")
        
        let data =  try! Data.init(contentsOf: URL(fileURLWithPath: path!))
        
        
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let dic = json as! Dictionary<String,Array<Dictionary<String,AnyObject>>>
        return dic["datas"]!
    }
    class func getTrainnings( days : Int = shareUtil.trainningDay) -> Dictionary<TrainningKey,AnyObject> {
        
        
       let a  = self.getAllTrainnings()[days]
    var finalDic = Dictionary<TrainningKey,AnyObject>()
    for (key,value) in a {
        
        
        finalDic[TrainningKey.init(rawValue: key)!] = value
    }
    return finalDic
    }
    
    
    
    
    class func getData(key:TrainningKey) -> Int {
        let tranningDay = UserDefaults.standard.object(forKey: key.rawValue)
        
        if let train = tranningDay as? Int {
            return train
        }else if let train = tranningDay as?NSDictionary{
            
            return train["\(shareUtil.trainningDay)"] as? Int ?? 0
            
        }
        
        return  0
        
    }
    class func saveData<T>(key:TrainningKey,value:T){
        UserDefaults.standard .set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    class func trainningComplete(){
        print(NSHomeDirectory())
        shareUtil.TotalTrainTime = shareUtil.TotalTrainTime+1
        shareUtil.trainningTime  = shareUtil.trainningTime+1
        shareUtil.trainningDay   = shareUtil.trainningDay+1
        
    }
}
