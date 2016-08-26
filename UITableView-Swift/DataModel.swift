//
//  DataModel.swift
//  UITableView-Swift
//
//  Created by BO on 16/8/26.
//  Copyright © 2016年 YANGReal. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var isDone : Bool
    var dateStr : String
    
    init(withDateStr dateStr: String,isDone flag: Bool) {
        self.dateStr = dateStr
        self.isDone = flag
        super.init()
    }
    
}
