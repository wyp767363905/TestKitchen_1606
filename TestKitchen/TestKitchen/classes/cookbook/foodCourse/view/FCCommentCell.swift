//
//  FCCommentCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class FCCommentCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //显示数据
    var model: FCCommentDetail? {
        
        didSet {
            
            if model != nil {
                showData()
            }
            
        }
        
    }
    
    func showData(){
        
        //图片
        let url = NSURL(string:  (model?.head_img)!)
        userImageView.layer.cornerRadius = 30
        userImageView.layer.masksToBounds = true
        userImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //名字
        nameLabel.text = model?.nick
        
        //内容
        contentLabel.text = model?.content
        
        //时间
        timeLabel.text = model?.create_time
        
    }
    
    @IBAction func reportAction(sender: UIButton) {
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
