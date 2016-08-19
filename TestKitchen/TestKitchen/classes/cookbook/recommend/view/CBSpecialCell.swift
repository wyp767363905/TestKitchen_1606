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
        
    }
    
    //进入类型的界面
    @IBAction func clickSceneBtn(sender: UIButton) {
    }
    
    @IBAction func clickDetailBtn(sender: UIButton) {
    }

    @IBAction func clickPlayBtn(sender: UIButton) {
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
