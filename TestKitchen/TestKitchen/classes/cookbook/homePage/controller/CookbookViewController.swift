//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {
    
    //滚动视图
    var scrollView: UIScrollView?
    
    //食材首页的推荐视图
    private var recommendView: CBRecommendView?
    
    //首页的食材视图
    private var foodView: CBMaterialView?
    
    //首页的分类视图
    private var categoryView: CBMaterialView?
    
    //导航的标题视图
    private var segCtrl: KTCSegmentCtrl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        createMyNav()
        
        //初始化视图
        createHomePageView()
        
        //下载推荐的数据
        downloadeRecommendData()
        
        //下载食材的数据
        downloadFoodData()
        
        //下载分类的数据
        downloaderCategoryData()
        
    }
    
    //下载分类的数据
    func downloaderCategoryData(){
        
        let params = ["methodName":"CategoryIndex"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Category
        
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    
    //下载食材的数据
    func downloadFoodData(){
        
        let dict = ["methodName":"MaterialSubtype"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .FoodMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //初始化视图
    func createHomePageView(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        //1.创建一个滚动视图
        scrollView = UIScrollView()
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        //设置代理
        scrollView?.delegate = self
        view.addSubview(scrollView!)
        //约束
        scrollView?.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //2.创建容器视图
        let containerView = UIView.createView()
        scrollView?.addSubview(containerView)
        
        //约束
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        
        //3.添加子视图
        
        //3.1推荐
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        
        //约束
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
        })
        
        //3.2.食材
        foodView = CBMaterialView()
        containerView.addSubview(foodView!)
        
        //约束
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        //3.3.分类
        categoryView = CBMaterialView()
        containerView.addSubview(categoryView!)
        
        //约束
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
    }
    
    //下载推荐的数据
    func downloadeRecommendData() {
        
        let dict = ["methodName":"SceneHome"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Recommend
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //创建导航
    func createMyNav() {
        
        //标题位置
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44), titleNames: ["推荐","食材","分类"])
        
        segCtrl?.delegate = self
        
        navigationItem.titleView = segCtrl
        
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
    
    //MARK: 首页推荐部分的方法
    //食材课程分集显示
    func gotoFoodCoursePage(link: String){
        
        //第一个#
        let startRange = NSString(string: link).rangeOfString("#")
        
        //第二个#
        let endRang = NSString(string: link).rangeOfString("#", options: NSStringCompareOptions.BackwardsSearch, range: NSMakeRange(0, link.characters.count), locale: nil)
        
        let id = NSString(string: link).substringWithRange(NSMakeRange(startRange.location+1, endRang.location-startRange.location-1))
        
        //跳转界面
        let foodCourseCtrl = FoodCourseViewController()
        foodCourseCtrl.serialId = id
        navigationController?.pushViewController(foodCourseCtrl, animated: true)
        
    }
    
    //显示首页推荐的数据
    func showRecommendData(model: CBRecommendModel){
        
        recommendView?.model = model
        
        //点击事件
        recommendView?.clickClosure = {
            [weak self]
            (title: String?, link: String) in
            
            if link.hasPrefix("app://food_course_series") == true {
                
                //食材课程分集显示
                self!.gotoFoodCoursePage(link)
                
            }
            
        }
        
    }
    
    //MARK: 首页食材
    
    //MARK: 首页分类

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
        
        if let jsonData = data {

            if downloader.type == .Recommend {
                //推荐
                let model = CBRecommendModel.parseModel(jsonData)
                
                //显示数据
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.showRecommendData(model)
                    })
            }else if downloader.type == .FoodMaterial {
                //食材
                let model = CBMaterialModel.parseModelWithData(jsonData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.foodView?.model = model
                })
                
            }else if downloader.type == .Category {
                //分类
                let model = CBMaterialModel.parseModelWithData(jsonData)
                
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self] in
                    self!.categoryView?.model = model
                })
            }
        
        }
        
    }
    
}

extension CookbookViewController : KTCSegmentCtrlDelegate {
    
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int) {
        
        scrollView?.contentOffset = CGPointMake(kScreenWidth*CGFloat(index), 0)
        
    }
    
}

extension CookbookViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        //修改标题选中的按钮
        segCtrl?.selectIndex = index
    }
    
}




