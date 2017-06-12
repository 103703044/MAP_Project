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
    @IBOutlet var context: UILabel!
    
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
        if count == 1{
            strikeCount.text = "● ○"
        }
        else if count == 2{
            strikeCount.text = "● ●"
        }
        else{
            batterOutFunc()
            countReset()
        }
    }
    func callBall(count: Int){
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
                self.context.text = "faul"
                baseball.center.x = CGFloat(hitBallX)
                baseball.center.y = CGFloat(hitBallY)
            }
    
            else if baseball.center.x > CGFloat(pitcherX - 30)
            && baseball.center.x < CGFloat(pitcherX + 30)
            && baseball.center.y > CGFloat(pitcherY - 30)
            && baseball.center.y < CGFloat(pitcherY + 30){
                self.context.text = "投手方向"
            }
            else if baseball.center.x > CGFloat(catcherX - 30)
                && baseball.center.x < CGFloat(catcherX + 30)
                && baseball.center.y > CGFloat(catcherY - 30)
                && baseball.center.y < CGFloat(catcherY + 30){
                self.context.text = "本壘方向"
            }
            else if baseball.center.x > CGFloat(firstBaseX - 30)
                && baseball.center.x < CGFloat(firstBaseX + 30)
                && baseball.center.y > CGFloat(firstBaseY - 30)
                && baseball.center.y < CGFloat(firstBaseY + 30){
                self.context.text = "一壘方向"
            }
            else if baseball.center.x > CGFloat(secondBaseX - 30)
                && baseball.center.x < CGFloat(secondBaseX + 30)
                && baseball.center.y > CGFloat(secondBaseY - 30)
                && baseball.center.y < CGFloat(secondBaseY + 30){
                self.context.text = "二壘方向"
            }
            else if baseball.center.x > CGFloat(thirdBaseX - 30)
                && baseball.center.x < CGFloat(thirdBaseX + 30)
                && baseball.center.y > CGFloat(thirdBaseY - 30)
                && baseball.center.y < CGFloat(thirdBaseY + 30){
                self.context.text = "三壘方向"
            }
            else if baseball.center.x > CGFloat(shortStopX - 30)
                && baseball.center.x < CGFloat(shortStopX + 30)
                && baseball.center.y > CGFloat(shortStopY - 30)
                && baseball.center.y < CGFloat(shortStopY + 30){
                self.context.text = "游擊方向"
            }
            else if baseball.center.x > CGFloat(centerFielderX - 30)
                && baseball.center.x < CGFloat(centerFielderX + 30)
                && baseball.center.y > CGFloat(centerFielderY - 30)
                && baseball.center.y < CGFloat(centerFielderY + 30){
                self.context.text = "中外野方向"
            }
            else if baseball.center.x > CGFloat(rightFielderX - 30)
                && baseball.center.x < CGFloat(rightFielderX + 30)
                && baseball.center.y > CGFloat(rightFielderY - 30)
                && baseball.center.y < CGFloat(rightFielderY + 30){
                self.context.text = "右外野方向"
            }
            else if baseball.center.x > CGFloat(leftFielderX - 30)
                && baseball.center.x < CGFloat(leftFielderX + 30)
                && baseball.center.y > CGFloat(leftFielderY - 30)
                && baseball.center.y < CGFloat(leftFielderY + 30){
                self.context.text = "左外野方向"
            }
            

        }
    }


    @IBAction func battingResult(sender: UIPanGestureRecognizer) {
    let point = sender.location(in: awayPlayer1)
    awayPlayer1.center.x = awayPlayer1.center.x + point.x
    awayPlayer1.center.y = awayPlayer1.center.y + point.y
    if sender.state == UIGestureRecognizerState.ended {
        if awayPlayer1.center.x > CGFloat(base1X - 30)
            && awayPlayer1.center.x < CGFloat(base1X + 30)
            && awayPlayer1.center.y > CGFloat(base1Y - 30)
            && awayPlayer1.center.y < CGFloat(base1Y + 30){
            self.context.text = "一壘安打"
        }
        else if view.center.x > CGFloat(base2X - 30)
            && view.center.x < CGFloat(base2X + 30)
            && view.center.y > CGFloat(base2Y - 30)
            && view.center.y < CGFloat(base2Y + 30){
            self.context.text = "二壘安打"
        }
        else if view.center.x > CGFloat(base3X - 30)
            && view.center.x < CGFloat(base3X + 30)
            && view.center.y > CGFloat(base3Y - 30)
            && view.center.y < CGFloat(base3Y + 30){
            self.context.text = "三壘安打"
        }
        else if view.center.x > CGFloat(homeBaseX - 30)
            && view.center.x < CGFloat(homeBaseX + 30)
            && view.center.y > CGFloat(homeBaseY - 30)
            && view.center.y < CGFloat(homeBaseY + 30){
            self.context.text = "全壘打"
        }
        baseball.center.x = CGFloat(hitBallX)
        baseball.center.y = CGFloat(hitBallY)
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
        self.context.text = "strike" + String (strike)
            }
       else if pitchingBall.center.x > 167 && pitchingBall.center.x < 217 && pitchingBall.center.y > 243 && pitchingBall.center.y < 293 {
        self.context.text = "HBP"
        countReset()
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
            }
       else {
        ball = ball + 1
        callBall(count: ball)
        self.context.text = "Ball" + String (ball)
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
        context.text = "WP" + String(max)

        homePlayer2.center.x = homePlayer2.center.x + point.x
        homePlayer2.center.y = homePlayer2.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            if homePlayer2.center.y > 205 {

            if max == 1{
                    context.text = "WP" + String(max)
                }
            else if max == 2{
                   context.text = "PB"
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
        let panGestureRecognizerBattingResult = UIPanGestureRecognizer(target: self, action: #selector(battingResult(sender:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        baseball.isUserInteractionEnabled = true
        baseball.addGestureRecognizer(panGestureRecognizerHit)
        
        pitchingBall.isUserInteractionEnabled = true
        pitchingBall.addGestureRecognizer(panGestureRecognizerPitch)
        
        homePlayer1.isUserInteractionEnabled = true
        homePlayer1.addGestureRecognizer(panGestureRecognizerBattingResult)

        awayPlayer1.isUserInteractionEnabled = true
        awayPlayer1.addGestureRecognizer(panGestureRecognizerBattingResult)

        homePlayer2.isUserInteractionEnabled = true
        homePlayer2.addGestureRecognizer(panGestureRecognizerPBorWP)
        homePlayer2.addGestureRecognizer(panGestureRecognizerBattingResult)

        awayPlayer2.isUserInteractionEnabled = true
        awayPlayer2.addGestureRecognizer(panGestureRecognizerPBorWP)
        awayPlayer2.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        
        homePlayer3.isUserInteractionEnabled = true
        homePlayer3.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer3.isUserInteractionEnabled = true
        awayPlayer3.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer4.isUserInteractionEnabled = true
        homePlayer4.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer4.isUserInteractionEnabled = true
        awayPlayer4.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer5.isUserInteractionEnabled = true
        homePlayer5.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer5.isUserInteractionEnabled = true
        awayPlayer5.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer6.isUserInteractionEnabled = true
        homePlayer6.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer6.isUserInteractionEnabled = true
        awayPlayer6.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer7.isUserInteractionEnabled = true
        homePlayer7.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer7.isUserInteractionEnabled = true
        awayPlayer7.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer8.isUserInteractionEnabled = true
        homePlayer8.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer8.isUserInteractionEnabled = true
        awayPlayer8.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        homePlayer9.isUserInteractionEnabled = true
        homePlayer9.addGestureRecognizer(panGestureRecognizerBattingResult)
        
        awayPlayer9.isUserInteractionEnabled = true
        awayPlayer9.addGestureRecognizer(panGestureRecognizerBattingResult)
        
  
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
