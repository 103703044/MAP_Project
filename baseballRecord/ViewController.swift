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
    
    let base1X = 344.0
    let base1Y = 180.0
    let base2X = 249
    let base2Y = 104
    let base3X = 155
    let base3Y = 180
    let base0X = 226
    let base0Y = 260
    let base4X = 249
    let base4Y = 260
    
    func setDefence(){
        var whichTeamDefence = 1
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {
            if self.awayOrHome == 1 {
                whichTeamDefence = 0
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 360
                    self.batters[self.awayOrHome][i].center.y = 250
                }
            }
            else{
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 100
                    self.batters[self.awayOrHome][i].center.y = 250
                }
            }
        })
        UIView.animate(withDuration: 1.0, delay: 2.0, animations: {
            for i in 0 ... 8{
                self.batters[whichTeamDefence][i].alpha = 1.0
            }
            self.batters[whichTeamDefence][0].center.x = 242
            self.batters[whichTeamDefence][0].center.y = 171
            self.batters[whichTeamDefence][1].center.x = 242
            self.batters[whichTeamDefence][1].center.y = 288
            self.batters[whichTeamDefence][2].center.x = 344
            self.batters[whichTeamDefence][2].center.y = 154
            self.batters[whichTeamDefence][3].center.x = 294
            self.batters[whichTeamDefence][3].center.y = 111
            self.batters[whichTeamDefence][4].center.x = 144
            self.batters[whichTeamDefence][4].center.y = 154
            self.batters[whichTeamDefence][5].center.x = 197
            self.batters[whichTeamDefence][5].center.y = 111
            self.batters[whichTeamDefence][6].center.x = 369
            self.batters[whichTeamDefence][6].center.y = 84
            self.batters[whichTeamDefence][7].center.x = 242
            self.batters[whichTeamDefence][7].center.y = 53
            self.batters[whichTeamDefence][8].center.x = 119
            self.batters[whichTeamDefence][8].center.y = 84
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
            if self.batters[awayOrHome][i].center.x == 206 &&
                self.batters[awayOrHome][i].center.y == 260{
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 344
                    self.batters[self.awayOrHome][i].center.y = 180
                })

            }
                
            else if self.batters[awayOrHome][i].center.x == 344 &&
                self.batters[awayOrHome][i].center.y == 180 {
                UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                    self.batters[self.awayOrHome][i].center.x = 249
                    self.batters[self.awayOrHome][i].center.y = 104
                })
            }
            else if self.batters[awayOrHome][i].center.x == 249 &&
                self.batters[awayOrHome][i].center.y == 104 {
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 155
                    self.batters[self.awayOrHome][i].center.y = 180
                })
            }
            else if self.batters[awayOrHome][i].center.x == 155 &&
                self.batters[awayOrHome][i].center.y == 180 {
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 249
                    self.batters[self.awayOrHome][i].center.y = 260
                })
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j) ,animations: {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    if self.awayOrHome == 0{
                        self.batters[self.awayOrHome][i].center.x = 100
                    }
                    if self.awayOrHome == 1{
                        self.batters[self.awayOrHome][i].center.x = 360
                    }
                    self.batters[self.awayOrHome][i].center.y = 250
                })
                scoring(whichTeam: awayOrHome)
                }
            }
        }
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
            for i in 0 ... 8 {
             if self.batters[awayOrHome][i].center.x != 100 &&
                self.batters[awayOrHome][i].center.y != 250{
                UIView.animate(withDuration: 1.0,animations: {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 100
                    self.batters[self.awayOrHome][i].center.y = 250
                })
            }
        }
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
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 206
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = 260
         })
    }

    @IBAction func batterOut(sender: AnyObject){
        UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 0.0
            if self.awayOrHome == 0 {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 100
            }
            else{
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 360
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = 250
            self.out = self.out + 1
            self.outChecking(Count: self.out)
        })
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
                strike = strike + 1
                callStrike(count: strike)
                self.context.text = "faul"
            }
            baseball.center.x = 220
            baseball.center.y = 235
        }
    }
    @IBAction func pitch(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: homePlayer1)
        homePlayer1.center.x = homePlayer1.center.x + point.x
        homePlayer1.center.y = homePlayer1.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
       if homePlayer1.center.x > 217 && homePlayer1.center.x < 277 && homePlayer1.center.y > 263 {
        strike = strike + 1
        callStrike(count: strike)
        self.context.text = "strike" + String (strike)
            }
       else if homePlayer1.center.x > 167 && homePlayer1.center.x < 217 && homePlayer1.center.y > 253 && homePlayer1.center.y < 293 {
        self.context.text = "HBP"
        countReset()
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
            }
       else {
        ball = ball + 1
        callBall(count: ball)
        self.context.text = "Ball" + String (ball)
            }
        homePlayer1.center.x = 242
        homePlayer1.center.y = 171
    

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
         homePlayer2.center.x = 249
         homePlayer2.center.y = 288
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        batters = [[awayPlayer1,awayPlayer2,awayPlayer3,awayPlayer4,awayPlayer5,awayPlayer6,awayPlayer7,awayPlayer8,awayPlayer9] , [homePlayer1,homePlayer2,homePlayer3,homePlayer4,homePlayer5,homePlayer6,homePlayer7,homePlayer8,homePlayer9]]

        
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
        let panGestureRecognizerHit = UIPanGestureRecognizer(target: self, action: #selector(hit(sender:)))
        let panGestureRecognizerPBorWP = UIPanGestureRecognizer(target: self, action: #selector(PBorWP(sender:)))
        let panGestureRecognizerPitch = UIPanGestureRecognizer(target: self, action: #selector(pitch(sender:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        baseball.isUserInteractionEnabled = true
        baseball.addGestureRecognizer(panGestureRecognizerHit)
        homePlayer1.isUserInteractionEnabled = true
        homePlayer1.addGestureRecognizer(panGestureRecognizerPitch)
        homePlayer2.isUserInteractionEnabled = true
        homePlayer2.addGestureRecognizer(panGestureRecognizerPBorWP)
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
