//
//  CBRedPacketCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBRedPacketCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    //显示数据
    var model: CBRecommendWidgetListModel?{
        
        didSet {
            
            showData()
            
        }
        
    }
    
    //显示图片和文字
    func showData(){
        
        //删除之前的子视图
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        scrollView.showsHorizontalScrollIndicator = false
        
        //1.容器视图
        let container = UIView.createView()
        scrollView.addSubview(container)
        
        container.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView.snp_height)
        }
        
        //2.循环添加图片
        var lastView: UIView? = nil
        let cnt = model?.widget_data?.count
        if cnt > 0 {
            for i in 0..<cnt! {
                
                let imageModel = model?.widget_data![i]
                
                if imageModel?.type == "image" {
                    
                    //显示在线图片
                    let imageview = UIImageView.createImageView(nil)
                    let url = NSURL(string: (imageModel?.content)!)
                    imageview.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    container.addSubview(imageview)
                    
                    //约束
                    imageview.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalTo(container)
                        make.width.equalTo(180)
                        if i == 0 {
                            make.left.equalTo(0)
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    
                    //添加点击事件
                    imageview.userInteractionEnabled = true
                    imageview.tag = 400+i
                    //手势
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                    imageview.addGestureRecognizer(g)
                    
                    lastView = imageview
                    
                }
                
            }
            
            //修改容器的大小
            container.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            
        }
        
    }
    
    func tapAction(g: UITapGestureRecognizer) {
        
        let index = (g.view?.tag)!-400
        print(index)
        
    }
    
    //创建cell的方法
    class func createRedPackegeCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel) -> CBRedPacketCell {
        
        let cellId = "redPacketCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRedPacketCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CBRedPacketCell", owner: nil, options: nil).last as? CBRedPacketCell
        }
        
        cell?.model = listModel
        
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









