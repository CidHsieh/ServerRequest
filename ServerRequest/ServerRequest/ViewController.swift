//
//  ViewController.swift
//  ServerRequest
//
//  Created by Cid Hsieh on 2017/5/12.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var array = NSDictionary()
    var origin = ""
    
    @IBOutlet weak var myLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getButtonDidPressed(_ sender: UIButton) {
        let url = "https://httpbin.org/get"
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                self.array = json as! NSDictionary
                if let tempOrigein = self.array["origin"] as? String {
                    self.origin = tempOrigein
                    print(self.origin)
                    self.myLabel.text = "\(self.origin)"
                }
            }
        }
    }
    
    @IBAction func postButtonDidPressed(_ sender: UIButton) {
        let postTime = getTime()
        
        var postTimeDate = Date()
        var responseTimeDate = Date()
        let parameter:Parameters = ["time":"\(postTime)"]
        let url = "https://httpbin.org/post"
        
        Alamofire.request(url, method: .post, parameters: parameter).responseJSON { response in
            if let json = response.result.value {
                print(json)
                let responseTime = self.getTime()
                print("response time" + responseTime)
                responseTimeDate = self.convertStringToDate(dateConvert: responseTime)
                let timeIntrval = responseTimeDate.timeIntervalSince(postTimeDate)
                
                print(timeIntrval)
                self.myLabel.text = "花了\(timeIntrval)秒"
            }
        }
        print("post time" + postTime)
        postTimeDate = convertStringToDate(dateConvert: postTime)
        
    }
    

    func getTime(format:String = "yyyy/MM/dd HH:mm:ss.SSSS") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    func convertStringToDate(dateConvert: String) -> Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSS"
        if let tempDate = dateFormatter.date(from: dateConvert) {
            date = tempDate
        }
        return date
    }


}

