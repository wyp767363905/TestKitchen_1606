//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBRecommendADCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    //数据
    var bannerArray: Array<CBRecommendBannerModel>?{
        
        didSet {
            
            //显示UI
            showData()
            
        }
        
    }
    
    func showData(){
        
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        //0.添加一个容器视图
        let containerView = UIView.createView()
        
        scrollView.addSubview(containerView)
        
        //设置约束
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView)
        }
        
        var lastView: UIView? = nil
        let cnt = bannerArray?.count
        if cnt > 0 {
            for i in 0..<cnt! {
                
                //1.获取模型对象
                let model = bannerArray![i]
                
                //2.创建图片
                let tmpImageView = UIImageView.createImageView(nil)
                
                //在线加载图片
                /*
                 第一个参数:图片网站的url
                 第二个参数:默认图片
                 第三个参数:选项
                 第四个参数:可以获取下载的进度
                 第五个参数:下载结束的时候的操作
                 */
                let url = NSURL(string: model.banner_picture!)
                let image = UIImage(named: "sdefaultImage")
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                //约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if (i == 0) {
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                
                lastView = tmpImageView
                
            }
            
            //修改容器的\视图的约束
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            
            //修改分页控件
            pageCtrl.numberOfPages = cnt!
            
            //设置代理
            scrollView.delegate = self
            scrollView.pagingEnabled = true
            
        }
        
    }
    
    //创建cell的方法
    class func createAdCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CBRecommendModel) -> CBRecommendADCell {
        
        let cellId = "recommendADCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendADCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        }
        
        //显示数据
        cell?.bannerArray = model.data?.banner
        
        return cell!
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: UIScrollView代理
extension CBRecommendADCell : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageCtrl.currentPage = index
        
    }
    
}








