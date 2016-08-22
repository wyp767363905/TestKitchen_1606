//
//  CBSpecialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBSpecialCell: UITableViewCell {
    
    //显示数据
    var model: CBRecommendWidgetListModel?{
        
        didSet {
            
            showData()
            
        }
    }
    
    func showData(){
        
        //类型图片
        if model?.widget_data?.count > 0 {
            
            let imageModel = model?.widget_data![0]
            if imageModel?.type == "image" {
                
                //获取类型按钮
                let subView = contentView.viewWithTag(100)
                if subView?.isKindOfClass(UIButton.self) == true {
                    let sceneBtn = subView as! UIButton
                    
                    let url = NSURL(string: (imageModel?.content)!)
                    let dImage = UIImage(named: "sdefaultImage")
                    sceneBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    
                }
                
            }
            
        }
        
        //类型名字
        if model?.widget_data?.count > 1 {
            
            let nameModel = model?.widget_data![1]
            if nameModel?.type == "text" {
                
                //获取名字的lab
                let subView = contentView.viewWithTag(101)
                if subView?.isKindOfClass(UILabel.self) == true {
                    let nameLabel = subView as! UILabel
                    nameLabel.text = (nameModel?.content)!
                }
                
            }
            
        }
        
        //多少道菜
        if model?.widget_data?.count > 2 {
            
            let numModel = model?.widget_data![2]
            if numModel?.type == "text" {
                
                //获取label
                let subView = contentView.viewWithTag(102)
                if subView?.isKindOfClass(UILabel.self) == true {
                    let numLabel = subView as! UILabel
                    numLabel.text = (numModel?.content)!
                }
                
            }
            
        }
        
        //列举菜例的图片显示
        for i in 0..<4 {
            
            //图片数据在数组中的序号
            let index = i*2+3
            
            if model?.widget_data?.count > index {
                let imageModel = model?.widget_data![index]
                if imageModel?.type == "image" {
                    
                    //获取按钮视图
                    let subView = contentView.viewWithTag(200+i)
                    
                    if subView?.isKindOfClass(UIButton.self) == true {
                        let btn = subView as! UIButton
                        
                        let url = NSURL(string: (imageModel?.content)!)
                        
                        btn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        
                    }
                    
                }
            }
            
        }
        
        //描述文字
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self) == true {
            
            let descLabel = subView as! UILabel
            descLabel.text = (model?.desc)!
            
        }
        
    }
    
    //进入类型的界面
    @IBAction func clickSceneBtn(sender: UIButton) {
    }
    
    @IBAction func clickDetailBtn(sender: UIButton) {
    }

    @IBAction func clickPlayBtn(sender: UIButton) {
    }
    
    //创建cell的方法
    class func createSpecialCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel) -> CBSpecialCell {
        
        let cellId = "specialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSpecialCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CBSpecialCell", owner: nil, options: nil).last as? CBSpecialCell
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
