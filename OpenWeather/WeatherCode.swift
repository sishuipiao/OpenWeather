//
//  WeatherCode.swift
//  OpenWeather
//
//  Created by Steven on 14/12/25.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

import UIKit

class WeatherCode: NSObject {
    class func getWeather(code:String) -> String {
        switch code {
        case "00": return "晴"
        case "01": return "多云"
        case "02": return "阴"
        case "03": return "阵雨"
        case "04": return "雷阵雨"
        case "05": return "雷阵雨伴有冰雹"
        case "06": return "雨夹雪"
        case "07": return "小雨"
        case "08": return "中雨"
        case "09": return "大雨"
        case "10": return "暴雨"
        case "11": return "大暴雨"
        case "12": return "特大暴雨"
        case "13": return "阵雪"
        case "14": return "小雪"
        case "15": return "中雪"
        case "16": return "大雪"
        case "17": return "暴雪"
        case "18": return "雾"
        case "19": return "冻雨"
        case "20": return "沙尘暴"
        case "21": return "小到中雨"
        case "22": return "中到大雨"
        case "23": return "大到暴雨"
        case "24": return "暴雨到大暴雨"
        case "25": return "大暴雨到特大暴雨"
        case "26": return "小到中雪"
        case "27": return "中到大雪"
        case "28": return "大到暴雪"
        case "29": return "浮尘"
        case "30": return "扬沙"
        case "31": return "强沙尘暴"
        case "53": return "霾"
        default: return "无"
        }
    }
    
    class func getWindDirect(code:String) -> String {
        switch code {
        case "0": return "无持续风向"
        case "1": return "东北风"
        case "2": return "东风"
        case "3": return "东南风"
        case "4": return "南风"
        case "5": return "西南风"
        case "6": return "西风"
        case "7": return "西北风"
        case "8": return "北风"
        default: return "旋转风"
        }
    }
    
    class func getWindLevel(code:String) -> String {
        switch code {
        case "0": return "微风"
        case "1": return "3-4级"
        case "2": return "4-5级"
        case "3": return "5-6级"
        case "4": return "6-7级"
        case "5": return "7-8级"
        case "6": return "8-9级"
        case "7": return "9-10级"
        case "8": return "10-11级"
        default: return "11-12级"
        }
    }
}
