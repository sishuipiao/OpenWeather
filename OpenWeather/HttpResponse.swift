//
//  HttpResponse.swift
//  OpenWeather
//
//  Created by Steven on 14/12/24.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

import UIKit
let appid = "4bc7df1c018e2777"
let privateKey = "70d1a7_SmartWeatherAPI_8b7f316"
class HttpResponse: NSObject {
    //type:index_f(基础接口)；index_v(常规接口) 3天预报:forecast_f(基础接口)；forecast_v(常规接口)
    class func getJson(areaid:String,type:String) -> String {
        var dateFormat:NSDateFormatter = NSDateFormatter();
        dateFormat.dateFormat = "yyyyMMddHHmm"
        var time = dateFormat.stringFromDate(NSDate())
        
        let index = advance(appid.startIndex, 6)
        var sixApi = appid.substringToIndex(index)
        
        var urlhead = "http://open.weather.com.cn/data/?areaid=\(areaid)&type=\(type)&date=\(time)&appid=\(sixApi)"
        var publicKey = "http://open.weather.com.cn/data/?areaid=\(areaid)&type=\(type)&date=\(time)&appid=\(appid)"
        var key = SecurityUtil.hmacSha1(publicKey, privateKey) as NSString
        var encodePropert = key.URLEncodedString()
        var urlString = "\(urlhead)&key=\(encodePropert)"
        println(urlString)
        
        return urlString
    }
    
    //显示无代理，无title的Alert
    class func showAlertWith(alertString:String!) {
        var alert = UIAlertView(title: nil, message: alertString, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    
    //汉字转拼音
    class func getpinyin(hanzi:String!) -> String {
        if (hanzi.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0) {
            var string = CFStringCreateMutableCopy(nil, 0, hanzi)
            var re:Boolean = CFStringTransform(string, nil, kCFStringTransformMandarinLatin, 0)
            if re != 0 {
                
            }
            var res:Boolean = CFStringTransform(string, nil, kCFStringTransformStripDiacritics, 0)
            if res != 0 {
                
                return string as String
            }
        }
        return ""
    }
}
