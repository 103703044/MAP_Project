//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//




//----------------function-------------------
import UIKit
import Firebase

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

//--------------function ended--------------------

//---------------IBoutlet&varible number-------------------------


class ViewController: UIViewController{
    
    @IBOutlet weak var test: UILabel!
    var ref:FIRDatabaseReference?
  //  let rootRef = FIRDatabase.database().reference()
    
    
    var players = [String: Player]()
    var playerClassList = [Player]()
    
    @IBOutlet weak var homePlayer6Name: UILabel!
    //客場球員1~9
    @IBOutlet weak var HomeTeam: UILabel!
    @IBOutlet weak var AwayTeam: UILabel!
    @IBOutlet var awayPlayer9: UILabel!
    @IBOutlet var awayPlayer8: UILabel!
    @IBOutlet var awayPlayer7: UILabel!
    @IBOutlet var awayPlayer6: UILabel!
    @IBOutlet var awayPlayer5: UILabel!
    @IBOutlet var awayPlayer4: UILabel!
    @IBOutlet var awayPlayer3: UILabel!
    @IBOutlet var awayPlayer2: UILabel!
    @IBOutlet var awayPlayer1: UILabel!
    
    //主場球員1~9
    @IBOutlet var homePlayer9: UILabel!
    @IBOutlet var homePlayer8: UILabel!
    @IBOutlet var homePlayer7: UILabel!
    @IBOutlet var homePlayer6: UILabel!
    @IBOutlet var homePlayer5: UILabel!
    @IBOutlet var homePlayer4: UILabel!
    @IBOutlet var homePlayer3: UILabel!
    @IBOutlet var homePlayer2: UILabel!
    @IBOutlet var homePlayer1: UILabel!
    
    //打擊球
    @IBOutlet var baseball: UIView!
    //投手球
    @IBOutlet var pitchingBall: UIView!
    //棒球場
    @IBOutlet weak var baseballField: UIImageView!
    //棒球場(失誤)預設透明
    @IBOutlet weak var baseballFieldOfError: UIImageView!
    
/*
    @IBOutlet var top1: UILabel!
    @IBOutlet var bottom1: UILabel!
    @IBOutlet var top2: UILabel!
    @IBOutlet var bottom2: UILabel!
    @IBOutlet var top3: UILabel!
    @IBOutlet var bottom3: UILabel!
    @IBOutlet var top4: UILabel!
    @IBOutlet var bottom4: UILabel!
    @IBOutlet var top5: UILabel!
    @IBOutlet var bottom5: UILabel!
    @IBOutlet var top6: UILabel!
    @IBOutlet var bottom6: UILabel!
    @IBOutlet var top7: UILabel!
    @IBOutlet var bottom7: UILabel!
    @IBOutlet var top8: UILabel!
    @IBOutlet var bottom8: UILabel!
    @IBOutlet var top9: UILabel!
    @IBOutlet var bottom9: UILabel!
*/
    //scoreboard
    
    @IBOutlet var outCount: UILabel!//出局數
    @IBOutlet var innings: UILabel!//局數
    @IBOutlet var awayScore: UILabel!//客場分數
    @IBOutlet var homeScore: UILabel!//主場分數
    @IBOutlet var awayHit: UILabel!//客場安打
    @IBOutlet var homeHit: UILabel!//主場安打
    @IBOutlet var strikeCount: UILabel!//這打席的好球數
    @IBOutlet var ballCount: UILabel!//這打席的壞球數
    @IBOutlet var result: UILabel!//打席的打擊結果
    @IBOutlet var position: UILabel!//打擊出去的位置方向
    @IBOutlet var runnerOnBase: UILabel!//壘上跑者狀況
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
 //   var inningScore = [[UILabel]]()
    var batterOn = [-1 , -1]
    var out = 0 //出局數
    var strike = 0 //好球數
    var ball = 0 //壞球數
    var inning = 1 //局數
    var awayHits = 0 //客場安打數
    var homeHits = 0 //主場安打數
    var awayScoring = 0 //客場得分數
    var homeScoring = 0 //主場得分數
    var scoringOfTheInning = 0 //該局得分數
    var awayOrHome = 0 //0 = 客場進攻 1 = 主場進攻
    
