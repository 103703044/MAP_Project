//
//  Function.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/10/13.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import Foundation
import UIKit
import Firebase
var ref:FIRDatabaseReference?


class Player{
    let playerRef = ref?.child("player")
    var name: String //名字
    var battingOrder: Int //棒次
    var number: Int? //背號
    var position: String //守備位置
    var team: String? //所屬隊伍
    
    var atBatOverall:Int?
    var atBat:Int = 0 //打擊次數
    var Run:Int = 0 //得分數
    var hit:Int = 0 //安打數
    var RBI:Int = 0 //打點數
    var BB:Int = 0 //保送數
    var SO:Int = 0 //三振數
    
    
    var IP:Float = 0.0 //投球局數
    var ER:Int = 0 //自責分
    var pitcherH:Int = 0 //被安打數
    var pitcherBB:Int = 0//保送數
    var pitcherSO:Int = 0//三振數
    
    init(as name: String ,position: String ,battingOrder : Int) {
        self.name = name
        self.position = position
        self.battingOrder = battingOrder
    }
    //取得打者名字
    func getName() -> String {
        return self.name
    }
    //增加打者安打數
    func addHit(){
        self.hit += 1
        self.atBat += 1
    }
    //增加打者出局數
    func addOut(){
        self.atBat += 1
    }
    //增加被安打數
    func addPitchH(){
        self.pitcherH += 1
    }
    //增加投球局數
    func addIP(){
        self.IP += 0.1
        if self.IP.truncatingRemainder(dividingBy: 1) == 0.3 {
            self.IP +=  -0.3 + 1
        }
    }
    //增加自責失分
    func addER(){
        self.ER += 1
    }
    //取得安打數
    func getHit() ->String{
        return String(self.hit)
    }
    //取得打擊數
    func getAtBat() -> String{
        return String(self.atBat)
    }
    func getAtBatOverall(AB:Int) -> Int{
        return AB
    }
    //取得打擊率
    func getBA() -> String{
        var BA:Float
        if self.atBat == 0{
            BA = 0.000
        }else{
            BA = Float(self.hit) / Float(self.atBat)
        }
        return String(format:"%.3f", BA )
    }
    //取得守備位置
    func getPosition() -> String{
        return self.position
    }
    //取得棒次
    func getBattingOrder() -> Int{
        return self.battingOrder
    }
    //取得投手被打擊數
    func getPitchH() -> String{
        return String(self.pitcherH)
    }
    //取得投球局數
    func getPitchIP() -> String{
        return String(self.IP)
    }
    //取得防禦率
    func getERA() -> String{
        var ERA:Float
        var batterOutCount:Int
        if self.ER == 0{
            ERA = 0
        }
        else if self.ER > 0 && self.IP == 0{
            ERA = 999.99
        }
        else{
            batterOutCount = Int(self.IP / 1)*3 + Int(self.IP.truncatingRemainder(dividingBy: 1))*10
            
            ERA = Float(self.ER / batterOutCount * 27)
        }
        
        return String(format:"%.2f", ERA)
    }
}

//--------------function ended--------------------



