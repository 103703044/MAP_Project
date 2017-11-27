//
//  DatePick.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/11/6.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DatePickController: UIViewController{
    
    
    @IBOutlet var displayDate: UILabel!
    @IBOutlet weak var gameDay: UIDatePicker!
func datePickerChanged(datePicker:UIDatePicker) {
    // 設置要顯示在 UILabel 的日期時間格式
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    // 更新 UILabel 的內容
    displayDate.text = formatter.string(
        from: datePicker.date)
}
}
