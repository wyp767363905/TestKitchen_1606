//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createMyNav()
        
        downloadeRecommendData()
        
    }
    
    //下载推荐的数据
    func downloadeRecommendData() {
        
        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //创建导航
    func createMyNav() {
        
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        
        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
    }
    
    //扫一扫
    func scanAction() {
        
    }
    
    //搜索
    func searchAction() {
        
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

//MARK: KTCDownloader代理
extension CookbookViewController : KTCDownloaderDelegate{
    
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str!)
        
    }
    
}






