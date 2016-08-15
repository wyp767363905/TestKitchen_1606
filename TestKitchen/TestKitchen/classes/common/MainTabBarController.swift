//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建视图控制器
        //Swift里面,一般在类的内部调用属性和方法的时候,可以不写self
        createViewControllers()
        
    }
    
    //创建视图控制器
    func createViewControllers(){
        
        let  ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        
        var vCtrlArray = Array<UINavigationController>()
        
        for i in 0..<ctrlNames.count {
            
            //创建视图控制器
            let ctrlName = "TestKitchen." + ctrlNames[i]
            
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            
            //导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            
            vCtrlArray.append(navCtrl)
            
        }
        
        self.viewControllers = vCtrlArray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
