//
//  KTCHomeViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

/** 这个类用来封装tabbar的显示和隐藏的方法*/
class KTCHomeViewController: BaseViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //显示tabbar
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true {
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.showTabbar()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //显示tabbar
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true {
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.showTabbar()
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //隐藏tabbar
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true {
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.hideTabbar()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
