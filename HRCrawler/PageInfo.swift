//
//  PageInfo.swift
//  HRCrawler
//
//  Created by sam on 2019/12/23.
//  Copyright © 2019 sam. All rights reserved.
//

import Foundation
import SwiftSoup
class PageInfo {
    var hrNotifications = [Record]()
    var hrNews = [Record]()
    var announcements = [Record]()
    var jobInfo = [Record]()
    var urls = [String]()
    func addRecord(_ record:String, toSection section:[Record]) {
        var splitRecord = record.split(separator: " ")
        print(splitRecord)
    }
    func addSection(_ titles:[String], _ dates:[String], _ nums:[String],_ urls:[String], to section:Int) {
        for index in 0..<titles.count {
            switch section {
            case 0: hrNotifications.append(Record(titles[index],dates[index],nums[index], urls[index]))
            case 1: hrNews.append(Record(titles[index],dates[index],nums[index],urls[index]))
            case 2: announcements.append(Record(titles[index],dates[index],nums[index],urls[index]))
            case 3: jobInfo.append(Record(titles[index],dates[index],nums[index],urls[index]))
            default:break
            }
        }
    }
    func getSectionRowCount(_ sel:Int) -> Int {
        switch sel {
        case 0: return hrNotifications.count
        case 1: return hrNews.count
        case 2: return announcements.count
        case 3: return jobInfo.count
        default: return 1
        }
    }
    func getRecord(_ section:Int, _ row:Int) -> Record {
        switch section {
        case 0: return hrNotifications[row]
        case 1: return hrNews[row]
        case 2: return announcements[row]
        case 3:return jobInfo[row]
        default: return hrNotifications[0]
        }
    }
}
