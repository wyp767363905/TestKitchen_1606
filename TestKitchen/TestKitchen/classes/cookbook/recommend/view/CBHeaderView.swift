//
//  CBHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBHeaderView: UIView {
    
    //标题
    private var titleLabel: UILabel?
    
    //图片
    private var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景视图
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 10, bounds.size.width, bounds.size.height-10)
        addSubview(bgView)
        bgView.backgroundColor = UIColor.whiteColor()
        
        let titleW: CGFloat = 100
        let imagW: CGFloat = 24
        
        let x = (bounds.size.width-titleW-imagW)/2
        //标题文字
        titleLabel = UILabel.createLabel(nil, font: UIFont.boldSystemFontOfSize(18), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(x, 10, titleW, bounds.size.height-10)
        addSubview(titleLabel!)
        
        //右边图片
        imageView = UIImageView.createImageView("more_icon")
        imageView?.frame = CGRectMake(x+titleW, 14, imagW, imagW)
        addSubview(imageView!)
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
    }
    
    //显示标题
    func configTitle(title: String) {
        titleLabel?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
