//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
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
    
    var batters = [[UILabel]]()
    var inningScore = [[UILabel]]()
    var batterOn = [-1 , -1]
    var out = 0
    var strike = 0
    var ball = 0
    var inning = 1
    var awayHits = 0
    var homeHits = 0
    var awayScoring = 0
    var homeScoring = 0
    var awayOrHome = 0
    var thisInningScore = 0
    
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
    
    let hitBallX = 220
    let hitBallY = 235
    let pitchBallX = 232
    let pitchBallY = 185
    
    //defender position
    let pitcherX = 232
    let pitcherY = 151
    let catcherX = 232
    let catcherY = 287
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
    }
    
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
    func inningCheck(whichTeam: Int) {
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
        if whichTeam == 0 {
            awayScoring = awayScoring + 1
            awayScore.text = String (awayScoring)
        }
        else{
            homeScoring = homeScoring + 1
            homeScore.text = String (homeScoring)
        }
    }
    
    func runner(batter: Int, bases: Int){
        for j in 1 ... bases {
        for i in 0 ... 8 {
            if self.batters[awayOrHome][i].center.x == CGFloat(self.inBoxX) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.inBoxY){
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base1X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base1Y)
                })

            }
                
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base1Y) {
                UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base2X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base2Y)
                })
            }
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base2X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base2Y) {
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = CGFloat(self.base3X)
                    self.batters[self.awayOrHome][i].center.y = CGFloat(self.base3Y)
                })
            }
            else if self.batters[awayOrHome][i].center.x == CGFloat(self.base3X) &&
                self.batters[awayOrHome][i].center.y == CGFloat(self.base3Y){
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
    @IBAction func callNextBatter(sender: AnyObject){
        self.result.text = ""
        self.position.text = ""
        UIView.animate(withDuration: 1.0,animations: {
            self.batterOn[self.awayOrHome] = self.batterOn[self.awayOrHome] + 1
            if self.batterOn[self.awayOrHome] == 9{
                self.batterOn[self.awayOrHome] = 0
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 1.0
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(self.inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(self.inBoxY)
         })
    }

    @IBAction func batterOut(sender: AnyObject){
        batterOutFunc()
    }
    
    @IBAction func takeOneBase(sender: AnyObject) {
        //0to1
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
        self.hitCheck(whichTeam: self.awayOrHome)
    }
    @IBAction func takeTwoBase( sender: AnyObject) {
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 2)
        self.hitCheck(whichTeam: self.awayOrHome)
    }
    @IBAction func takeThreeBase( sender: AnyObject) {
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 3)
        self.hitCheck(whichTeam: self.awayOrHome)
    }
    @IBAction func takeFourBase( sender: AnyObject) {
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 4)
        self.hitCheck(whichTeam: self.awayOrHome)
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
 
    @IBAction func hit(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: baseball)
        baseball.center.x = baseball.center.x + point.x
        baseball.center.y = baseball.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            if (baseball.center.x < 75 && baseball.center.y > 170) || (baseball.center.x < 148 && baseball.center.y > 210 ){
                if strike < 2 {
                strike = strike + 1
                }
                callStrike(count: strike)
                self.position.text = ""
                self.result.text = "界外球"
                baseball.center.x = CGFloat(hitBallX)
                baseball.center.y = CGFloat(hitBallY)
            }
    
            else if baseball.center.x > CGFloat(pitcherX - 30)
            && baseball.center.x < CGFloat(pitcherX + 30)
            && baseball.center.y > CGFloat(pitcherY - 30)
            && baseball.center.y < CGFloat(pitcherY + 30){
                self.result.text = ""
                self.position.text = "投手方向"
            }
            else if baseball.center.x > CGFloat(catcherX - 30)
                && baseball.center.x < CGFloat(catcherX + 30)
                && baseball.center.y > CGFloat(catcherY - 30)
                && baseball.center.y < CGFloat(catcherY + 30){
                self.result.text = ""
                self.position.text = "本壘方向"
            }
            else if baseball.center.x > CGFloat(firstBaseX - 30)
                && baseball.center.x < CGFloat(firstBaseX + 30)
                && baseball.center.y > CGFloat(firstBaseY - 30)
                && baseball.center.y < CGFloat(firstBaseY + 30){
                self.result.text = ""
                self.position.text = "一壘方向"
            }
            else if baseball.center.x > CGFloat(secondBaseX - 30)
                && baseball.center.x < CGFloat(secondBaseX + 30)
                && baseball.center.y > CGFloat(secondBaseY - 30)
                && baseball.center.y < CGFloat(secondBaseY + 30){
                self.result.text = ""
                self.position.text = "二壘方向"
            }
            else if baseball.center.x > CGFloat(thirdBaseX - 30)
                && baseball.center.x < CGFloat(thirdBaseX + 30)
                && baseball.center.y > CGFloat(thirdBaseY - 30)
                && baseball.center.y < CGFloat(thirdBaseY + 30){
                self.result.text = ""
                self.position.text = "三壘方向"
            }
            else if baseball.center.x > CGFloat(shortStopX - 30)
                && baseball.center.x < CGFloat(shortStopX + 30)
                && baseball.center.y > CGFloat(shortStopY - 30)
                && baseball.center.y < CGFloat(shortStopY + 30){
                self.result.text = ""
                self.position.text = "游擊方向"
            }
            else if baseball.center.x > CGFloat(centerFielderX - 30)
                && baseball.center.x < CGFloat(centerFielderX + 30)
                && baseball.center.y > CGFloat(centerFielderY - 30)
                && baseball.center.y < CGFloat(centerFielderY + 30){
                self.result.text = ""
                self.position.text = "中外野方向"
            }
            else if baseball.center.x > CGFloat(rightFielderX - 30)
                && baseball.center.x < CGFloat(rightFielderX + 30)
                && baseball.center.y > CGFloat(rightFielderY - 30)
                && baseball.center.y < CGFloat(rightFielderY + 30){
                self.result.text = ""
                self.position.text = "右外野方向"
            }
            else if baseball.center.x > CGFloat(leftFielderX - 30)
                && baseball.center.x < CGFloat(leftFielderX + 30)
                && baseball.center.y > CGFloat(leftFielderY - 30)
                && baseball.center.y < CGFloat(leftFielderY + 30){
                self.result.text = ""
                self.position.text = "左外野方向"
            }


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
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
                self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
                self.hitCheck(whichTeam: self.awayOrHome)
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base2X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base2X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base2Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base2Y + 30){
            delay = 2
            self.result.text = "二壘安打"
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 2)
            self.hitCheck(whichTeam: self.awayOrHome)
            
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(base3X - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(base3X + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(base3Y - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(base3Y + 30){
            delay = 3
            self.result.text = "三壘安打"
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 3)
            self.hitCheck(whichTeam: self.awayOrHome)
            
        }
        else if self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x > CGFloat(homeBaseX - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < CGFloat(homeBaseX + 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > CGFloat(homeBaseY - 30)
            && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y < CGFloat(homeBaseY + 30){
            delay = 4
            self.result.text = "全壘打"
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = CGFloat(inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = CGFloat(inBoxY)
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 4)
            self.hitCheck(whichTeam: self.awayOrHome)
        }
            
        else if (self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < 75
                && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 170)
                || (self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x < 148
                && self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y > 210){
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
        let point = sender.location(in: awayPlayer1)
        awayPlayer1.center.x = awayPlayer1.center.x + point.x
        awayPlayer1.center.y = awayPlayer1.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            battingResult()
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

        
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
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
  
  
        /*
        let panRecognizer = UIPanGestureRecognizer(target: self, action: (Selector("pan")))

        addGestureRecognizer(panRecognizer)
*/

        /*
        inningScore = [[top1,top2,top3,top4,top5,top6,top7,top8,top9],[bottom1,bottom2,bottom3,bottom4,bottom5,bottom6,bottom7,bottom8,bottom9]]
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
