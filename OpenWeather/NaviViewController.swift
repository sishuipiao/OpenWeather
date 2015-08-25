//
//  NaviViewController.swift
//  OpenWeather
//
//  Created by Steven on 14/12/24.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

import UIKit

class NaviViewController: UIViewController ,UIPickerViewDataSource ,UIPickerViewDelegate{

    var db:FMDatabase!
    var provinceArray:NSArray!
    var districtArray:NSArray!
    var nameArray:NSArray!
    var name = "北京"
    var areaId = "101010100"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var moView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var filePath = NSBundle.mainBundle().pathForResource("AreaId", ofType: "db")
        self.db = FMDatabase(path: filePath)
        
        self.db.open()
        //搜索省名，去掉重复名称
        var rs1:FMResultSet = self.db.executeQuery("Select Distinct province from allValues", withArgumentsInArray: nil)
        var array1 = NSMutableArray()
        while rs1.next() {
            var string = rs1.stringForColumn("province")
            array1.addObject(string)
        }
        self.provinceArray = array1
        //搜索市名
        var province = array1[0] as! String
        var array2 = NSMutableArray()
        var rs2:FMResultSet = self.db.executeQuery("Select Distinct district from allValues where province like '\(province)'", withArgumentsInArray: nil)
        while rs2.next() {
            var string = rs2.stringForColumn("district")
            array2.addObject(string)
        }
        self.districtArray = array2
        //搜索县名
        var district = array2[0] as! String
        var array3 = NSMutableArray()
        var rs3:FMResultSet = self.db.executeQuery("Select name from allValues where district like '\(district)'", withArgumentsInArray: nil)
        while rs3.next() {
            var string = rs3.stringForColumn("name")
            array3.addObject(string)
        }
        self.nameArray = array3
        
        self.db.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.provinceArray.count
        }else if component == 1 {
            return self.districtArray.count
        }else {
            return self.nameArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0 {
            return self.provinceArray.objectAtIndex(row) as! String
        }else if component == 1 {
            return self.districtArray.objectAtIndex(row) as! String
        }else {
            return self.nameArray.objectAtIndex(row) as! String
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            
            var province = self.provinceArray.objectAtIndex(row) as! String
            var array2 = NSMutableArray()
            var rs2:FMResultSet = self.db.executeQuery("Select Distinct district from allValues where province like '\(province)'", withArgumentsInArray: nil)
            while rs2.next() {
                var string = rs2.stringForColumn("district")
                array2.addObject(string)
            }
            self.districtArray = array2
            
            var district = array2.objectAtIndex(0) as! String
            var array3 = NSMutableArray()
            var rs3:FMResultSet = self.db.executeQuery("Select name from allValues where district like '\(district)'", withArgumentsInArray: nil)
            while rs3.next() {
                var string = rs3.stringForColumn("name")
                array3.addObject(string)
            }
            self.nameArray = array3
            
            var name = array3.objectAtIndex(0) as! String
            var rs4:FMResultSet = self.db.executeQuery("Select areaid from allValues where name like '\(name)'", withArgumentsInArray: nil)
            while rs4.next() {
                var string = rs4.stringForColumn("areaid")
                self.areaId = string
                println(self.areaId)
            }
            self.nameLabel.text = name
            self.name = name
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1 {
            
            var district = self.districtArray.objectAtIndex(row) as! String
            var array3 = NSMutableArray()
            var rs3:FMResultSet = self.db.executeQuery("Select name from allValues where district like '\(district)'", withArgumentsInArray: nil)
            while rs3.next() {
                var string = rs3.stringForColumn("name")
                array3.addObject(string)
            }
            self.nameArray = array3
            
            var name = array3.objectAtIndex(0) as! String
            var rs4:FMResultSet = self.db.executeQuery("Select areaid from allValues where name like '\(name)'", withArgumentsInArray: nil)
            while rs4.next() {
                var string = rs4.stringForColumn("areaid")
                self.areaId = string
                println(self.areaId)
            }
            self.nameLabel.text = name
            self.name = name
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else {
            var index = pickerView.selectedRowInComponent(2)
            var name = self.nameArray.objectAtIndex(index) as! String
            var rs4:FMResultSet = self.db.executeQuery("Select areaid from allValues where name like '\(name)'", withArgumentsInArray: nil)
            while rs4.next() {
                var string = rs4.stringForColumn("areaid")
                self.areaId = string
                println(self.areaId)
            }
            println(self.areaId)
            self.nameLabel.text = name
            self.name = name
        }
    }
    
    @IBAction func chooseCity(sender: AnyObject) {
        self.moView.hidden = false
        self.db.open()
    }

    @IBAction func makeSure(sender: AnyObject) {
        self.moView.hidden = true
        self.db.close()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ZhiShu"{
            var page = segue.destinationViewController as! ViewController
            page.areaid = self.areaId
            page.name = self.name
        }else if segue.identifier == "YuBao" {
            var page = segue.destinationViewController as! ForecastViewController
            page.areaid = self.areaId
            page.name = self.name
        }
    }
}
