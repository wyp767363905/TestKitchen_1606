//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //json文件对应的数组
    
    private var array: Array<Dictionary<String,String>>? {
        
        get {
            //读文件
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            
            var myArray: Array<Dictionary<String,String>>? = nil
            if let filePath = path {
                
                let data = NSData(contentsOfFile: filePath)
                
                if let jsonData = data {
                    
                    do {
                        
                        let jsonValue = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        if jsonValue.isKindOfClass(NSArray.self) {
                            
                            myArray = jsonValue as? Array<Dictionary<String,String>>
                            
                        }
                        
                    }catch {
                        //程序出现异常
                        print(error)
                        return nil
                        
                    }
                    
                }
                
            }
            
            return myArray
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建视图控制器
        //Swift里面,一般在类的内部调用属性和方法的时候,可以不写self
        createViewControllers()
        
    }
    
    //创建视图控制器
    func createViewControllers(){
        
        var ctrlNames = [String]()
        
        if let tmpArray = self.array {
            //json文件的数据解析成功
            //并且数组里面有数据
            for dict in tmpArray {
                
                let name = dict["ctrlName"]
                ctrlNames.append(name!)
                
            }
        }else{
            
            ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            
        }
        
        
        
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
