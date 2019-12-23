//
//  Record.swift
//  HRCrawler
//
//  Created by sam on 2019/12/23.
//  Copyright © 2019 sam. All rights reserved.
//

import Foundation

class Record {
    var title = String()
    var date = String()
    var readNum = String()
    var url:URL?
    init(_ title:String, _ date:String, _ readNum:String, _ urlStr:String) {
        self.title = title
        self.date = date
        self.readNum = readNum
        self.url = URL(string: "https://hr.nju.edu.cn" + urlStr)
    }
}
