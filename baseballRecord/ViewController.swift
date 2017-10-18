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

//---------------IBoutlet&varible number-------------------------


class ViewController: UIViewController{
    
    @IBOutlet weak var test: UILabel!
    var ref:FIRDatabaseReference?
  //  let rootRef = FIRDatabase.database().reference()
    
    
    var players = [String: Player]()
    var playerClassList = [Player]()
    var playerTest = [Player]()

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
    var panGesture = [[UIPanGestureRecognizer]]()
    var tapGesture = [[UITapGestureRecognizer]]()
    //
    var awayPitcher = 0
    var homePitcher = 0
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
    var callingCount = 0
    
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
        playerName.text = ""
        playerPosition.text = ""
        playerBA.text = ""
        playerHit.text = ""
        playerBattingOrder.text = ""
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {
            if self.awayOrHome == 1 {
                //主隊進攻
                whichTeamDefence = 0
                for i in 0 ... 8 {
                    self.batters[1][i].alpha = 0.0
                    self.batters[1][i].center.x = CGFloat(self.homeBenchX)
                    self.batters[1][i].center.y = CGFloat(self.homeBenchY)
                    //投手資訊
                    self.pitchName.text? = (self.players[self.batters[0][self.awayPitcher].text!]?.getName())!
                    self.pitchIP.text? = (self.players[self.batters[0][self.awayPitcher].text!]?.getPitchIP())!
                    self.pitchERA.text? = (self.players[self.batters[0][self.awayPitcher].text!]?.getERA())!
                    self.pitchH.text? = (self.players[self.batters[0][self.awayPitcher].text!]?.getPitchH())!
                }
            }
            else{
                //客隊進攻
                for i in 0 ... 8 {
                    self.batters[0][i].alpha = 0.0
                    self.batters[0][i].center.x = CGFloat(self.awayBenchX)
                    self.batters[0][i].center.y = CGFloat(self.awayBenchY)
                    //投手資訊
                    self.pitchName.text? = (self.players[self.batters[1][self.homePitcher].text!]?.getName())!
                    self.pitchIP.text? = (self.players[self.batters[1][self.homePitcher].text!]?.getPitchIP())!
                    self.pitchERA.text? = (self.players[self.batters[1][self.homePitcher].text!]?.getERA())!
                    self.pitchH.text? = (self.players[self.batters[1][self.homePitcher].text!]?.getPitchH())!
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
    print(players)
        callingCount += 1
        if callingCount == 1{
        for i in 0...8{
            if players[batters[1][i].text!]?.position == "P"{
                homePitcher = i
            }
            if players[batters[0][i].text!]?.position == "P"{
                awayPitcher = i
            }
        }
        if self.awayOrHome == 0{
            pitchName.text? = (players[self.batters[1][homePitcher].text!]?.getName())!
            pitchIP.text? = (players[self.batters[1][homePitcher].text!]?.getPitchIP())!
            pitchERA.text? = (players[self.batters[1][homePitcher].text!]?.getERA())!
            pitchH.text? = (players[self.batters[1][homePitcher].text!]?.getPitchH())!
        }
        else{
            pitchName.text? = (players[self.batters[0][awayPitcher].text!]?.getName())!
            pitchIP.text? = (players[self.batters[0][awayPitcher].text!]?.getPitchIP())!
            pitchERA.text? = (players[self.batters[0][awayPitcher].text!]?.getERA())!
            pitchH.text? = (players[self.batters[0][awayPitcher].text!]?.getPitchH())!
            }
    }
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
        playerBattingOrder.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBattingOrder())!)"
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
    @IBAction func battingResultFunction(sender: UIPanGestureRecognizer) {
        let senderTag = sender.view!.tag
        let point = sender.location(in: sender.view?.viewWithTag(senderTag)!)
        self.view?.viewWithTag(senderTag)?.center.x = (self.view?.viewWithTag(senderTag)?.center.x)! + point.x
        self.view?.viewWithTag(senderTag)?.center.y = (self.view?.viewWithTag(senderTag)?.center.y)! + point.y
        if sender.state == UIGestureRecognizerState.ended {
            //   awayPlayer1.isUserInteractionEnabled = false
            self.battingResult()
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

       override func viewDidLoad() {
        super.viewDidLoad()
        print(self.players)
        print(self.playerClassList)
        print("12345")
        //let playerRef = rootRef.child("player")
        ref = FIRDatabase.database().reference()
        let playerRef = ref?.child("player")
        let PlayerRef = ref?.child("Player")
        let awayTeamRef = ref?.child("teams").child("Yankees")
        let homeTeamRef = ref?.child("teams").child("Phillies")
        let awayBattingOrderRef = awayTeamRef?.child("order")
        let homeBattingOrderRef = homeTeamRef?.child("order")
        let gameKey = ref?.child("Game").childByAutoId().key

   /*
        playerRef?.observe(FIRDataEventType.value,with:{(snap: FIRDataSnapshot)in
            self.test.text = (snap.value as AnyObject).description
        })
 */
        awayTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("posts").child(gameKey!).child("Away").setValue(snap.value)
            self.AwayTeam.text = (snap.value as AnyObject).description
        })
        homeTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("posts").child(gameKey!).child("Home").setValue(snap.value)
            self.HomeTeam.text = (snap.value as AnyObject).description
        })

        
        batters = [[awayPlayer1,awayPlayer2,awayPlayer3,awayPlayer4,awayPlayer5,awayPlayer6,awayPlayer7,awayPlayer8,awayPlayer9] , [homePlayer1,homePlayer2,homePlayer3,homePlayer4,homePlayer5,homePlayer6,homePlayer7,homePlayer8,homePlayer9]]
        //初始化選手資料
        
