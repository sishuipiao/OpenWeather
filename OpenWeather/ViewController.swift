//
//  ViewController.swift
//  OpenWeather
//
//  Created by Steven on 14/11/27.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var responseArray:NSArray?
    var areaid:String?
    var name:String?
    
    @IBOutlet weak var abbrevLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(self.name!)各项指数详情"
        
        var type = "index_v"
        var urlString = HttpResponse.getJson(self.areaid!, type: type)
        
        var manager = AFHTTPRequestOperationManager()
        var json:NSDictionary = NSDictionary()
        manager.GET(urlString, parameters: nil, success: { (operation, responseObject) -> Void in
            var jsonDic = responseObject as! NSDictionary
            println("JSON:\(jsonDic)")
            self.responseArray = jsonDic.objectForKey("i") as? NSArray
            var dic:NSDictionary = self.responseArray![0] as! NSDictionary
            self.abbrevLabel.text = dic.objectForKey("i1") as? String
            self.nameLabel.text = dic.objectForKey("i2") as? String
            self.levelLabel.text = dic.objectForKey("i4") as? String
            self.contentLabel.text = dic.objectForKey("i5") as? String
            }) { (operation, error) -> Void in
                println("error:\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segMentValueChanged(sender: UISegmentedControl) {
        var index = sender.selectedSegmentIndex
        var dic:NSDictionary = self.responseArray![index] as! NSDictionary
        self.abbrevLabel.text = dic.objectForKey("i1") as? String
        self.nameLabel.text = dic.objectForKey("i2") as? String
        self.levelLabel.text = dic.objectForKey("i4") as? String
        self.contentLabel.text = dic.objectForKey("i5") as? String
    }
}

