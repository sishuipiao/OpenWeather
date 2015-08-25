//
//  ForecastViewController.swift
//  OpenWeather
//
//  Created by Steven on 14/12/24.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    var cityInfo:NSDictionary?
    var forecastInfo:NSArray?
    var areaid:String?
    var name:String?
    
    @IBOutlet weak var forecastTimeLabel: UILabel!
    @IBOutlet weak var sunRiseSetLabel: UILabel!
    @IBOutlet weak var WweaLabel: UILabel!
    @IBOutlet weak var BweaLabel: UILabel!
    @IBOutlet weak var WtemLabel: UILabel!
    @IBOutlet weak var BtemLabel: UILabel!
    @IBOutlet weak var WwindDirLabel: UILabel!
    @IBOutlet weak var BwindDirLabel: UILabel!
    @IBOutlet weak var WwindPowLabel: UILabel!
    @IBOutlet weak var BwindPowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(self.name!)最近三天天气预报"
        
        var type = "forecast_v"
        var urlString = HttpResponse.getJson(self.areaid!, type: type)
        
        var manager = AFHTTPRequestOperationManager()
        var json:NSDictionary = NSDictionary()
        manager.GET(urlString, parameters: nil, success: { (operation, responseObject) -> Void in
            var jsonDic = responseObject as! NSDictionary
            var foreCastDic = jsonDic.objectForKey("f") as? NSDictionary
            self.forecastInfo = foreCastDic!.objectForKey("f1") as? NSArray
            var timeString = foreCastDic!.objectForKey("f0") as? String
            if timeString != nil {
                var i = 0
                var sum = ""
                for Character in timeString! {
                    sum += "\(Character)"
                    ++i
                    if i == 4 {
                        sum += "年"
                    }else if i == 6 {
                        sum += "月"
                    }else if i == 8 {
                        sum += "日"
                    }else if i == 10 {
                        sum += ":"
                    }
                }
                self.forecastTimeLabel.text = sum
            }
            var dic1 = self.forecastInfo?.objectAtIndex(0) as! NSDictionary
            self.WweaLabel.text = WeatherCode.getWeather(dic1.objectForKey("fa") as! String)
            self.BweaLabel.text = WeatherCode.getWeather(dic1.objectForKey("fb") as! String)
            self.WtemLabel.text = dic1.objectForKey("fc") as? String
            self.WtemLabel.text! += "℃"
            self.BtemLabel.text = dic1.objectForKey("fd") as? String
            self.BtemLabel.text! += "℃"
            self.WwindDirLabel.text = WeatherCode.getWindDirect(dic1.objectForKey("fe") as! String)
            self.BwindDirLabel.text = WeatherCode.getWindDirect(dic1.objectForKey("ff") as! String)
            self.WwindPowLabel.text = WeatherCode.getWindLevel(dic1.objectForKey("fg") as! String)
            self.BwindPowLabel.text = WeatherCode.getWindLevel(dic1.objectForKey("fh")as! String)
            self.sunRiseSetLabel.text = dic1.objectForKey("fi") as? String
            println("JSON:\(jsonDic)")
            }) { (operation, error) -> Void in
                println("error:\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        var index = sender.selectedSegmentIndex
        var dic1 = self.forecastInfo?.objectAtIndex(index) as! NSDictionary
        self.WweaLabel.text = WeatherCode.getWeather(dic1.objectForKey("fa") as! String)
        self.BweaLabel.text = WeatherCode.getWeather(dic1.objectForKey("fb") as! String)
        self.WtemLabel.text = dic1.objectForKey("fc") as? String
        self.WtemLabel.text! += "℃"
        self.BtemLabel.text = dic1.objectForKey("fd") as? String
        self.BtemLabel.text! += "℃"
        self.WwindDirLabel.text = WeatherCode.getWindDirect(dic1.objectForKey("fe") as! String)
        self.BwindDirLabel.text = WeatherCode.getWindDirect(dic1.objectForKey("ff") as! String)
        self.WwindPowLabel.text = WeatherCode.getWindLevel(dic1.objectForKey("fg") as! String)
        self.BwindPowLabel.text = WeatherCode.getWindLevel(dic1.objectForKey("fh") as! String)
        self.sunRiseSetLabel.text = dic1.objectForKey("fi") as? String
    }
}
