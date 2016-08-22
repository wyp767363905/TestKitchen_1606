//
//  CBTalentCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBTalentCell: UITableViewCell {
    
    @IBOutlet weak var talentImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var fansLabel: UILabel!
    
    //显示数据
    var dataArray: Array<CBRecommendWidgetDataModel>?{
        
        didSet {
            
            showData()
            
        }
        
    }
    
    func showData(){
        
        //图片
        if dataArray?.count > 0 {
            let imageModel = dataArray![0]
            if imageModel.type == "image" {
                
                let url = NSURL(string: imageModel.content!)
                
                talentImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
            }
        }
        
        //名字
        if dataArray?.count > 1 {
            let nameModel = dataArray![1]
            if nameModel.type == "text" {
                
                nameLabel.text = nameModel.content
                
            }
        }
        
        //描述文字
        if dataArray?.count > 2 {
            let descModel = dataArray![2]
            if descModel.type == "text" {
                
                descLabel.text = descModel.content
                
            }
        }
        
        //粉丝数
        if dataArray?.count > 3 {
            let fansModel = dataArray![3]
            if fansModel.type == "text" {
                fansLabel.text = fansModel.content
            }
        }
        
    }
    
    //创建cell的方法
    class func createTalentCellFor(tableaView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel) -> CBTalentCell {
        
        let cellId = "talentCellId"
        var cell = tableaView.dequeueReusableCellWithIdentifier(cellId) as? CBTalentCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CBTalentCell", owner: nil, options: nil).last as? CBTalentCell
        }
        
        if listModel.widget_data?.count > indexPath.row*4+3 {
            let array = NSArray(array: listModel.widget_data!)
            let curArray = array.subarrayWithRange(NSMakeRange(indexPath.row*4, 4))
            cell?.dataArray = curArray as? Array<CBRecommendWidgetDataModel>
        }
        
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