        awayPlayer1.text? = "①"
        awayBattingOrderRef?.child("1/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("1/Position").observe(FIRDataEventType.value,with:{(position)in
                let player11 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 1)
                self.playerTest.append(player11)
                print (self.playerTest[0].name)
                self.players.updateValue(player11, forKey: "①")
                /*
                playerRef?.child("PlayerID3/BattingStatic/AB").observe(FIRDataEventType.value, with: {(AB)in
                    player10.atBatOverall = AB.value as? Int
                    let atbat = AB.value
                    print(atbat!)
                    print(AB.value!)
                    print(AB.key)
                    print(player10.atBatOverall!)
                })
 */
        })
        })

        
        
        awayPlayer2.text? = "②"
        awayBattingOrderRef?.child("2/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("2/Position").observe(FIRDataEventType.value,with:{(position)in
                let player12 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 2)
                self.playerTest.append(player12)
                print (self.playerTest[1].name)
                self.players.updateValue(player12, forKey: "②")
            })
        })

        awayPlayer3.text? = "③"
        awayBattingOrderRef?.child("3/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("3/Position").observe(FIRDataEventType.value,with:{(position)in
                let player13 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 3)
                self.playerTest.append(player13)
   //             print (self.playerTest[2].name)
                self.players.updateValue(player13, forKey: "③")
            })
        })
        
        awayPlayer4.text? = "④"
        awayBattingOrderRef?.child("4/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("4/Position").observe(FIRDataEventType.value,with:{(position)in
                let player14 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 4)
                self.players.updateValue(player14, forKey: "④")
            })
        })
        
        awayPlayer5.text? = "⑤"
        awayBattingOrderRef?.child("5/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("5/Position").observe(FIRDataEventType.value,with:{(position)in
                let player15 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 5)
                self.players.updateValue(player15, forKey: "⑤")
            })
        })
        
        awayPlayer6.text? = "⑥"
        awayBattingOrderRef?.child("6/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("6/Position").observe(FIRDataEventType.value,with:{(position)in
                let player16 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 6)
                self.players.updateValue(player16, forKey: "⑥")
            })
        })
        
        
        awayPlayer7.text? = "⑦"
        awayBattingOrderRef?.child("7/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("7/Position").observe(FIRDataEventType.value,with:{(position)in
                let player17 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 7)
                self.players.updateValue(player17, forKey: "⑦")
            })
        })
        
        awayPlayer8.text? = "⑧"
        awayBattingOrderRef?.child("8/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("8/Position").observe(FIRDataEventType.value,with:{(position)in
                let player18 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 8)
                self.players.updateValue(player18, forKey: "⑧")
            })
        })
        
        
        awayPlayer9.text? = "⑨"
        awayBattingOrderRef?.child("9/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("9/Position").observe(FIRDataEventType.value,with:{(position)in
                let player19 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 9)
                self.players.updateValue(player19, forKey: "⑨")
            })
        })
        
        homePlayer1.text? = "❶"
        homeBattingOrderRef?.child("1/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("1/Position").observe(FIRDataEventType.value,with:{(position)in
                let player31 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 1)
                self.players.updateValue(player31, forKey: "❶")
            })
        })
        
        homePlayer2.text? = "❷"
        homeBattingOrderRef?.child("2/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("2/Position").observe(FIRDataEventType.value,with:{(position)in
                let player32 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 2)
                self.players.updateValue(player32, forKey: "❷")
            })
        })
        
        homePlayer3.text? = "❸"
        homeBattingOrderRef?.child("3/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("3/Position").observe(FIRDataEventType.value,with:{(position)in
                let player33 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 3)
                self.players.updateValue(player33, forKey: "❸")
            })
        })
        
        homePlayer4.text? = "❹"
        homeBattingOrderRef?.child("4/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("4/Position").observe(FIRDataEventType.value,with:{(position)in
                let player34 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 4)
                self.players.updateValue(player34, forKey: "❹")
            })
        })
        
        homePlayer5.text? = "❺"
        homeBattingOrderRef?.child("5/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("5/Position").observe(FIRDataEventType.value,with:{(position)in
                let player35 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 5)
                self.players.updateValue(player35, forKey: "❺")
            })
        })
        
        homePlayer6.text? = "❻"
        homeBattingOrderRef?.child("6/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("6/Position").observe(FIRDataEventType.value,with:{(position)in
                let player36 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 6)
                self.players.updateValue(player36, forKey: "❻")
            })
        })
        
        homePlayer7.text? = "❼"
        homeBattingOrderRef?.child("7/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("7/Position").observe(FIRDataEventType.value,with:{(position)in
                let player37 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 7)
                self.players.updateValue(player37, forKey: "❼")
            })
        })
        
        homePlayer8.text? = "❽"
        homeBattingOrderRef?.child("8/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("8/Position").observe(FIRDataEventType.value,with:{(position)in
                let player38 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 8)
                self.players.updateValue(player38, forKey: "❽")
            })
        })
        
        homePlayer9.text? = "❾"
        homeBattingOrderRef?.child("9/Name").observe(FIRDataEventType.value, with: {(name)in
            homeBattingOrderRef?.child("9/Position").observe(FIRDataEventType.value,with:{(position)in
                let player39 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 9)
                self.players.updateValue(player39, forKey: "❾")
            })
        })

        //開局投手資訊

        
  /*
        inningScore = [[top1,top2,top3,top4,top5,top6,top7,top8,top9],[bottom1,bottom2,bottom3,bottom4,bottom5,bottom6,bottom7,bottom8,bottom9]]
    */
        
        
        //----------------------Gesture-------------------
        //點兩下觸發叫下一位打者
        let tapGestureRecognizerCallNextBatter = UITapGestureRecognizer(target: self, action: #selector(call(_:)))
        tapGestureRecognizerCallNextBatter.numberOfTapsRequired = 2
        baseballField.addGestureRecognizer(tapGestureRecognizerCallNextBatter)
        //擊出位置
        let panGestureRecognizerHit = UIPanGestureRecognizer(target: self, action: #selector(hit(sender:)))
        baseball.addGestureRecognizer(panGestureRecognizerHit)
        //暴投
        let panGestureRecognizerPBorWP = UIPanGestureRecognizer(target: self, action: #selector(PBorWP(sender:)))
        //投球
        let panGestureRecognizerPitch = UIPanGestureRecognizer(target: self, action: #selector(pitch(sender:)))
        pitchingBall.addGestureRecognizer(panGestureRecognizerPitch)

        //失誤&打擊結果
        
        let panBattingResultAP1 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP1 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP1.numberOfTapsRequired = 3
        batters[0][0].addGestureRecognizer(tapErrorModeAP1)
        batters[0][0].addGestureRecognizer(panBattingResultAP1)
        
        let panBattingResultAP2 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP2 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP2.numberOfTapsRequired = 3
        batters[0][1].addGestureRecognizer(tapErrorModeAP2)
        batters[0][1].addGestureRecognizer(panBattingResultAP2)
        
        
        let panBattingResultAP3 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP3 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP3.numberOfTapsRequired = 3
        batters[0][2].addGestureRecognizer(tapErrorModeAP3)
        batters[0][2].addGestureRecognizer(panBattingResultAP3)
        
        
        let panBattingResultAP4 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP4 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP4.numberOfTapsRequired = 3
        batters[0][3].addGestureRecognizer(tapErrorModeAP4)
        batters[0][3].addGestureRecognizer(panBattingResultAP4)
        
        let panBattingResultAP5 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP5 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP5.numberOfTapsRequired = 3
        batters[0][4].addGestureRecognizer(tapErrorModeAP5)
        batters[0][4].addGestureRecognizer(panBattingResultAP5)
        
        let panBattingResultAP6 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP6 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP6.numberOfTapsRequired = 3
        batters[0][5].addGestureRecognizer(tapErrorModeAP6)
        batters[0][5].addGestureRecognizer(panBattingResultAP6)
        
        let panBattingResultAP7 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP7 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP7.numberOfTapsRequired = 3
        batters[0][6].addGestureRecognizer(tapErrorModeAP7)
        batters[0][6].addGestureRecognizer(panBattingResultAP7)
        
        let panBattingResultAP8 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP8 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP8.numberOfTapsRequired = 3
        batters[0][7].addGestureRecognizer(tapErrorModeAP8)
        batters[0][7].addGestureRecognizer(panBattingResultAP8)
        
        let panBattingResultAP9 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeAP9 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeAP9.numberOfTapsRequired = 3
        batters[0][8].addGestureRecognizer(tapErrorModeAP9)
        batters[0][8].addGestureRecognizer(panBattingResultAP9)
        
        let panBattingResultHP1 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP1 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP1.numberOfTapsRequired = 3
        batters[1][0].addGestureRecognizer(tapErrorModeHP1)
        batters[1][0].addGestureRecognizer(panBattingResultHP1)
        
        let panBattingResultHP2 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP2 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP2.numberOfTapsRequired = 3
        batters[1][1].addGestureRecognizer(tapErrorModeHP2)
        batters[1][1].addGestureRecognizer(panBattingResultHP2)
        
        let panBattingResultHP3 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP3 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP3.numberOfTapsRequired = 3
        batters[1][2].addGestureRecognizer(tapErrorModeHP3)
        batters[1][2].addGestureRecognizer(panBattingResultHP3)
        
        let panBattingResultHP4 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP4 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP4.numberOfTapsRequired = 3
        batters[1][3].addGestureRecognizer(tapErrorModeHP4)
        batters[1][3].addGestureRecognizer(panBattingResultHP4)
        
        let panBattingResultHP5 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP5 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP5.numberOfTapsRequired = 3
        batters[1][4].addGestureRecognizer(tapErrorModeHP5)
        batters[1][4].addGestureRecognizer(panBattingResultHP5)
        
        let panBattingResultHP6 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP6 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP6.numberOfTapsRequired = 3
        batters[1][5].addGestureRecognizer(tapErrorModeHP6)
        batters[1][5].addGestureRecognizer(panBattingResultHP6)
        
        let panBattingResultHP7 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP7 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP7.numberOfTapsRequired = 3
        batters[1][6].addGestureRecognizer(tapErrorModeHP7)
        batters[1][6].addGestureRecognizer(panBattingResultHP7)
        
        let panBattingResultHP8 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP8 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP8.numberOfTapsRequired = 3
        batters[1][7].addGestureRecognizer(tapErrorModeHP8)
        batters[1][7].addGestureRecognizer(panBattingResultHP8)
        
        let panBattingResultHP9 = UIPanGestureRecognizer(target: self, action: #selector(battingResultFunction(sender:)))
        let tapErrorModeHP9 = UITapGestureRecognizer(target: self, action: #selector(errorMode(sender:)))
        tapErrorModeHP9.numberOfTapsRequired = 3
        batters[1][8].addGestureRecognizer(tapErrorModeHP9)
        batters[1][8].addGestureRecognizer(panBattingResultHP9)

        
        for i in 0 ... 1 {
            for j in 0 ... 8{
                batters[i][j].tag = i*100 + j+1+500
                batters[i][j].isUserInteractionEnabled = true
            }
        }
        baseballField.isUserInteractionEnabled = true
        baseball.isUserInteractionEnabled = true
        pitchingBall.isUserInteractionEnabled = true
        
        for i in 1 ... 3{
            PlayerRef?.child("PlayerList").child("\(i)").observe(FIRDataEventType.value,with:{(snap: FIRDataSnapshot)in
            print((snap.value as AnyObject).description)
        })
        }


/*
        var userID = "aaa"
        var username = "bbb"
        var title = "CCC"
        var body = "DDD"
        let key = ref?.child("test").childByAutoId().key
        let post = ["uid": userID,
                    "author": username,
                    "title": title,
                    "body": body]
        let childUpdates = ["/test/\(key)": post,
                            "/user-test/\(userID)/\(key)/": post]
        ref?.updateChildValues(childUpdates)
 */
 
 //       print(awayTeamRef?.child("Abbreviation").value(forKey: "Abbreviation"))
        /*
        let gameLog = ["Away" : awayTeamName,
                       "Home" : homeTeamName,
                       "Location" : "default"]
        let childUpdateEX = ["/Game/\(gameKey)":gameLog]
        ref?.updateChildValues(childUpdateEX)
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