    //base & item position
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
    
    let hitBallX = 286
    let hitBallY = 231
    let pitchBallX = 232
    let pitchBallY = 185
    
    //defender position
    
    let pitcherX = 232
    let pitcherY = 143
    let catcherX = 232
    let catcherY = 299
    let firstBaseX = 342
    let firstBaseY = 141
    let secondBaseX = 284
    let secondBaseY = 91
    let thirdBaseX = 125
    let thirdBaseY = 141
    let shortStopX = 185
    let shortStopY = 91
    let shortStopNameX = 179
    let shortStopNameY = 79
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
    
    //---------------IBoutlet&varible number ended-------------------------

    
    
    //-----setDefence------
    //func-setDefence: 讓進攻方球員回到休息區並透明化，讓守備方球員到各自的守備位置並顯示
    func setDefence(){
        var whichTeamDefence = 1
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {
            if self.awayOrHome == 1 {
                //客隊進攻
                whichTeamDefence = 0
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.homeBenchX)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.homeBenchY)
                }
                self.panGestureRecognizerBattingResultHome1.isEnabled = false
                self.panGestureRecognizerBattingResultHome2.isEnabled = false
                self.panGestureRecognizerBattingResultHome3.isEnabled = false
                self.panGestureRecognizerBattingResultHome4.isEnabled = false
                self.panGestureRecognizerBattingResultHome5.isEnabled = false
                self.panGestureRecognizerBattingResultHome6.isEnabled = false
                self.panGestureRecognizerBattingResultHome7.isEnabled = false
                self.panGestureRecognizerBattingResultHome8.isEnabled = false
                self.panGestureRecognizerBattingResultHome9.isEnabled = false
                self.panGestureRecognizerBattingResultAway1.isEnabled = true
                self.panGestureRecognizerBattingResultAway2.isEnabled = true
                self.panGestureRecognizerBattingResultAway3.isEnabled = true
                self.panGestureRecognizerBattingResultAway4.isEnabled = true
                self.panGestureRecognizerBattingResultAway5.isEnabled = true
                self.panGestureRecognizerBattingResultAway6.isEnabled = true
                self.panGestureRecognizerBattingResultAway7.isEnabled = true
                self.panGestureRecognizerBattingResultAway8.isEnabled = true
                self.panGestureRecognizerBattingResultAway9.isEnabled = true

                
            }
            else{
                //主隊進攻
                self.panGestureRecognizerBattingResultHome1.isEnabled = true
                self.panGestureRecognizerBattingResultHome2.isEnabled = true
                self.panGestureRecognizerBattingResultHome3.isEnabled = true
                self.panGestureRecognizerBattingResultHome4.isEnabled = true
                self.panGestureRecognizerBattingResultHome5.isEnabled = true
                self.panGestureRecognizerBattingResultHome6.isEnabled = true
                self.panGestureRecognizerBattingResultHome7.isEnabled = true
                self.panGestureRecognizerBattingResultHome8.isEnabled = true
                self.panGestureRecognizerBattingResultHome9.isEnabled = true
                self.panGestureRecognizerBattingResultAway1.isEnabled = false
                self.panGestureRecognizerBattingResultAway2.isEnabled = false
                self.panGestureRecognizerBattingResultAway3.isEnabled = false
                self.panGestureRecognizerBattingResultAway4.isEnabled = false
                self.panGestureRecognizerBattingResultAway5.isEnabled = false
                self.panGestureRecognizerBattingResultAway6.isEnabled = false
                self.panGestureRecognizerBattingResultAway7.isEnabled = false
                self.panGestureRecognizerBattingResultAway8.isEnabled = false
                self.panGestureRecognizerBattingResultAway9.isEnabled = false
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
    //-----setDefence ended------

    //func-hitcheck(0 = 客隊打擊 1 = 主隊打擊):讓攻擊方的安打數+1
    func hitCheck(whichTeam: Int) {
        if whichTeam == 0 {
            awayHits = awayHits + 1
            awayHit.text = String (awayHits)
        }
        else{
            homeHits = homeHits + 1
            homeHit.text = String (homeHits)
        }
    }
    //func-inningCheck(0 = 上換下 1 = 下換上):上半局換成下半局，或下半局換到下局的上半局，並setDefence
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
    
    //func-countReset:球數重置
    func countReset(){
        strike = 0
        ball = 0
        strikeCount.text = "○ ○"
        ballCount.text = "○ ○ ○"
    }
    
    //func-callStrike(本來的好球數):投出好球
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
    //func-callBall(本來的壞球數):投出壞球
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
    //func-scoring(0 = 客場得分 1 = 主場得分):增加得分方一分，並增加投手的自責分(率)
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
    /*
     //func-setPlayerName:設定球員名稱(未完成)
    func setPlayerName (label: UILabel, name: String  ){
        label.text? = "●\n\(name)"
    }
    */
    
    
//func-runner(打擊的打者,壘打數):計算打者及跑者的壘包推進最小值(強迫進壘)
    func runner(batter: Int, bases: Int){
        var toFirstBase = false //有跑者進一壘的意圖
        var toSecondBase = false//有跑者進二壘的意圖
        var toThirdBase = false//有跑者進三壘的意圖
        
        for j in 1 ... bases { //根據壘打數決定進行幾輪
            if j >= 1 { toFirstBase = true }
            if j >= 2 { toSecondBase = true }
            if j >= 3 { toThirdBase = true }
            for i in 0 ... 8 { //如果有人在打擊區，則進一壘意圖為T
                if self.batters[awayOrHome][i].center.x == CGFloat(self.inBoxX) &&
                    self.batters[awayOrHome][i].center.y == CGFloat(self.inBoxY){
                    toFirstBase = true
                    }
            }
            for i in 0 ... 8 { //如果有人在一壘，且進一壘意圖為T，則進二壘意圖為T
                if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                    self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y)&&toFirstBase == true{
                    toSecondBase = true
                    }
                }
            for i in 0 ... 8 { //如果有人在二壘，且進二壘意圖為T，則進三壘意圖為T
                    if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
                        self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y)&&toSecondBase == true{
                        toThirdBase = true
                        }
                    }
        
            for i in 0 ... 8 {
                //如果有人在打擊區，則上一壘
                if self.batters[awayOrHome][i].center.x == CGFloat(self.inBoxX) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.inBoxY){
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.base1X)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.base1Y)
                    })
                }
                //如果一壘有人，且進一壘意圖為T，則一壘跑者上二壘
                else if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y) && toFirstBase == true{
                    UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.base2X)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.base2Y)
                    })
                }
                //如果二壘有人，且進二壘意圖為T，則二壘跑者上三壘
                else if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y) && toSecondBase == true{
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                        self.batters[self.awayOrHome][i].center.x = CGFloat(self.base3X)
                        self.batters[self.awayOrHome][i].center.y = CGFloat(self.base3Y)
                    })
                }
                //如果三壘有人，且進三壘的意圖為T，則三壘跑者回本壘得分
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
    
    //func-batterOutFunc:打者出局，更新打者與投手紀錄，並檢查出局數和局數
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
    //func-outChecking(出局數):依出局數亮燈，若三人出局則換邊
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
            out = 0
            inningCheck(whichTeam: awayOrHome)
        }
 
    }
    
    
    //點擊背景觸發func-call:讓下一位打者上打擊區
    @IBAction func call(_ sender: UITapGestureRecognizer) {
        self.result.text = ""
        self.position.text = ""
        self.runnerOnBase.text = ""
        getRunnerOnBase()//文字更新目前壘上狀況
        UIView.animate(withDuration: 1.0, delay: 0 , animations: {
            self.baseball.center.x = CGFloat(self.hitBallX)
            self.baseball.center.y = CGFloat(self.hitBallY)
        })
        UIView.animate(withDuration: 1.0,animations: {
            self.batterOn[self.awayOrHome] = self.batterOn[self.awayOrHome] + 1
            if self.batterOn[self.awayOrHome] == 9{
                self.batterOn[self.awayOrHome] = 0
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 1.0
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(self.inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(self.inBoxY)
        })
        //打者資訊
        playerName.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getName())!
        playerPosition.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getPosition())!
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        playerBattingOrder.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBattingOrder())!
    }
    //func-getRunnerOnBase:文字提示更新目前壘上狀況
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

    //拖曳打擊的球觸發func-hit:拖曳棒球到球擊出的方向
    @IBAction func hit(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: baseball)
        baseball.center.x = baseball.center.x + point.x
        baseball.center.y = baseball.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            if baseball.center.y < 30
                || (baseball.center.x < 30 && baseball.center.y < 70)
                || (baseball.center.x < 50 && baseball.center.y < 50)
                || (baseball.center.x > 435 && baseball.center.y < 70)
                || (baseball.center.x > 415 && baseball.center.y < 70)
                {
                    if baseball.center.x < 155 {
                        self.position.text = "左外野方向"
                    }
                    else if baseball.center.x < 311{
                        self.position.text = "中外野方向"
                    }
                    else {
                        self.position.text = "右外野方向"
                        
                    }
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
            else if baseball.center.x > CGFloat(pitcherX - 30)
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

    //func-battingResult:拖曳打者決定壘打數或出局
    func battingResult(){
        if  self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base1X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base1X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base1Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base1Y + 30){
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


    }


    //-----------------拖曳打者觸發打擊結果-----------------------
    @IBAction func battingResultForAway1(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.awayPlayer1)
        self.awayPlayer1.center.x = self.awayPlayer1.center.x + point.x
        self.awayPlayer1.center.y = self.awayPlayer1.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
         //   awayPlayer1.isUserInteractionEnabled = false
            self.battingResult()
            }
        }
        /*
        if awayPlayer1.center.x == CGFloat(base1X) && awayPlayer1.center.y == CGFloat(base1Y) {
            let point = sender.location(in: self.awayPlayer1)
            self.awayPlayer1.center.x = self.awayPlayer1.center.x + point.x
            self.awayPlayer1.center.y = self.awayPlayer1.center.y + point.y
            if sender.state == UIGestureRecognizerState.ended {
                if self.awayPlayer1.center.x > CGFloat(base2X - 30)
                    && self.awayPlayer1.center.x < CGFloat(base2X + 30)
                    && self.awayPlayer1.center.y > CGFloat(base2Y - 30)
                    && self.awayPlayer1.center.y < CGFloat(base2Y + 30){
                    result.text = "跑者上二壘"
                }
    }
        }
 */
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
    //-----------------拖曳打者觸發打擊結果 ended-----------------------
    
    //拖曳投手球，決定好壞球和觸身球
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
    //失誤模式
    @IBAction func errorMode(sender: UITapGestureRecognizer){
        if(baseballFieldOfError.alpha == 0){
        baseballFieldOfError.alpha = 1.0
    
        self.result.text = "發生失誤"
        
        if sender.view!.tag == 1 || sender.view!.tag == 11{
            self.position.text = "投手"
        }
        else if sender.view!.tag == 2 || sender.view!.tag == 12 {
             self.position.text = "捕手"
        }
        else if sender.view!.tag == 3 || sender.view!.tag == 13 {
            self.position.text = "一壘手"
        }
        else if sender.view!.tag == 4 || sender.view!.tag == 14 {
            self.position.text = "二壘手"
        }
        else if sender.view!.tag == 5 || sender.view!.tag == 15 {
            self.position.text = "三壘手"
        }
        else if sender.view!.tag == 6 || sender.view!.tag == 16 {
            self.position.text = "游擊手"
        }
        else if sender.view!.tag == 7 || sender.view!.tag == 17 {
            self.position.text = "左外野手"
        }
        else if sender.view!.tag == 8 || sender.view!.tag == 18 {
            self.position.text = "中外野手"
        }
        else if sender.view!.tag == 9 || sender.view!.tag == 19 {
            self.position.text = "右外野手"
        }
        }
         //   self.runnerOnBase.text = "三壘有人"
        else{
            baseballFieldOfError.alpha = 0
            self.result.text = ""
            self.position.text = ""
        }
    }
    
    //拖曳捕手，決定暴投或捕逸(待測試)
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
    
       override func viewDidLoad() {
        super.viewDidLoad()
        //let playerRef = rootRef.child("player")
        ref = FIRDatabase.database().reference()
        let playerRef = ref?.child("player")
        let myTeamRef = ref?.child("teams").child("Yankees")
        let fieldingOrderRef = myTeamRef?.child("Fielding")
        playerRef?.observe(FIRDataEventType.value,with:{(snap: FIRDataSnapshot)in
            self.test.text = (snap.value as AnyObject).description
        })
        myTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.AwayTeam.text = (snap.value as AnyObject).description
        })
        fieldingOrderRef?.child("SS").observe(FIRDataEventType.value, with: {(snap:FIRDataSnapshot)in
            self.homePlayer6Name.text = (snap.value as AnyObject).description
            self.homePlayer6Name.center.x = CGFloat(self.shortStopNameX)
            self.homePlayer6Name.center.y = CGFloat(self.shortStopNameY)
        })
        
        
        
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
        //點兩下觸發叫下一位打者
        let tapGestureRecognizerCallNextBatter = UITapGestureRecognizer(target: self, action: #selector(call(_:)))
        tapGestureRecognizerCallNextBatter.numberOfTapsRequired = 2
        baseballField.isUserInteractionEnabled = true
        baseballField.addGestureRecognizer(tapGestureRecognizerCallNextBatter)
        
        let tapGestureRecognizerErrorModeHome1 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome1.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome2 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome2.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome3 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome3.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome4 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome4.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome5 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome5.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome6 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome6.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome7 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome7.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome8 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome8.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeHome9 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeHome9.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway1 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway1.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway2 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway2.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway3 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway3.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway4 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway4.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway5 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway5.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway6 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway6.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway7 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway7.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway8 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway8.numberOfTapsRequired = 3
        let tapGestureRecognizerErrorModeAway9 = UITapGestureRecognizer(target: self, action: #selector (errorMode(sender:)))
        tapGestureRecognizerErrorModeAway9.numberOfTapsRequired = 3
    

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
        homePlayer1.addGestureRecognizer(tapGestureRecognizerErrorModeHome1)
        panGestureRecognizerBattingResultHome1.isEnabled = false

        awayPlayer1.isUserInteractionEnabled = true
        awayPlayer1.addGestureRecognizer(panGestureRecognizerBattingResultAway1)
        awayPlayer1.addGestureRecognizer(tapGestureRecognizerErrorModeAway1)

        homePlayer2.isUserInteractionEnabled = true
        homePlayer2.addGestureRecognizer(panGestureRecognizerPBorWP)
        homePlayer2.addGestureRecognizer(panGestureRecognizerBattingResultHome2)
        homePlayer2.addGestureRecognizer(tapGestureRecognizerErrorModeHome2)

        awayPlayer2.isUserInteractionEnabled = true
        awayPlayer2.addGestureRecognizer(panGestureRecognizerBattingResultAway2)
        awayPlayer2.addGestureRecognizer(tapGestureRecognizerErrorModeAway2)
        
        
        homePlayer3.isUserInteractionEnabled = true
        homePlayer3.addGestureRecognizer(panGestureRecognizerBattingResultHome3)
        homePlayer3.addGestureRecognizer(tapGestureRecognizerErrorModeHome3)

        awayPlayer3.isUserInteractionEnabled = true
        awayPlayer3.addGestureRecognizer(panGestureRecognizerBattingResultAway3)
        awayPlayer3.addGestureRecognizer(tapGestureRecognizerErrorModeAway3)

        homePlayer4.isUserInteractionEnabled = true
        homePlayer4.addGestureRecognizer(panGestureRecognizerBattingResultHome4)
        homePlayer4.addGestureRecognizer(tapGestureRecognizerErrorModeHome4)

        awayPlayer4.isUserInteractionEnabled = true
        awayPlayer4.addGestureRecognizer(panGestureRecognizerBattingResultAway4)
        awayPlayer4.addGestureRecognizer(tapGestureRecognizerErrorModeAway4)

        homePlayer5.isUserInteractionEnabled = true
        homePlayer5.addGestureRecognizer(panGestureRecognizerBattingResultHome5)
        homePlayer5.addGestureRecognizer(tapGestureRecognizerErrorModeHome5)
        
        awayPlayer5.isUserInteractionEnabled = true
        awayPlayer5.addGestureRecognizer(panGestureRecognizerBattingResultAway5)
        awayPlayer5.addGestureRecognizer(tapGestureRecognizerErrorModeAway5)
        
        homePlayer6.isUserInteractionEnabled = true
        homePlayer6.addGestureRecognizer(panGestureRecognizerBattingResultHome6)
        homePlayer6.addGestureRecognizer(tapGestureRecognizerErrorModeHome6)
        
        awayPlayer6.isUserInteractionEnabled = true
        awayPlayer6.addGestureRecognizer(panGestureRecognizerBattingResultAway6)
        awayPlayer6.addGestureRecognizer(tapGestureRecognizerErrorModeAway6)
        
        homePlayer7.isUserInteractionEnabled = true
        homePlayer7.addGestureRecognizer(panGestureRecognizerBattingResultHome7)
        homePlayer7.addGestureRecognizer(tapGestureRecognizerErrorModeHome7)
        
        awayPlayer7.isUserInteractionEnabled = true
        awayPlayer7.addGestureRecognizer(panGestureRecognizerBattingResultAway7)
        awayPlayer7.addGestureRecognizer(tapGestureRecognizerErrorModeAway7)
    
        homePlayer8.isUserInteractionEnabled = true
        homePlayer8.addGestureRecognizer(panGestureRecognizerBattingResultHome8)
        homePlayer8.addGestureRecognizer(tapGestureRecognizerErrorModeHome8)
        
        awayPlayer8.isUserInteractionEnabled = true
        awayPlayer8.addGestureRecognizer(panGestureRecognizerBattingResultAway8)
        awayPlayer8.addGestureRecognizer(tapGestureRecognizerErrorModeAway8)
        
        homePlayer9.isUserInteractionEnabled = true
        homePlayer9.addGestureRecognizer(panGestureRecognizerBattingResultHome9)
        homePlayer9.addGestureRecognizer(tapGestureRecognizerErrorModeHome9)
        
        awayPlayer9.isUserInteractionEnabled = true
        awayPlayer9.addGestureRecognizer(panGestureRecognizerBattingResultAway9)
        awayPlayer9.addGestureRecognizer(tapGestureRecognizerErrorModeAway9)
  
        
        
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
  
        /*
        let panRecognizer = UIPanGestureRecognizer(target: self, action: (Selector("pan")))

        addGestureRecognizer(panRecognizer)
*/

 
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
