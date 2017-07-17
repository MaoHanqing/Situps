//
//  BasicNavigationViewController.swift
//  Situps
//
//  Created by 毛汉卿 on 2017/6/25.
//  Copyright © 2017年 毛汉卿. All rights reserved.
//

import UIKit

class BasicNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white ]
        
        
        
        // Do any additional setup after loading the view.
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
