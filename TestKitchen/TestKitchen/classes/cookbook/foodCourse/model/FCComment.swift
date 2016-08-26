//
//  FCComment.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 1606. All rights reserved.
//

import UIKit

import SwiftyJSON

class FCComment: NSObject {
    
    var code: String?
    var msg: String?
    var version: String?
    var timestamp: NSNumber?
    var data: FCCommentData?
    
    class func parseModelData(data: NSData) -> FCComment {
        
        let jsonData = JSON(data: data)
        
        let commentModel = FCComment()
        commentModel.code = jsonData["code"].string
        commentModel.msg = jsonData["msg"].string
        commentModel.version = jsonData["version"].string
        commentModel.timestamp = jsonData["timestamp"].number
        
        commentModel.data = FCCommentData.parseModel(jsonData["data"])
        
        return commentModel
        
    }
    
}

class FCCommentData: NSObject {
    
    var page: String?
    var size: String?
    var total: String?
    var count: String?
    var data: Array<FCCommentDetail>?
    
    class func parseModel(jsonData: JSON) -> FCCommentData {
        
        let dataModel = FCCommentData()
        
        dataModel.page = jsonData["page"].string
        dataModel.size = jsonData["size"].string
        dataModel.total = jsonData["total"].string
        dataModel.count = jsonData["count"].string
        
        var array = Array<FCCommentDetail>()
        for (_,subjson) in jsonData["data"] {
            let model = FCCommentDetail.parseModel(subjson)
            array.append(model)
        }
        dataModel.data = array
        
        return dataModel
        
    }
    
}

class FCCommentDetail: NSObject {
    
    var id: String?
    var user_id: String?
    var type: String?
    
    var relate_id: String?
    var content: String?
    var create_time: String?
    
    var parent_id: String?
    var parents: Array<FCCommentDetail>?
    var nick: String?
    
    var head_img: String?
    var istalent: NSNumber?
    
    class func parseModel(jsonData: JSON) -> FCCommentDetail {
        
        let model = FCCommentDetail()
        
        model.id = jsonData["id"].string
        model.user_id = jsonData["user_id"].string
        model.type = jsonData["type"].string
        
        model.relate_id = jsonData["relate_id"].string
        model.content = jsonData["content"].string
        model.create_time = jsonData["create_time"].string
        
        model.parent_id = jsonData["parent_id"].string
        model.nick = jsonData["nick"].string
        model.head_img = jsonData["head_img"].string
        model.istalent = jsonData["istalent"].number
        
        var array = Array<FCCommentDetail>()
        for (_,subjson) in jsonData["parents"] {
            let pModel = FCCommentDetail.parseModel(subjson)
            array.append(pModel)
        }
        model.parents = array
        
        return model
        
    }
    
}





