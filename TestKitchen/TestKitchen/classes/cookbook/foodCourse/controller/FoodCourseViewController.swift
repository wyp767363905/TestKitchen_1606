//
//  FoodCourseViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

import AVFoundation

import AVKit

class FoodCourseViewController: BaseViewController {

    //id
    var serialId: String?
    
    //表格视图
    private var tbView: UITableView?
    
    //食材课程的数据
    private var serialModel: FoodCourseModel?
    
    //当前选择的集数的序号
    private var serialIndex: Int = 0
    
    //集数的cell是合起还是展开
    private var serialIsExpand: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        createMyNav()
        
        //表格
        createTableView()
        
        //下载食课数据
        downloadFoodCourseData()
        
    }
    
    //下载食课数据
    func downloadFoodCourseData(){
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.32
        
        if serialId == nil {
            return
        }
        
        //参数
        var dict = Dictionary<String,String>()
        dict["methodName"] = "CourseSeriesView"
        dict["series_id"] = serialId!
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .FoodCourse
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //导航
    func createMyNav(){
        
        //返回按钮
        addNavBackBtn()
        
    }
    
    //表格
    func createTableView(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        tbView = UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        view.addSubview(tbView!)
        
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

extension FoodCourseViewController : KTCDownloaderDelegate {
    
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .FoodCourse {
            //食材课程数据
            if let jsonData = data {
                let model = FoodCourseModel.parseModelWithData(jsonData)
                serialModel = model
            }
            
            //回到主线程刷新
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self!.tbView?.reloadData()
            })
        }else if downloader.type == .FoodCourseComment {
            //评论数据
        }
        
    }
    
}

extension FoodCourseViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 0
        
        if section == 0 {
            //食材数据
            if serialModel?.data?.data?.count > 0 {
                rowNum = 3
            }
        }else if section == 1 {
            
        }
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                //视频的cell
                height = 160
            }else if indexPath.row == 1 {
                //课程的标题和描述
                if serialModel?.data?.data?.count > 0 {
                    let model = serialModel?.data?.data![serialIndex]
                    height = FCCourseCell.heightWithModel(model!)
                }
            }else if indexPath.row == 2 {
                //集数
                height = FCSerialCell.heightWithNum((serialModel?.data?.data?.count)!, isExpand: serialIsExpand)
                
            }
            
        }else if indexPath.section == 1 {
            
        }
        
        return height
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            //获取模型对象
            let dataModel = serialModel?.data?.data![serialIndex]
            
            //食材课程的数据
            if indexPath.row == 0 {
                //视频的cell
                cell = createVideoCellForTableVie(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 1 {
                //课程名称和描述
                cell = createCoureCellForTableView(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 2 {
                //集数
                cell = createSerialCellForTableView(tableView, atIndexPath: indexPath, withModel: serialModel!)
            }
            
        }else if indexPath.section == 1 {
            
        }
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    /** 创建视频的cell*/
    func createVideoCellForTableVie(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: FoodCourseSerialModel) -> FCVideoCell {
        
        //视频的cell
        let cellId = "videoCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
        }
        
        //显示数据
        cell?.model = model
        
        cell?.videoClosure = {
            urlString in
            print(urlString)
            let url = NSURL(string: urlString)
            let player = AVPlayer(URL: url!)
            let playerCtrl = AVPlayerViewController()
            playerCtrl.player = player
            
            //播放
            player.play()
            
            //显示视频控制器
            self.presentViewController(playerCtrl, animated: true, completion: nil)
            
        }
        
        return cell!
        
    }
    
    
    /** 创建课程和描述文字的cell*/
    func createCoureCellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model:FoodCourseSerialModel) -> FCCourseCell {
        
        let cellId = "courseCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCourseCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("FCCourseCell", owner: nil, options: nil).last as? FCCourseCell
        }
        
        cell?.model = model
        
        return cell!
        
    }
    
    /** */
    func createSerialCellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: FoodCourseModel) -> FCSerialCell {
        
        let cellId = "serialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
        
        if nil == cell {
            cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
        }
        
        //代理
        cell?.delegate = self
        
        //修改展开状态
        cell?.isExpand = serialIsExpand
        //显示数据
        cell?.num = model.data?.data?.count
        //设置选中的序号
        cell?.selectIndex = serialIndex
        
        return cell!
        
    }
    
}

extension FoodCourseViewController : FCSerialCellDelegate {
    
    func didSelectSerialAtIndex(index: Int) {
        //修改当前选择集数的序号
        serialIndex = index
        
        //刷新表格的第一个section
        tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        
    }
    
    func changeExpandState(isExpand: Bool) {
        serialIsExpand = isExpand
        
        //刷新表格
        tbView?.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
    }
    
}













