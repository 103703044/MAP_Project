//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    @IBOutlet var runner3: UILabel!
    @IBOutlet var runner2: UILabel!
    @IBOutlet var runner1: UILabel!
    @IBOutlet var batter: UILabel!

    
    @IBAction func toNextBase(sender: AnyObject) {
        //3to4
        UIView.animate(withDuration: 0.5,animations: {
            self.runner3.center.x = 232
            self.runner3.center.y = 260
            
        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner3.center.x = 131
            self.runner3.center.y = 180
        })
       //2to3
        UIView.animate(withDuration: 0.5,animations: {
            self.runner2.center.x = 131
            self.runner2.center.y = 180

        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner2.center.x = 232
            self.runner2.center.y = 104
        })
        //1to2
        UIView.animate(withDuration: 0.5,animations: {
            self.runner1.center.x = 232
            self.runner1.center.y = 104
            
        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner1.center.x = 334
            self.runner1.center.y = 185
        })
        //0to1
        UIView.animate(withDuration: 0.5,animations: {
            self.batter.center.x = 334
            self.batter.center.y = 185
            
        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.batter.center.x = 210
            self.batter.center.y = 260
        })
        
    }

    /*
    @IBOutlet var oneTapForSrike: UITapGestureRecognizer!

    @IBAction func hit(_ sender: Any) {
        
    }
    @IBOutlet weak var hitResult: UIView!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
 
    @IBAction func buttonClicked(sender: AnyObject) {
    }
 */
    override func viewDidLoad() {
        /*
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["FO","AO","1B","2B","3B","HR","FC","SF","SH","DP","TP"]
        // Do any additional setup after loading the view, typically from a nib.
 */
 }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
 */

}
