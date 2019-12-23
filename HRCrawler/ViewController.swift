//
//  ViewController.swift
//  HRCrawler
//
//  Created by sam on 2019/12/23.
//  Copyright © 2019 sam. All rights reserved.
//

import UIKit
import SwiftSoup
class HRViewController: UITableViewController, URLSessionDelegate {
    var htmlDocument:Document?
    var pageInfo = PageInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let url = URL(string: "https://hr.nju.edu.cn/")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let configuration = URLSessionConfiguration.default
             
            let session = URLSession(configuration: configuration,
                                       delegate: self, delegateQueue:OperationQueue.main)
             
            let dataTask = session.dataTask(with: request,
                           completionHandler: {
                            data, response, error -> Void in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            if let data = data,
                                let str = String(data: data, encoding: String.Encoding.utf8) {
                                do {
                                    self.htmlDocument = try SwiftSoup.parse(str)
                                    self.parseHRFile()
                                } catch {
                                    print("html parsing failed")
                                }
                            }
                        }
            })
             
            //使用resume方法启动任务
            dataTask.resume()
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }

    func parseHRFile() {
        do {
            if let htmlDocument = htmlDocument {
                print("parsing html")
                let els: Elements = try htmlDocument.getElementsByClass("news_list")
                var index = 0
                for section:Element in els.array() {
                    let titleElements = try section.getElementsByClass("news_title")
                    //print(record)
                    //print(titles)
                    let dateElements = try section.getElementsByClass("news_meta")
                    let readNumElements = try section.getElementsByClass("news_meta1")
                    var titles = [String]()
                    var dates = [String]()
                    var readNums = [String]()
                    for titleElement in  titleElements {
                        var title = try titleElement.child(0).attr("title")
                        titles.append(title)
                    }
                    for dateElement in dateElements {
                        dates.append(try dateElement.text())
                    }
                    for readNumElement in readNumElements {
                        readNums.append(try readNumElement.text())
                    }
                    pageInfo.addSection(titles,dates,readNums, to:index)
                    index += 1
                    //pageInfo.addRecord(recordText, toSection:pageInfo.hrNotifications)
                }
                print("parse Done")
                self.tableView.reloadData()
            }
        } catch Exception.Error(let type, let message){
            print(message)
        } catch {
            print("error")
        }
    }
    
}

extension HRViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageInfo.getSectionRowCount(section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        // Configure the cell...
        if let cell = cell as? NewsCell {
            cell.record = pageInfo.getRecord(indexPath.section, indexPath.row)
            cell.textLabel?.text = cell.record!.title

        }
        return cell
    }
}
