//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import UIKit
class Player{
    var name = ""
    var battingOrder = ""
    var atBat = 0 //打擊次數
    var hit = 0 //安打數
    var ip:Float = 0.0 //投球局數
    var position = "" //守備位置
    var ER:Float = 0 //自責分
    var pitchH = 0 //被安打數
    init(as name: String ,position pos: String,battingOrder : String) {
        self.name = name
        self.position = pos
        self.battingOrder = battingOrder
    }
    //設定打者名字
    func setName(as name: String){
        self.name = name
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
        self.pitchH += 1
    }
    //增加投球局數
    func addIP(){
        self.ip += 0.1
        if self.ip.truncatingRemainder(dividingBy: 1) == 0.3 {
            self.ip +=  -0.3 + 1
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
    func getBattingOrder() -> String{
        return self.battingOrder
    }
    //取得投手被打擊數
    func getPitchH() -> String{
        return String(self.pitchH)
    }
    //取得投球局數
    func getPitchIP() -> String{
        return String(self.ip)
    }
    //取得防禦率
    func getERA() -> String{
        var ERA:Float
        if self.ER == 0{
            ERA = 0
        }
        else if self.ER > 0 && self.ip == 0{
            ERA = 999.99
        }
        else{
            ERA = Float(self.ER / ((Float(Int(self.ip / 1)*3) + self.ip.truncatingRemainder(dividingBy: 1)*10)/27))
        }

        return String(format:"%.2f", ERA)
    }
}



class ViewController: UIViewController{
    var players = [String: Player]()
    var playerClassList = [Player]()
    
    @IBOutlet var awayPlayer9: UILabel!
    @IBOutlet var awayPlayer8: UILabel!
    @IBOutlet var awayPlayer7: UILabel!
    @IBOutlet var awayPlayer6: UILabel!
    @IBOutlet var awayPlayer5: UILabel!
    @IBOutlet var awayPlayer4: UILabel!
    @IBOutlet var awayPlayer3: UILabel!
    @IBOutlet var awayPlayer2: UILabel!
    @IBOutlet var awayPlayer1: UILabel!
    
    @IBOutlet var homePlayer9: UILabel!
    @IBOutlet var homePlayer8: UILabel!
    @IBOutlet var homePlayer7: UILabel!
    @IBOutlet var homePlayer6: UILabel!
    @IBOutlet var homePlayer5: UILabel!
    @IBOutlet var homePlayer4: UILabel!
    @IBOutlet var homePlayer3: UILabel!
    @IBOutlet var homePlayer2: UILabel!
    @IBOutlet var homePlayer1: UILabel!
    
    @IBOutlet var baseball: UIView!
    @IBOutlet var pitchingBall: UIView!
    @IBOutlet weak var baseballField: UIImageView!

    //scoreboard
    @IBOutlet var outCount: UILabel!
    @IBOutlet var innings: UILabel!
    @IBOutlet var awayScore: UILabel!
    @IBOutlet var homeScore: UILabel!
    @IBOutlet var awayHit: UILabel!
    @IBOutlet var homeHit: UILabel!
    @IBOutlet var strikeCount: UILabel!
    @IBOutlet var ballCount: UILabel!
    @IBOutlet var result: UILabel!
    @IBOutlet var position: UILabel!
    @IBOutlet var runnerOnBase: UILabel!
    @IBOutlet var playerBattingOrder: UILabel! //上場打者棒次
    @IBOutlet var playerHit: UILabel! //上場打者打擊紀錄
    @IBOutlet var playerName: UILabel! //上場打者名字
    @IBOutlet var playerBA: UILabel! //上場打者打擊率
    @IBOutlet var playerPosition: UILabel! //上場打者守備位置
    @IBOutlet var pitchName: UILabel! //投手名字
    @IBOutlet var pitchIP: UILabel! //投球局數
    @IBOutlet var pitchERA: UILabel! //投手防禦率
    @IBOutlet var pitchH: UILabel! //投手被安打數

    
    var batters = [[UILabel]]()
    var batterOn = [-1 , -1]
    var out = 0
    var strike = 0
    var ball = 0
    var inning = 1
    var awayHits = 0
    var homeHits = 0
    var awayScoring = 0
    var homeScoring = 0
    var scoringOfTheInning = 0
    var awayOrHome = 0
    
    //base position
    let base1X = 327
    let base1Y = 179
    let base2X = 232
    let base2Y = 103
    let base3X = 137
    let base3Y = 179
    let inBoxX = 201
    let inBoxY = 260
    let homeBaseX = 232
    let homeBaseY = 257
    
    let hitBallX = 286 //220
    let hitBallY = 231 //235
    let pitchBallX = 232
    let pitchBallY = 185
    
    //defender position
    let pitcherX = 232
    let pitcherY = 143 //151
    let catcherX = 232
    let catcherY = 299 //287
    let firstBaseX = 342
    let firstBaseY = 141
    let secondBaseX = 284
    let secondBaseY = 91
    let thirdBaseX = 125
    let thirdBaseY = 141
    let shortStopX = 185
    let shortStopY = 91
    let leftFielderX = 98
    let leftFielderY = 83
    let rightFielderX = 367
    let rightFielderY = 83
    let centerFielderX = 232
    let centerFielderY = 36
    let homeBenchX = 360
    let homeBenchY = 250
    let awayBenchX = 100
    let awayBenchY = 250
    
    
    func setDefence(){
        var whichTeamDefence = 1
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {
            if self.awayOrHome == 1 {
                whichTeamDefence = 0
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.homeBenchX)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.homeBenchY)
                }
            }
            else{
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.awayBenchX)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.awayBenchY)
                }
            }
        })
        UIView.animate(withDuration: 1.0, delay: 2.0, animations: {
            for i in 0 ... 8{
                self.batters[whichTeamDefence][i].alpha = 1.0
            }
            self.batters[whichTeamDefence][0].center.x = CGFloat(self.pitcherX)
            self.batters[whichTeamDefence][0].center.y = CGFloat(self.pitcherY)
            self.batters[whichTeamDefence][1].center.x = CGFloat(self.catcherX)
            self.batters[whichTeamDefence][1].center.y = CGFloat(self.catcherY)
            self.batters[whichTeamDefence][2].center.x = CGFloat(self.firstBaseX)
            self.batters[whichTeamDefence][2].center.y = CGFloat(self.firstBaseY)
            self.batters[whichTeamDefence][3].center.x = CGFloat(self.secondBaseX)
            self.batters[whichTeamDefence][3].center.y = CGFloat(self.secondBaseY)
            self.batters[whichTeamDefence][4].center.x = CGFloat(self.thirdBaseX)
            self.batters[whichTeamDefence][4].center.y = CGFloat(self.thirdBaseY)
            self.batters[whichTeamDefence][5].center.x = CGFloat(self.shortStopX)
            self.batters[whichTeamDefence][5].center.y = CGFloat(self.shortStopY)
            self.batters[whichTeamDefence][6].center.x = CGFloat(self.leftFielderX)
            self.batters[whichTeamDefence][6].center.y = CGFloat(self.leftFielderY)
            self.batters[whichTeamDefence][7].center.x = CGFloat(self.centerFielderX)
            self.batters[whichTeamDefence][7].center.y = CGFloat(self.centerFielderY)
            self.batters[whichTeamDefence][8].center.x = CGFloat(self.rightFielderX)
            self.batters[whichTeamDefence][8].center.y = CGFloat(self.rightFielderY)
    })
        //投手資訊
        pitchName.text? = (players[self.batters[whichTeamDefence][0].text!]?.getName())!
        pitchIP.text? = (players[self.batters[whichTeamDefence][0].text!]?.getPitchIP())!
        pitchERA.text? = (players[self.batters[whichTeamDefence][0].text!]?.getERA())!
        pitchH.text? = (players[self.batters[whichTeamDefence][0].text!]?.getPitchH())!
    }
    
    func hitCheck(whichTeam: Int) {
        countReset()
        if whichTeam == 0 {
            awayHits = awayHits + 1
            awayHit.text = String (awayHits)
        }
        else{
            homeHits = homeHits + 1
            homeHit.text = String (homeHits)
        }
    }
    func inningCheck(whichTeam: Int) {
        scoringOfTheInning = 0
        if whichTeam == 0 {
            innings.text = String (inning) + "▼"
            awayOrHome = 1
        }
        else{
            inning = inning + 1
            innings.text = String (inning) + "▲"
            awayOrHome = 0
        }
        setDefence()
    }
    
    func countReset(){
        strike = 0
        ball = 0
        strikeCount.text = "○ ○"
        ballCount.text = "○ ○ ○"
    }

    func callStrike(count: Int){
        self.runnerOnBase.text = ""
        result.text = "好球" + String (count)
        if count == 1{
            strikeCount.text = "● ○"
        }
        else if count == 2{
            strikeCount.text = "● ●"
        }
        else{
            result.text = "三振"
            batterOutFunc()
            countReset()
        }
    }
    func callBall(count: Int){
        self.runnerOnBase.text = ""
        result.text = "壞球" + String (count)
        if count == 1{
            ballCount.text = "● ○ ○"
        }
        else if count == 2{
            ballCount.text = "● ● ○"
        }
        else if count == 3{
            ballCount.text = "● ● ●"
        }
        else{
            result.text = "四壞球保送"
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
            countReset()
        }
    }
    
    func scoring(whichTeam: Int) {
        scoringOfTheInning = scoringOfTheInning + 1
        if whichTeam == 0 {
            awayScoring = awayScoring + 1
            awayScore.text = String (awayScoring)
           // inningScore[0][inning - 1].text = String(scoringOfTheInning)
            
        }
        else{
            homeScoring = homeScoring + 1
            homeScore.text = String (homeScoring)
          //  inningScore[1][inning - 1].text = String(scoringOfTheInning)
        }
        if awayOrHome == 1{
            players[self.batters[0][0].text!]?.addER()
            pitchERA.text? = (players[self.batters[0][0].text!]?.getERA())!
            
        }else{
            players[self.batters[1][0].text!]?.addER()
            pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        }

    }
    
    func setPlayerName (label: UILabel, name: String  ){
        label.text? = "●\n\(name)"
    }
    
    func runner(batter: Int, bases: Int){
        var toFirstBase = false
        var toSecondBase = false
        var toThirdBase = false
        
        for j in 1 ... bases {
            if j >= 1 { toFirstBase = true }
            if j >= 2 { toSecondBase = true }
            if j >= 3 { toThirdBase = true }
            for i in 0 ... 8 {
                if self.batters[awayOrHome][i].center.x == CGFloat(self.inBoxX) &&
                    self.batters[awayOrHome][i].center.y == CGFloat(self.inBoxY){
                    toFirstBase = true
                    }
            }
            for i in 0 ... 8 {
                if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                    self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y)&&toFirstBase == true{
                    toSecondBase = true
                    }
                }
            for i in 0 ... 8 {
                    if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
                        self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y)&&toSecondBase == true{
                        toThirdBase = true
                        }
                    }
        
            for i in 0 ... 8 {
            if self.batters[awayOrHome][i].center.x == CGFloat(self.inBoxX) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.inBoxY){
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base1X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base1Y)
                })

            }
                
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y) && toFirstBase == true{
                UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base2X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base2Y)
                })
            }
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y) && toSecondBase == true{
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base3X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base3Y)
                })
            }
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base3X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base3Y) && toThirdBase == true{
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.homeBaseX)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.homeBaseY)
                })
                
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j) ,animations: {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    if self.awayOrHome == 0{
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.awayBenchX)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.awayBenchY)

                    }
                    if self.awayOrHome == 1{
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.homeBenchX)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.homeBenchY)
                    }
                })
                scoring(whichTeam: awayOrHome)
                }
            }
        }
    }
    func batterOutFunc(){
        UIView.animate(withDuration: 1.0,animations: {
            self.players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addOut()
            //        打者打擊率
            self.playerBA.text? = (self.players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            self.playerHit.text? = "\((self.players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((self.players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if self.awayOrHome == 1{
                self.players[self.batters[0][0].text!]?.addIP()
                self.pitchIP.text? = (self.players[self.batters[0][0].text!]?.getPitchIP())!
                self.pitchERA.text? = (self.players[self.batters[0][0].text!]?.getERA())!
            }else{
                self.players[self.batters[1][0].text!]?.addIP()
                self.pitchIP.text? = (self.players[self.batters[1][0].text!]?.getPitchIP())!
                self.pitchERA.text? = (self.players[self.batters[1][0].text!]?.getERA())!
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 0.0
            if self.awayOrHome == 0 {
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(self.awayBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(self.awayBenchY)
            }
            else{
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(self.homeBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(self.homeBenchY)
            }
        })
            self.out = self.out + 1
            self.outChecking(Count: self.out)

    }
    func outChecking(Count: Int){
        if Count % 3 == 2 {
            outCount.text = "● ●"
        }
        else if Count % 3 == 1 {
            outCount.text = "● ○"
        }
        else if Count % 3 == 0 {
            outCount.text = "○ ○"
        }
        
        if Count >= 3 {
        
            UIView.animate(withDuration: 1.0,animations: {
            if self.awayOrHome == 0 {
                for i in 0 ... 8 {
                        self.batters[self.awayOrHome][i].alpha = 0.0
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.awayBenchX)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.awayBenchY)
                        }
                    }
            else if self.awayOrHome == 1 {
                for i in 0 ... 8 {
                        self.batters[self.awayOrHome][i].alpha = 0.0
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.homeBenchX)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.homeBenchY)
                        }
                }
            })
 
            out = 0
            inningCheck(whichTeam: awayOrHome)
        }
 
    }
    @IBAction func call(_ sender: UITapGestureRecognizer) {
        self.result.text = ""
        self.position.text = ""
        self.runnerOnBase.text = ""
        getRunnerOnBase()
        UIView.animate(withDuration: 1.0,animations: {
            self.batterOn[self.awayOrHome] = self.batterOn[self.awayOrHome] + 1
            if self.batterOn[self.awayOrHome] == 9{
                self.batterOn[self.awayOrHome] = 0
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 1.0
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(self.inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(self.inBoxY)
        })
        //        打者資訊
        playerName.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getName())!
        playerPosition.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getPosition())!
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        playerBattingOrder.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBattingOrder())!

    }
    @IBAction func hit(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: baseball)
        baseball.center.x = baseball.center.x + point.x
        baseball.center.y = baseball.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            if baseball.center.x > CGFloat(pitcherX - 30)
            && baseball.center.x < CGFloat(pitcherX + 30)
            && baseball.center.y > CGFloat(pitcherY - 30)
            && baseball.center.y < CGFloat(pitcherY + 30){
                self.result.text = ""
                self.position.text = "投手方向"
                self.runnerOnBase.text = ""
            }
            else if baseball.center.x > CGFloat(catcherX - 30)
                && baseball.center.x < CGFloat(catcherX + 30)
                && baseball.center.y > CGFloat(catcherY - 30)
                && baseball.center.y < CGFloat(catcherY + 30){
                self.result.text = ""
                self.position.text = "本壘方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(firstBaseX - 30)
                && baseball.center.x < CGFloat(firstBaseX + 30)
                && baseball.center.y > CGFloat(firstBaseY - 30)
                && baseball.center.y < CGFloat(firstBaseY + 30){
                self.result.text = ""
                self.position.text = "一壘方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(secondBaseX - 30)
                && baseball.center.x < CGFloat(secondBaseX + 30)
                && baseball.center.y > CGFloat(secondBaseY - 30)
                && baseball.center.y < CGFloat(secondBaseY + 30){
                self.result.text = ""
                self.position.text = "二壘方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(thirdBaseX - 30)
                && baseball.center.x < CGFloat(thirdBaseX + 30)
                && baseball.center.y > CGFloat(thirdBaseY - 30)
                && baseball.center.y < CGFloat(thirdBaseY + 30){
                self.result.text = ""
                self.position.text = "三壘方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(shortStopX - 30)
                && baseball.center.x < CGFloat(shortStopX + 30)
                && baseball.center.y > CGFloat(shortStopY - 30)
                && baseball.center.y < CGFloat(shortStopY + 30){
                self.result.text = ""
                self.position.text = "游擊方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(centerFielderX - 30)
                && baseball.center.x < CGFloat(centerFielderX + 30)
                && baseball.center.y > CGFloat(centerFielderY - 30)
                && baseball.center.y < CGFloat(centerFielderY + 30){
                self.result.text = ""
                self.position.text = "中外野方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(rightFielderX - 30)
                && baseball.center.x < CGFloat(rightFielderX + 30)
                && baseball.center.y > CGFloat(rightFielderY - 30)
                && baseball.center.y < CGFloat(rightFielderY + 30){
                self.result.text = ""
                self.position.text = "右外野方向"
                self.runnerOnBase.text = ""

            }
            else if baseball.center.x > CGFloat(leftFielderX - 30)
                && baseball.center.x < CGFloat(leftFielderX + 30)
                && baseball.center.y > CGFloat(leftFielderY - 30)
                && baseball.center.y < CGFloat(leftFielderY + 30){
                self.result.text = ""
                self.position.text = "左外野方向"
                self.runnerOnBase.text = ""
            }
            else if ((baseball.center.x < 75 && baseball.center.y > 170)||(baseball.center.x < 148 && baseball.center.y > 210 ))||((baseball.center.x > 389 && baseball.center.y > 170) || (baseball.center.x < 316 && baseball.center.y > 210 )){
                if strike < 2 {
                    strike = strike + 1
                }
                callStrike(count: strike)
                self.position.text = ""
                self.result.text = "界外球"
                self.runnerOnBase.text = ""
                baseball.center.x = CGFloat(hitBallX)
                baseball.center.y = CGFloat(hitBallY)
            }



        }
    }
    func getRunnerOnBase(){
        var check1 = false
        var check2 = false
        var check3 = false
        for i in 0...8 {
        if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
            self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y){
            check1 = true
            }
        else if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
            self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y){
            check2 = true
            }
        else if self.batters[awayOrHome][i].center.x == CGFloat(self.base3X) &&
            self.batters[awayOrHome][i].center.y == CGFloat(self.base3Y){
            check3 = true
            }
        }
        if check1 == true && check2 == true && check3 == true {
            self.runnerOnBase.text = "滿壘"
        }
        else if check1 == true && check2 == true{
            self.runnerOnBase.text = "一二壘有人"
        }
        else if check1 == true && check3 == true{
            self.runnerOnBase.text = "一三壘有人"
        }
        else if check2 == true && check3 == true{
            self.runnerOnBase.text = "二三壘有人"
        }
        else if check1 == true{
            self.runnerOnBase.text = "一壘有人"
        }
        else if check2 == true{
            self.runnerOnBase.text = "二壘有人"
        }
        else if check3 == true{
            self.runnerOnBase.text = "三壘有人"
        }
        else{
            self.runnerOnBase.text = "無人在壘"
        }



        
        
    }
    
    func battingResult(){
        var delay = 1
        if  self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base1X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base1X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base1Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base1Y + 30){
                delay = 1
                self.result.text = "一壘安打"
                self.runnerOnBase.text = ""
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
            //        打者打擊率
            playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if awayOrHome == 1{
                
                players[self.batters[0][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
            }else{
                
                players[self.batters[1][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
            }
                self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
                self.hitCheck(whichTeam: self.awayOrHome)
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base2X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base2X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base2Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base2Y + 30){
            delay = 2
            self.result.text = "二壘安打"
            self.runnerOnBase.text = ""
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
            //        打者打擊率
            playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if awayOrHome == 1{
                
                players[self.batters[0][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
            }else{
                
                players[self.batters[1][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
            }
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 2)
            self.hitCheck(whichTeam: self.awayOrHome)
            
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base3X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base3X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base3Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base3Y + 30){
            delay = 3
            self.result.text = "三壘安打"
            self.runnerOnBase.text = ""
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
            //        打者打擊率
            playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if awayOrHome == 1{
                
                players[self.batters[0][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
            }else{
                
                players[self.batters[1][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
            }
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 3)
            self.hitCheck(whichTeam: self.awayOrHome)
            
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(homeBaseX - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(homeBaseX + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(homeBaseY - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(homeBaseY + 30){
            delay = 4
            self.result.text = "全壘打"
            self.runnerOnBase.text = ""
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
            //        打者打擊率
            playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if awayOrHome == 1{
                
                players[self.batters[0][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
            }else{
                
                players[self.batters[1][0].text!]?.addPitchH()
                pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
                pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
            }
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 4)
            self.hitCheck(whichTeam: self.awayOrHome)
        }
            
        else if ((self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < 75
                && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 170)
                || (self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < 148
                && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 210))
                ||
                ((self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > 389
                && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 170)
                || (self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < 316
                    && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 210)){
            //        打者打擊率
            playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
            //        打者打擊紀錄
            playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
            //        投手紀錄
            if awayOrHome == 1{
                pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
                pitchERA.text? = (players[self.batters[0][0].text!]?.getERA())!
            }else{
                pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
                pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
            }
                    batterOutFunc()
            self.result.text = "出局"

        }
        else{
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            
        }
        UIView.animate(withDuration: 1.0, delay: TimeInterval(delay) , animations: {
            self.baseball.center.x = CGFloat(self.hitBallX)
            self.baseball.center.y = CGFloat(self.hitBallY)
        })

    }



    @IBAction func battingResultForAway1(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.awayPlayer1)
        self.awayPlayer1.center.x = self.awayPlayer1.center.x + point.x
        self.awayPlayer1.center.y = self.awayPlayer1.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            self.battingResult()
            }
        }
 
    @IBAction func battingResultForAway2( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer2)
        awayPlayer2.center.x = awayPlayer2.center.x + point.x
        awayPlayer2.center.y = awayPlayer2.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
            }
    }
    @IBAction func battingResultForAway3(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer3)
        awayPlayer3.center.x = awayPlayer3.center.x + point.x
        awayPlayer3.center.y = awayPlayer3.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway4( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer4)
        awayPlayer4.center.x = awayPlayer4.center.x + point.x
        awayPlayer4.center.y = awayPlayer4.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway5(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer5)
        awayPlayer5.center.x = awayPlayer5.center.x + point.x
        awayPlayer5.center.y = awayPlayer5.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway6( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer6)
        awayPlayer6.center.x = awayPlayer6.center.x + point.x
        awayPlayer6.center.y = awayPlayer6.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway7(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer7)
        awayPlayer7.center.x = awayPlayer7.center.x + point.x
        awayPlayer7.center.y = awayPlayer7.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway8( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer8)
        awayPlayer8.center.x = awayPlayer8.center.x + point.x
        awayPlayer8.center.y = awayPlayer8.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForAway9(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: awayPlayer9)
        awayPlayer9.center.x = awayPlayer9.center.x + point.x
        awayPlayer9.center.y = awayPlayer9.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome1( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer1)
        homePlayer1.center.x = homePlayer1.center.x + point.x
        homePlayer1.center.y = homePlayer1.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome2( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer2)
        homePlayer2.center.x = homePlayer2.center.x + point.x
        homePlayer2.center.y = homePlayer2.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome3( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer3)
        homePlayer3.center.x = homePlayer3.center.x + point.x
        homePlayer3.center.y = homePlayer3.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome4( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer4)
        homePlayer4.center.x = homePlayer4.center.x + point.x
        homePlayer4.center.y = homePlayer4.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome5( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer5)
        homePlayer5.center.x = homePlayer5.center.x + point.x
        homePlayer5.center.y = homePlayer5.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome6( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer6)
        homePlayer6.center.x = homePlayer6.center.x + point.x
        homePlayer6.center.y = homePlayer6.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome7( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer7)
        homePlayer7.center.x = homePlayer7.center.x + point.x
        homePlayer7.center.y = homePlayer7.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome8( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer8)
        homePlayer8.center.x = homePlayer8.center.x + point.x
        homePlayer8.center.y = homePlayer8.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    @IBAction func battingResultForHome9( sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer9)
        homePlayer9.center.x = homePlayer9.center.x + point.x
        homePlayer9.center.y = homePlayer9.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
        }
    }
    
    
    @IBAction func pitch(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: pitchingBall)
        pitchingBall.center.x = pitchingBall.center.x + point.x
        pitchingBall.center.y = pitchingBall.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
       if pitchingBall.center.x > 217 && pitchingBall.center.x < 287 && pitchingBall.center.y > 263 {
        strike = strike + 1
        callStrike(count: strike)
            }
       else if pitchingBall.center.x > 167 && pitchingBall.center.x < 217 && pitchingBall.center.y > 243 && pitchingBall.center.y < 293 {
        self.result.text = "觸身球保送"
        self.runnerOnBase.text = ""
        self.position.text = ""
        countReset()
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
            }
       else {
        ball = ball + 1
        callBall(count: ball)
            }
            UIView.animate(withDuration: 0.5,animations: {

        self.pitchingBall.center.x = CGFloat(self.pitchBallX)
        self.pitchingBall.center.y = CGFloat(self.pitchBallY)
                
            })
        }
    }
    @IBAction func PBorWP(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer2)
        let detect = sender.numberOfTouches
        var max = 0
        if detect > max {
            max = detect
        }
        result.text = "暴投" + String(max)
        homePlayer2.center.x = homePlayer2.center.x + point.x
        homePlayer2.center.y = homePlayer2.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            if homePlayer2.center.y > 205 {
            position.text = ""
            if max == 1{
                    result.text = "暴投" + String(max)
                }
            else if max == 2{
                   result.text = "捕逸"
                }
            }
         homePlayer2.center.x = CGFloat(catcherX)
         homePlayer2.center.y = CGFloat(catcherY)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        batters = [[awayPlayer1,awayPlayer2,awayPlayer3,awayPlayer4,awayPlayer5,awayPlayer6,awayPlayer7,awayPlayer8,awayPlayer9] , [homePlayer1,homePlayer2,homePlayer3,homePlayer4,homePlayer5,homePlayer6,homePlayer7,homePlayer8,homePlayer9]]
        //初始化選手資料
        awayPlayer1.text? = "①"
        let kevin = Player(as: "Kevin" ,position: "P" ,battingOrder: "1st")
        players.updateValue(kevin, forKey: "①")
        
        awayPlayer2.text? = "②"
        let robber = Player(as: "Robber" ,position: "C" ,battingOrder: "2nd")
        players.updateValue(robber, forKey: "②")
        
        awayPlayer3.text? = "③"
        let green = Player(as: "Green" ,position: "1B" ,battingOrder: "3rd")
        players.updateValue(green, forKey: "③")
        
        awayPlayer4.text? = "④"
        let anderson = Player(as: "Anderson" ,position: "2B" ,battingOrder: "4th")
        players.updateValue(anderson, forKey: "④")
        
        awayPlayer5.text? = "⑤"
        let bob = Player(as: "Bob" ,position: "3B" ,battingOrder: "5th")
        players.updateValue(bob, forKey: "⑤")
        
        awayPlayer6.text? = "⑥"
        let gray = Player(as: "Gray" ,position: "SS" ,battingOrder: "6th")
        players.updateValue(gray, forKey: "⑥")
        
        awayPlayer7.text? = "⑦"
        let john = Player(as: "John" ,position: "LF" ,battingOrder: "7th")
        players.updateValue(john, forKey: "⑦")
        
        awayPlayer8.text? = "⑧"
        let wright = Player(as: "Wright" ,position: "CF" ,battingOrder: "8th")
        players.updateValue(wright, forKey: "⑧")
        
        awayPlayer9.text? = "⑨"
        let denny = Player(as: "Denny" ,position: "RF" ,battingOrder: "9th")
        players.updateValue(denny, forKey: "⑨")
        
        homePlayer1.text? = "❶"
        let ann = Player(as: "Ann" ,position: "P", battingOrder: "1st")
        players.updateValue(ann, forKey: "❶")
        
        homePlayer2.text? = "❷"
        let young = Player(as: "Young" ,position: "C", battingOrder: "2nd")
        players.updateValue(young, forKey: "❷")
        
        homePlayer3.text? = "❸"
        let money = Player(as: "Money" ,position: "1B", battingOrder: "3rd")
        players.updateValue(money, forKey: "❸")
        
        homePlayer4.text? = "❹"
        let fry = Player(as: "Fry" ,position: "2B", battingOrder: "4th")
        players.updateValue(fry, forKey: "❹")
        
        homePlayer5.text? = "❺"
        let carter = Player(as: "Carter" ,position: "3B", battingOrder: "5th")
        players.updateValue(carter, forKey: "❺")
        
        homePlayer6.text? = "❻"
        let penny = Player(as: "Penny" ,position: "SS", battingOrder: "6th")
        players.updateValue(penny, forKey: "❻")
        
        homePlayer7.text? = "❼"
        let len = Player(as: "Len" ,position: "LF", battingOrder: "7th")
        players.updateValue(len, forKey: "❼")
        
        homePlayer8.text? = "❽"
        let rose = Player(as: "Rose" ,position: "CF", battingOrder: "8th")
        players.updateValue(rose, forKey: "❽")
        
        homePlayer9.text? = "❾"
        let ted = Player(as: "Ted" ,position: "RF", battingOrder: "9th")
        players.updateValue(ted, forKey: "❾")
        
        //開局投手資訊
        pitchName.text? = (players[self.batters[1][0].text!]?.getName())!
        pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
        pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
        
  /*
        inningScore = [[top1,top2,top3,top4,top5,top6,top7,top8,top9],[bottom1,bottom2,bottom3,bottom4,bottom5,bottom6,bottom7,bottom8,bottom9]]
    */
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
        let tapGestureRecognizerCallNextBatter = UITapGestureRecognizer(target: self, action: #selector(call(_:)))
        tapGestureRecognizerCallNextBatter.numberOfTapsRequired = 2
        baseballField.isUserInteractionEnabled = true
        baseballField.addGestureRecognizer(tapGestureRecognizerCallNextBatter)
        
        
        let panGestureRecognizerHit = UIPanGestureRecognizer(target: self, action: #selector(hit(sender:)))
        let panGestureRecognizerPBorWP = UIPanGestureRecognizer(target: self, action: #selector(PBorWP(sender:)))
        let panGestureRecognizerPitch = UIPanGestureRecognizer(target: self, action: #selector(pitch(sender:)))
        let panGestureRecognizerBattingResultAway1 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway1(sender:)))
        let panGestureRecognizerBattingResultAway2 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway2(sender:)))
        let panGestureRecognizerBattingResultAway3 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway3(sender:)))
        let panGestureRecognizerBattingResultAway4 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway4(sender:)))
        let panGestureRecognizerBattingResultAway5 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway5(sender:)))
        let panGestureRecognizerBattingResultAway6 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway6(sender:)))
        let panGestureRecognizerBattingResultAway7 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway7(sender:)))
        let panGestureRecognizerBattingResultAway8 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway8(sender:)))
        let panGestureRecognizerBattingResultAway9 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForAway9(sender:)))
        let panGestureRecognizerBattingResultHome1 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome1(sender:)))
        let panGestureRecognizerBattingResultHome2 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome2(sender:)))
        let panGestureRecognizerBattingResultHome3 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome3(sender:)))
        let panGestureRecognizerBattingResultHome4 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome4(sender:)))
        let panGestureRecognizerBattingResultHome5 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome5(sender:)))
        let panGestureRecognizerBattingResultHome6 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome6(sender:)))
        let panGestureRecognizerBattingResultHome7 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome7(sender:)))
        let panGestureRecognizerBattingResultHome8 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome8(sender:)))
        let panGestureRecognizerBattingResultHome9 = UIPanGestureRecognizer(target: self, action: #selector(battingResultForHome9(sender:)))
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        

        baseball.isUserInteractionEnabled = true
        baseball.addGestureRecognizer(panGestureRecognizerHit)
        
        pitchingBall.isUserInteractionEnabled = true
        pitchingBall.addGestureRecognizer(panGestureRecognizerPitch)
    

        homePlayer1.isUserInteractionEnabled = true
        homePlayer1.addGestureRecognizer(panGestureRecognizerBattingResultHome1)

        awayPlayer1.isUserInteractionEnabled = true
        awayPlayer1.addGestureRecognizer(panGestureRecognizerBattingResultAway1)

        homePlayer2.isUserInteractionEnabled = true
        homePlayer2.addGestureRecognizer(panGestureRecognizerPBorWP)
        homePlayer2.addGestureRecognizer(panGestureRecognizerBattingResultHome2)

        awayPlayer2.isUserInteractionEnabled = true
        awayPlayer2.addGestureRecognizer(panGestureRecognizerBattingResultAway2)
        
        
        homePlayer3.isUserInteractionEnabled = true
        homePlayer3.addGestureRecognizer(panGestureRecognizerBattingResultHome3)
        
        awayPlayer3.isUserInteractionEnabled = true
        awayPlayer3.addGestureRecognizer(panGestureRecognizerBattingResultAway3)
        
        homePlayer4.isUserInteractionEnabled = true
        homePlayer4.addGestureRecognizer(panGestureRecognizerBattingResultHome4)
        
        awayPlayer4.isUserInteractionEnabled = true
        awayPlayer4.addGestureRecognizer(panGestureRecognizerBattingResultAway4)
        
        homePlayer5.isUserInteractionEnabled = true
        homePlayer5.addGestureRecognizer(panGestureRecognizerBattingResultHome5)
        
        awayPlayer5.isUserInteractionEnabled = true
        awayPlayer5.addGestureRecognizer(panGestureRecognizerBattingResultAway5)
        
        homePlayer6.isUserInteractionEnabled = true
        homePlayer6.addGestureRecognizer(panGestureRecognizerBattingResultHome6)
        
        awayPlayer6.isUserInteractionEnabled = true
        awayPlayer6.addGestureRecognizer(panGestureRecognizerBattingResultAway6)
        
        homePlayer7.isUserInteractionEnabled = true
        homePlayer7.addGestureRecognizer(panGestureRecognizerBattingResultHome7)
        
        awayPlayer7.isUserInteractionEnabled = true
        awayPlayer7.addGestureRecognizer(panGestureRecognizerBattingResultAway7)
        
        homePlayer8.isUserInteractionEnabled = true
        homePlayer8.addGestureRecognizer(panGestureRecognizerBattingResultHome8)
        
        awayPlayer8.isUserInteractionEnabled = true
        awayPlayer8.addGestureRecognizer(panGestureRecognizerBattingResultAway8)
        
        homePlayer9.isUserInteractionEnabled = true
        homePlayer9.addGestureRecognizer(panGestureRecognizerBattingResultHome9)
        
        awayPlayer9.isUserInteractionEnabled = true
        awayPlayer9.addGestureRecognizer(panGestureRecognizerBattingResultAway9)
  
        
        
        if homePlayer1.center.x == CGFloat(pitcherX) && homePlayer1.center.y == CGFloat(pitcherY){
            panGestureRecognizerBattingResultHome1.isEnabled = false
        }
        
        if homePlayer2.center.x == CGFloat(catcherX) && homePlayer2.center.y == CGFloat(catcherY){
            panGestureRecognizerBattingResultHome2.isEnabled = false
        }
        if homePlayer3.center.x == CGFloat(firstBaseX) && homePlayer3.center.y == CGFloat(firstBaseY){
            panGestureRecognizerBattingResultHome3.isEnabled = false
        }
        if homePlayer4.center.x == CGFloat(secondBaseX) && homePlayer4.center.y == CGFloat(secondBaseY){
            panGestureRecognizerBattingResultHome4.isEnabled = false
        }
        if homePlayer5.center.x == CGFloat(thirdBaseX) && homePlayer5.center.y == CGFloat(thirdBaseY){
            panGestureRecognizerBattingResultHome5.isEnabled = false
        }
        if homePlayer6.center.x == CGFloat(shortStopX) && homePlayer6.center.y == CGFloat(shortStopY){
            panGestureRecognizerBattingResultHome6.isEnabled = false
        }
        if homePlayer7.center.x == CGFloat(leftFielderX) && homePlayer7.center.y == CGFloat(leftFielderY){
            panGestureRecognizerBattingResultHome7.isEnabled = false
        }
        if homePlayer8.center.x == CGFloat(centerFielderX) && homePlayer8.center.y == CGFloat(centerFielderY){
            panGestureRecognizerBattingResultHome8.isEnabled = false
        }
        if homePlayer9.center.x == CGFloat(rightFielderX) && homePlayer9.center.y == CGFloat(rightFielderY){
            panGestureRecognizerBattingResultHome9.isEnabled = false
        }
        if awayPlayer1.center.x == CGFloat(pitcherX) && awayPlayer1.center.y == CGFloat(pitcherY){
            panGestureRecognizerBattingResultAway1.isEnabled = false
        }
        if awayPlayer2.center.x == CGFloat(catcherX) && awayPlayer2.center.y == CGFloat(catcherY){
            panGestureRecognizerBattingResultAway2.isEnabled = false
        }
        if awayPlayer3.center.x == CGFloat(firstBaseX) && awayPlayer3.center.y == CGFloat(firstBaseY){
            panGestureRecognizerBattingResultAway3.isEnabled = false
        }
        if awayPlayer4.center.x == CGFloat(secondBaseX) && awayPlayer4.center.y == CGFloat(secondBaseY){
            panGestureRecognizerBattingResultAway4.isEnabled = false
        }
        if awayPlayer5.center.x == CGFloat(thirdBaseX) && awayPlayer5.center.y == CGFloat(thirdBaseY){
            panGestureRecognizerBattingResultAway5.isEnabled = false
        }
        if awayPlayer6.center.x == CGFloat(shortStopX) && awayPlayer6.center.y == CGFloat(shortStopY){
            panGestureRecognizerBattingResultAway6.isEnabled = false
        }
        if awayPlayer7.center.x == CGFloat(leftFielderX) && awayPlayer7.center.y == CGFloat(leftFielderY){
            panGestureRecognizerBattingResultAway7.isEnabled = false
        }
        if awayPlayer8.center.x == CGFloat(centerFielderX) && awayPlayer8.center.y == CGFloat(centerFielderY){
            panGestureRecognizerBattingResultAway8.isEnabled = false
        }
        if awayPlayer9.center.x == CGFloat(rightFielderX) && awayPlayer9.center.y == CGFloat(rightFielderY){
            panGestureRecognizerBattingResultAway9.isEnabled = false
        }
  

 }


}
