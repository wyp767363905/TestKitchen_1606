
//
//  CBMaterialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

class CBMaterialCell: UITableViewCell {
    
    var model: CBMaterialTypeModel?{
        
        didSet {
            
            //显示数据
            if model != nil {
                showData()
            }
            
        }
        
    }
    
    func showData(){
        
        //1.删除之前的子视图
        for oldSub in contentView.subviews {
            oldSub.removeFromSuperview()
        }
        
        //2.添加子视图
        //2.1标题
        let titleLabel = UILabel.createLabel((model?.text)!, font: UIFont.systemFontOfSize(20), textAlignment: .Left, textColor: UIColor.blackColor())
        titleLabel.frame = CGRectMake(20, 0, kScreenWidth-20*2, 40)
        contentView.addSubview(titleLabel)
        
        //横向间距
        let spaceX: CGFloat = 10
        //纵向间距
        let spaceY: CGFloat = 10
        //一共几列
        let colNum = 5
        //按钮高度
        let h: CGFloat = 40
        //按钮的宽度
        let w = (kScreenWidth-spaceX*CGFloat(colNum+1))/CGFloat(colNum)
        //y的偏移量
        let offsetY: CGFloat = 40
        
        //2.2图片
        let imageFrame = CGRectMake(spaceX, offsetY, w*2+spaceX, h*2+spaceY)
        let imageView = UIImageView.createImageView(nil)
        imageView.frame = imageFrame
        let url = NSURL(string: (model?.image)!)
        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(imageView)
        
        //2.3循环创建按钮
        if model?.data?.count > 0 {
            for i in 0..<(model?.data?.count)! {
                
                var btnFrame = CGRectZero
                if i < 6 {
                    //前两行的按钮
                    //行和列
                    let row = i/3
                    let col = i%3
                    btnFrame = CGRectMake(w*2+spaceX*3+CGFloat(col)*(w+spaceX), offsetY+CGFloat(row)*(h+spaceY), w, h)
                }else{
                    //后面几行的按钮
                    //行和列
                    let row = (i-6)/5
                    let col = (i-6)%5
                    btnFrame = CGRectMake(spaceX+CGFloat(col)*(w+spaceX), offsetY+2*(h+spaceY)+CGFloat(row)*(h+spaceY), w, h)
                }
                
                //按钮
                let btn = CBMaterialBtn(frame: btnFrame)
                let subModel = model?.data![i]
                btn.model = subModel
                contentView.addSubview(btn)
                
            }
        }
        
    }
    
    class func heighWithModel(model: CBMaterialTypeModel) -> CGFloat {
        
        var h: CGFloat = 0
        
        //标题高度
        let offsetY: CGFloat = 40
        //纵向间距
        let spaceY: CGFloat = 10
        //按钮的高度
        let btnH: CGFloat = 40
        
        if model.data?.count > 0 {
            if model.data?.count < 6 {
                
                h = offsetY+(btnH+spaceY)*2
                
            }else{
                
                h = offsetY+(btnH+spaceY)*2
                //计算有多少行
                var rowNum = ((model.data?.count)!-6)/5
                if ((model.data?.count)!-6)%5 > 0 {
                    rowNum += 1
                }
                h += CGFloat(rowNum)*(btnH+spaceY)
                
            }
        }
        
        return h
        
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

class CBMaterialBtn: UIControl {
    
    private var titleLabel: UILabel?
    
    //数据
    var model: CBMaterialSubtypeModel?{
        
        didSet {
            
            titleLabel?.text = model?.text
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        //文字
        titleLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(14), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = bounds
        titleLabel?.numberOfLines = 2
        titleLabel?.textColor = UIColor(white: 0.4, alpha: 1.0)
        titleLabel?.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








