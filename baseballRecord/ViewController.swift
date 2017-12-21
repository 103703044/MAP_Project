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


var fieldingTeam = 1
//var awayNP = 0
//var homeNP = 0
var errorModeState = 0
var awayPitcher = 0
var homePitcher = 0
var awayOrHome = 0 //0 = 客場進攻 1 = 主場進攻
var gameKey: String!
var careerAB = 0
var careerSO = 0
var careerBB = 0
var careerH = 0
var career2B = 0
var career3B = 0
var careerHR = 0
var careerPitchBB = 0
var careerIP = 0.0
var careerPitchSO = 0
var careerPitchH = 0
var careerCount = 0
var careerERA = 0.00
var careerPitchER = 0
var batterOn = [-1 , -1]
var out = 0 //出局數
var strike = 0 //好球數
var ball = 0 //壞球數
var inning = 1 //局數
var awayHits = 0 //客場安打數
var homeHits = 0 //主場安打數
var awayErrorCount = 0//客隊失誤數
var homeErrorCount = 0//主隊失誤數
var awayScoring = 0 //客場得分數
var homeScoring = 0 //主場得分數
var scoringOfTheInning = 0 //該局得分數
var callingCount = 0
var runnerStartPoint = CGPoint(x: 0.0, y: 0.0)
var switchPosition1 = ""
var switchPosition2 = ""
var switchPosition1Point = CGPoint(x: 0.0, y: 0.0)
var switchPosition2Point = CGPoint(x: 0.0, y: 0.0)
var eachPitchCount = 1
var eachBatterCount = 0
var topOrBot = "Top"
var battingPosition : String!
var homeRPCount = 0
var awayRPCount = 0

//---------------IBoutlet&varible number-------------------------


class ViewController: UIViewController{
    
    var ref:FIRDatabaseReference?
    //  let rootRef = FIRDatabase.database().reference()
    let date = Date()
    let formatter = DateFormatter()
    var players = [String: Player]()
    var playerClassList = [Player]()
    var playerTest = [Int:Player]()
    var playTest = [Player]()
    
    
    //客場球員1~9
    @IBOutlet weak var tapPlayerName: UILabel!
    @IBOutlet weak var tapPlayerBattingOrder: UILabel!
    @IBOutlet weak var tapPlayerPos: UILabel!
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
    
    @IBOutlet weak var APlayerImage1: UIImageView!
    @IBOutlet weak var APlayerImage2: UIImageView!
    @IBOutlet weak var APlayerImage3: UIImageView!
    @IBOutlet weak var APlayerImage4: UIImageView!
    @IBOutlet weak var APlayerImage5: UIImageView!
    @IBOutlet weak var APlayerImage6: UIImageView!
    @IBOutlet weak var APlayerImage7: UIImageView!
    @IBOutlet weak var APlayerImage8: UIImageView!
    @IBOutlet weak var APlayerImage9: UIImageView!
    
    @IBOutlet weak var HPlayerImage1: UIImageView!
    @IBOutlet weak var HPlayerImage2: UIImageView!
    @IBOutlet weak var HPlayerImage3: UIImageView!
    @IBOutlet weak var HPlayerImage4: UIImageView!
    @IBOutlet weak var HPlayerImage5: UIImageView!
    @IBOutlet weak var HPlayerImage6: UIImageView!
    @IBOutlet weak var HPlayerImage7: UIImageView!
    @IBOutlet weak var HPlayerImage8: UIImageView!
    @IBOutlet weak var HPlayerImage9: UIImageView!
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
    
    @IBOutlet weak var scoreboard: UIView!
    
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
    @IBOutlet var totalAwayScoreOnboard:UILabel!
    @IBOutlet var totalHomeScoreOnboard:UILabel!
    @IBOutlet var totalAwayHitOnboard: UILabel!
    @IBOutlet var totalHomeHitOnboard: UILabel!
    @IBOutlet var totalAwayErrorOnboard: UILabel!
    @IBOutlet var totalHomeErrorOnboard: UILabel!
    @IBOutlet var awayNameOnboard: UILabel!
    @IBOutlet var homeNameOnboard: UILabel!
    @IBOutlet var A1NameOnboard: UILabel!
    @IBOutlet var A2NameOnboard: UILabel!
    @IBOutlet var A3NameOnboard: UILabel!
    @IBOutlet var A4NameOnboard: UILabel!
    @IBOutlet var A5NameOnboard: UILabel!
    @IBOutlet var A6NameOnboard: UILabel!
    @IBOutlet var A7NameOnboard: UILabel!
    @IBOutlet var A8NameOnboard: UILabel!
    @IBOutlet var A9NameOnboard: UILabel!
    
    @IBOutlet var H1NameOnboard: UILabel!
    @IBOutlet var H2NameOnboard: UILabel!
    @IBOutlet var H3NameOnboard: UILabel!
    @IBOutlet var H4NameOnboard: UILabel!
    @IBOutlet var H5NameOnboard: UILabel!
    @IBOutlet var H6NameOnboard: UILabel!
    @IBOutlet var H7NameOnboard: UILabel!
    @IBOutlet var H8NameOnboard: UILabel!
    @IBOutlet var H9NameOnboard: UILabel!
 
    @IBOutlet var A1PosOnboard: UILabel!
    @IBOutlet var A2PosOnboard: UILabel!
    @IBOutlet var A3PosOnboard: UILabel!
    @IBOutlet var A4PosOnboard: UILabel!
    @IBOutlet var A5PosOnboard: UILabel!
    @IBOutlet var A6PosOnboard: UILabel!
    @IBOutlet var A7PosOnboard: UILabel!
    @IBOutlet var A8PosOnboard: UILabel!
    @IBOutlet var A9PosOnboard: UILabel!
    
    @IBOutlet var H1PosOnboard: UILabel!
    @IBOutlet var H2PosOnboard: UILabel!
    @IBOutlet var H3PosOnboard: UILabel!
    @IBOutlet var H4PosOnboard: UILabel!
    @IBOutlet var H5PosOnboard: UILabel!
    @IBOutlet var H6PosOnboard: UILabel!
    @IBOutlet var H7PosOnboard: UILabel!
    @IBOutlet var H8PosOnboard: UILabel!
    @IBOutlet var H9PosOnboard: UILabel!
    @IBOutlet var panPitching: UIPanGestureRecognizer!
    @IBOutlet var tapCalling: UITapGestureRecognizer!
    @IBOutlet var panHitting: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA1: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA2: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA3: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA4: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA5: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA6: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA7: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA8: UIPanGestureRecognizer!
    @IBOutlet var panRunnerA9: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH1: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH2: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH3: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH4: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH5: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH6: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH7: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH8: UIPanGestureRecognizer!
    @IBOutlet var panRunnerH9: UIPanGestureRecognizer!
    
    @IBOutlet var tapDisplayNameA1: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA2: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA3: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA4: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA5: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA6: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA7: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA8: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameA9: UITapGestureRecognizer!
    
    @IBOutlet var tapDisplayNameH1: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH2: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH3: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH4: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH5: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH6: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH7: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH8: UITapGestureRecognizer!
    @IBOutlet var tapDisplayNameH9: UITapGestureRecognizer!
    
    @IBOutlet var tapErrorModeA1: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA2: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA3: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA4: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA5: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA6: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA7: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA8: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeA9: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH1: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH2: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH3: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH4: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH5: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH6: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH7: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH8: UITapGestureRecognizer!
    @IBOutlet var tapErrorModeH9: UITapGestureRecognizer!
    
    @IBOutlet var panBattingResultHome1: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome2: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome3: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome4: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome5: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome6: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome7: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome8: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultHome9: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway1: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway2: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway3: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway4: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway5: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway6: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway7: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway8: UIPanGestureRecognizer!
    @IBOutlet var panBattingResultAway9: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA1: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA2: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA3: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA4: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA5: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA6: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA7: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA8: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefA9: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH1: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH2: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH3: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH4: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH5: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH6: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH7: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH8: UIPanGestureRecognizer!
    @IBOutlet var panExchangeDefH9: UIPanGestureRecognizer!
    @IBOutlet var awayNameOrder: UILabel!
    @IBOutlet var homeNameOrder: UILabel!
    @IBOutlet var awayBatterName1:UILabel!
    @IBOutlet var awayBatterName2:UILabel!
    @IBOutlet var awayBatterName3:UILabel!
    @IBOutlet var awayBatterName4:UILabel!
    @IBOutlet var awayBatterName5:UILabel!
    @IBOutlet var awayBatterName6:UILabel!
    @IBOutlet var awayBatterName7:UILabel!
    @IBOutlet var awayBatterName8:UILabel!
    @IBOutlet var awayBatterName9:UILabel!
    @IBOutlet var awayBatterPos1:UILabel!
    @IBOutlet var awayBatterPos2:UILabel!
    @IBOutlet var awayBatterPos3:UILabel!
    @IBOutlet var awayBatterPos4:UILabel!
    @IBOutlet var awayBatterPos5:UILabel!
    @IBOutlet var awayBatterPos6:UILabel!
    @IBOutlet var awayBatterPos7:UILabel!
    @IBOutlet var awayBatterPos8:UILabel!
    @IBOutlet var awayBatterPos9:UILabel!
    @IBOutlet var homeBatterName1:UILabel!
    @IBOutlet var homeBatterName2:UILabel!
    @IBOutlet var homeBatterName3:UILabel!
    @IBOutlet var homeBatterName4:UILabel!
    @IBOutlet var homeBatterName5:UILabel!
    @IBOutlet var homeBatterName6:UILabel!
    @IBOutlet var homeBatterName7:UILabel!
    @IBOutlet var homeBatterName8:UILabel!
    @IBOutlet var homeBatterName9:UILabel!
    @IBOutlet var homeBatterPos1:UILabel!
    @IBOutlet var homeBatterPos2:UILabel!
    @IBOutlet var homeBatterPos3:UILabel!
    @IBOutlet var homeBatterPos4:UILabel!
    @IBOutlet var homeBatterPos5:UILabel!
    @IBOutlet var homeBatterPos6:UILabel!
    @IBOutlet var homeBatterPos7:UILabel!
    @IBOutlet var homeBatterPos8:UILabel!
    @IBOutlet var homeBatterPos9:UILabel!
    //scoreboard
    

    @IBOutlet var outCount: UILabel!//出局數
    @IBOutlet var innings: UILabel!//局數
    @IBOutlet var awayScore: UILabel!//客場分數
    @IBOutlet var homeScore: UILabel!//主場分數
    @IBOutlet var awayHit: UILabel!//客場安打
    @IBOutlet var homeHit: UILabel!//主場安打
    @IBOutlet var awayError: UILabel!//客場失誤
    @IBOutlet var homeError: UILabel!//主場失誤
    @IBOutlet var strikeCount: UILabel!//這打席的好球數
    @IBOutlet var ballCount: UILabel!//這打席的壞球數
    @IBOutlet var result: UILabel!//打席的打擊結果
    @IBOutlet var position: UILabel!//打擊出去的位置方向
    @IBOutlet var runnerOnBase: UILabel!//壘上跑者狀況
    @IBOutlet var playerBattingOrder: UILabel! //上場打者棒次
    @IBOutlet var playerHit: UILabel! //上場打者打擊紀錄
    @IBOutlet var playerName: UILabel! //上場打者名字
    @IBOutlet var playerBattingRecord: UILabel!
    @IBOutlet var playerBA: UILabel! //上場打者打擊率
    @IBOutlet var playerPosition: UILabel! //上場打者守備位置
    @IBOutlet var pitchName: UILabel! //投手名字
    @IBOutlet var pitchIP: UILabel! //投球局數
    @IBOutlet var pitchERA: UILabel! //投手防禦率
    @IBOutlet var pitchH: UILabel! //投手被安打數
    @IBOutlet weak var pitchBB: UILabel!
    @IBOutlet weak var pitchSO: UILabel!
    @IBOutlet weak var pitchCount: UILabel!
    @IBAction func checkScoreboard(_ sender: Any) {
        for i in 0 ... 1{
            for j in 0 ... 8{
                nameOnboard[i][j].text = Player.arrayOfPlayer[i][j].name
                posOnboard[i][j].text = Player.arrayOfPlayer[i][j].position
            }
        }
        if scoreboard.alpha != 0{
            scoreboard.alpha = 0
        }//end if
        else{
            scoreboard.alpha = 0.8
        }//end else
    }//end checkScoreboard
    var scores = [[UILabel]]()
    var nameOnboard = [[UILabel]]()
    var posOnboard = [[UILabel]]()
    var batters = [[UIImageView]]()
    var panBattingGesture = [[UIPanGestureRecognizer]]()
    var tapErrorGesture = [[UITapGestureRecognizer]]()
    var panRunnerGesture = [[UIPanGestureRecognizer]]()
    var panExchangeGesture = [[UIPanGestureRecognizer]]()
    //
    //   var inningScore = [[UILabel]]()
    
    
    
    
    //base & item position
    let base1Loc = CGPoint(x:327,y:179)
    let base2Loc = CGPoint(x:232,y:103)
    let base3Loc = CGPoint(x:137,y:179)
    let inBoxLoc = CGPoint(x:201,y:260)
    let homeBaseLoc = CGPoint(x:232,y:257)
    
    let hitBallLoc = CGPoint(x:286,y:231)
    let pitchBallLoc = CGPoint(x:232,y:185)
 
    //defender position
    
    let pitcherLoc = CGPoint(x:232,y:143)
    let catcherLoc = CGPoint(x:232,y:299)
    let firstBaseLoc = CGPoint(x:342,y:141)
    let secondBaseLoc = CGPoint(x:284,y:91)
    let thirdBaseLoc = CGPoint(x:125,y:141)
    let shortStopLoc = CGPoint(x:185,y:91)
    let leftFielderLoc = CGPoint(x:98,y:83)
    let rightFielderLoc = CGPoint(x:367,y:83)
    let centerFielderLoc = CGPoint(x:232,y:36)
    
    let homeBenchLoc = CGPoint(x:360,y:250)
    let awayBenchLoc = CGPoint(x:100,y:250)

    var player11 :Player!
    var player12 :Player!
    var player13 :Player!
    var player14 :Player!
    var player15 :Player!
    var player16 :Player!
    var player17 :Player!
    var player18 :Player!
    var player19 :Player!
    var player31 :Player!
    var player32 :Player!
    var player33 :Player!
    var player34 :Player!
    var player35 :Player!
    var player36 :Player!
    var player37 :Player!
    var player38 :Player!
    var player39 :Player!
    
    
    //---------------IBoutlet&varible number ended-------------------------
    override func viewDidAppear(_ animated: Bool) {
        homeTeamInput = "PHI"
        awayTeamInput = "NYY"
        super.viewDidAppear(animated)
        ref = FIRDatabase.database().reference()
        //let playerRef = ref?.child("player")
        let awayTeamRef = ref?.child("teams").child(awayTeamInput!)
        let homeTeamRef = ref?.child("teams").child(homeTeamInput!)
        let awayBattingOrderRef = awayTeamRef?.child("order")
        let homeBattingOrderRef = homeTeamRef?.child("order")
        gameKey = ref?.child("Game").childByAutoId().key
        self.ref?.child("newPosts").child(gameKey!).child("Date").setValue(dateInput)
        self.ref?.child("newPosts").child(gameKey!).child("Time").setValue(timeInput)
        self.ref?.child("newPosts").child(gameKey!).child("Avenue").setValue(avenueInput)
        awayTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("newPosts").child(gameKey!).child("Away").setValue(snap.value)
            self.AwayTeam.text = (snap.value as AnyObject).description
            self.awayNameOrder.text = (snap.value as AnyObject).description
            self.awayNameOnboard.text = (snap.value as AnyObject).description
        })
        homeTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("newPosts").child(gameKey!).child("Home").setValue(snap.value)
            self.HomeTeam.text = (snap.value as AnyObject).description
            self.homeNameOrder.text = (snap.value as AnyObject).description
            self.homeNameOnboard.text = (snap.value as AnyObject).description
        })
        
        
        tapErrorGesture = [[tapErrorModeA1,tapErrorModeA2,tapErrorModeA3,tapErrorModeA4,tapErrorModeA5,tapErrorModeA6,tapErrorModeA7,tapErrorModeA8,tapErrorModeA9],[tapErrorModeH1,tapErrorModeH2,tapErrorModeH3,tapErrorModeH4,tapErrorModeH5,tapErrorModeH6,tapErrorModeH7,tapErrorModeH8,tapErrorModeH9]]
        
        panBattingGesture = [[panBattingResultAway1,panBattingResultAway2,panBattingResultAway3,panBattingResultAway4,panBattingResultAway5,panBattingResultAway6,panBattingResultAway7,panBattingResultAway8,panBattingResultAway9],[panBattingResultHome1,panBattingResultHome2,panBattingResultHome3,panBattingResultHome4,panBattingResultHome5,panBattingResultHome6,panBattingResultHome7,panBattingResultHome8,panBattingResultHome9]]
        
        panRunnerGesture = [[panRunnerA1,panRunnerA2,panRunnerA3,panRunnerA4,panRunnerA5,panRunnerA6,panRunnerA7,panRunnerA8,panRunnerA9],[panRunnerH1,panRunnerH2,panRunnerH3,panRunnerH4,panRunnerH5,panRunnerH6,panRunnerH7,panRunnerH8,panRunnerH9]]
        
        panExchangeGesture = [[panExchangeDefA1,panExchangeDefA2,panExchangeDefA3,panExchangeDefA4,panExchangeDefA5,panExchangeDefA6,panExchangeDefA7,panExchangeDefA8,panExchangeDefA9],[panExchangeDefH1,panExchangeDefH2,panExchangeDefH3,panExchangeDefH4,panExchangeDefH5,panExchangeDefH6,panExchangeDefH7,panExchangeDefH8,panExchangeDefH9]]
        
        batters = [[APlayerImage1,APlayerImage2,APlayerImage3,APlayerImage4,APlayerImage5,APlayerImage6,APlayerImage7,APlayerImage8,APlayerImage9] , [HPlayerImage1,HPlayerImage2,HPlayerImage3,HPlayerImage4,HPlayerImage5,HPlayerImage6,HPlayerImage7,HPlayerImage8,HPlayerImage9]]
        nameOnboard = [[A1NameOnboard,A2NameOnboard,A3NameOnboard,A4NameOnboard,A5NameOnboard,A6NameOnboard,A7NameOnboard,A8NameOnboard,A9NameOnboard],[H1NameOnboard,H2NameOnboard,H3NameOnboard,H4NameOnboard,H5NameOnboard,H6NameOnboard,H7NameOnboard,H8NameOnboard,H9NameOnboard]]
        posOnboard = [[A1PosOnboard,A2PosOnboard,A3PosOnboard,A4PosOnboard,A5PosOnboard,A6PosOnboard,A7PosOnboard,A8PosOnboard,A9PosOnboard],[H1PosOnboard,H2PosOnboard,H3PosOnboard,H4PosOnboard,H5PosOnboard,H6PosOnboard,H7PosOnboard,H8PosOnboard,H9PosOnboard]]
        
        for i in 0 ... 1 {
            for j in 0 ... 8{
                batters[i][j].tag = i*100 + j + 50
                batters[i][j].isUserInteractionEnabled = true
                panRunnerGesture[i][j].isEnabled = false
            }
        }
        
        awayPlayer1.text? = "①"
        awayBattingOrderRef?.child("1/Name").observe(FIRDataEventType.value, with: {(name)in
            awayBattingOrderRef?.child("1/Position").observe(FIRDataEventType.value,with:{(position)in
                
                self.player11 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 1, awayOrHome: 0)
                self.awayBatterName1.text = name.value as? String
                self.awayBatterPos1.text = position.value as? String
                
            })
        })
        
        awayPlayer2.text? = "②"
        awayBattingOrderRef?.child("2/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("2/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player12 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 2, awayOrHome: 0)
                self.awayBatterName2.text = name.value as? String
                self.awayBatterPos2.text = position.value as? String
            })
        })
        
        awayPlayer3.text? = "③"
        awayBattingOrderRef?.child("3/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("3/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player13 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 3, awayOrHome: 0)
                self.awayBatterName3.text = name.value as? String
                self.awayBatterPos3.text = position.value as? String
            })
        })
        
        awayPlayer4.text? = "④"
        awayBattingOrderRef?.child("4/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("4/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player14 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 4, awayOrHome: 0)
                self.awayBatterName4.text = name.value as? String
                self.awayBatterPos4.text = position.value as? String
                
            })
        })
        
        awayPlayer5.text? = "⑤"
        awayBattingOrderRef?.child("5/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("5/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player15 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 5, awayOrHome: 0)
                self.awayBatterName5.text = name.value as? String
                self.awayBatterPos5.text = position.value as? String
            })
        })
        awayPlayer6.text? = "⑥"
        awayBattingOrderRef?.child("6/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("6/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player16 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 6, awayOrHome: 0)
                self.awayBatterName6.text = name.value as? String
                self.awayBatterPos6.text = position.value as? String
            })
        })
        
        awayPlayer7.text? = "⑦"
        awayBattingOrderRef?.child("7/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("7/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player17 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 7, awayOrHome: 0)
                self.awayBatterName7.text = name.value as? String
                self.awayBatterPos7.text = position.value as? String
            })
        })
        
        awayPlayer8.text? = "⑧"
        awayBattingOrderRef?.child("8/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("8/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player18 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 8, awayOrHome: 0)
                self.awayBatterName8.text = name.value as? String
                self.awayBatterPos8.text = position.value as? String
            })
        })
        awayPlayer9.text? = "⑨"
        awayBattingOrderRef?.child("9/Name").observeSingleEvent(of: .value, with: {(name)in
            awayBattingOrderRef?.child("9/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player19 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 9, awayOrHome: 0)
                self.awayBatterName9.text = name.value as? String
                self.awayBatterPos9.text = position.value as? String
            })
        })
        
        
        homePlayer1.text? = "❶"
        homeBattingOrderRef?.child("1/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("1/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player31 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 1, awayOrHome: 1)
                self.homeBatterName1.text = name.value as? String
                self.homeBatterPos1.text = position.value as? String
            })
        })
        
        homePlayer2.text? = "❷"
        homeBattingOrderRef?.child("2/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("2/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player32 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 2, awayOrHome: 1)
                self.homeBatterName2.text = name.value as? String
                self.homeBatterPos2.text = position.value as? String
            })
        })
        
        homePlayer3.text? = "❸"
        homeBattingOrderRef?.child("3/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("3/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player33 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 3, awayOrHome: 1)
                self.homeBatterName3.text = name.value as? String
                self.homeBatterPos3.text = position.value as? String
            })
        })
        
        homePlayer4.text? = "❹"
        homeBattingOrderRef?.child("4/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("4/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player34 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 4, awayOrHome: 1)
                self.homeBatterName4.text = name.value as? String
                self.homeBatterPos4.text = position.value as? String
            })
        })
        
        homePlayer5.text? = "❺"
        homeBattingOrderRef?.child("5/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("5/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player35 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 5, awayOrHome: 1)
                self.homeBatterName5.text = name.value as? String
                self.homeBatterPos5.text = position.value as? String
            })
        })
        
        homePlayer6.text? = "❻"
        homeBattingOrderRef?.child("6/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("6/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player36 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 6, awayOrHome: 1)
                self.homeBatterName6.text = name.value as? String
                self.homeBatterPos6.text = position.value as? String
            })
        })
        
        homePlayer7.text? = "❼"
        homeBattingOrderRef?.child("7/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("7/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player37 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 7, awayOrHome: 1)
                self.homeBatterName7.text = name.value as? String
                self.homeBatterPos7.text = position.value as? String
            })
        })
        
        homePlayer8.text? = "❽"
        homeBattingOrderRef?.child("8/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("8/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player38 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 8, awayOrHome: 1)
                self.homeBatterName8.text = name.value as? String
                self.homeBatterPos8.text = position.value as? String
            })
        })
        
        homePlayer9.text? = "❾"
        homeBattingOrderRef?.child("9/Name").observeSingleEvent(of: .value, with: {(name)in
            homeBattingOrderRef?.child("9/Position").observeSingleEvent(of: .value,with:{(position)in
                self.player39 = Player(as:name.value as! String , position:position.value as! String , battingOrder: 9, awayOrHome: 1)
                self.homeBatterName9.text = name.value as? String
                self.homeBatterPos9.text = position.value as? String
            })
        })
        scores = [[top1,top2,top3,top4,top5,top6,top7,top8,top9],[bottom1,bottom2,bottom3,bottom4,bottom5,bottom6,bottom7,bottom8,bottom9]]
        
        let scoreboardRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("scoreboard")
        
        
        for i in 1...9 {
            scoreboardRef.child("\(i)").child("Top").setValue("-")
            scoreboardRef.child("\(i)").child("Bot").setValue("-")
        }
        scoreboardRef.child("1").child("Top").setValue(0)
        self.scores[0][0].textColor = UIColor.yellow
        
        scoreboardRef.child("awayTotalHits").setValue(0)
        scoreboardRef.child("homeTotalHits").setValue(0)
        scoreboardRef.child("awayTotalScore").setValue(0)
        scoreboardRef.child("homeTotalScore").setValue(0)
        scoreboardRef.child("awayTotalError").setValue(0)
        scoreboardRef.child("homeTotalError").setValue(0)
        
        for i in 0 ... 8{
            scoreboardRef.child("\(i+1)").child("Top").observe(FIRDataEventType.value,with:{(score)in
                self.scores[0][i].text = String(describing: score.value as AnyObject)
            })
            scoreboardRef.child("\(i+1)").child("Bot").observe(FIRDataEventType.value,with:{(score)in
                self.scores[1][i].text = String(describing: score.value as AnyObject)
            })
        }
        scoreboardRef.child("awayTotalHits").observe(FIRDataEventType.value,with:{(score)in
            self.totalAwayHitOnboard.text = String(score.value as! Int)
        })
        scoreboardRef.child("homeTotalHits").observe(FIRDataEventType.value,with:{(score)in
            self.totalHomeHitOnboard.text = String(score.value as! Int)
        })
        scoreboardRef.child("awayTotalScore").observe(FIRDataEventType.value,with:{(score)in
            self.totalAwayScoreOnboard.text = String(score.value as! Int)
        })
        scoreboardRef.child("homeTotalScore").observe(FIRDataEventType.value,with:{(score)in
            self.totalHomeScoreOnboard.text = String(score.value as! Int)
        })
        scoreboardRef.child("awayTotalError").observe(FIRDataEventType.value,with:{(score)in
            self.totalAwayErrorOnboard.text = String(score.value as! Int)
        })
        scoreboardRef.child("homeTotalError").observe(FIRDataEventType.value,with:{(score)in
            self.totalHomeErrorOnboard.text = String(score.value as! Int)
        })
        baseballField.isUserInteractionEnabled = true
        baseball.isUserInteractionEnabled = true
        pitchingBall.isUserInteractionEnabled = true
    }
    
    
    //-----setDefence------
    //func-setDefence: 讓進攻方球員回到休息區並透明化，讓守備方球員到各自的守備位置並顯示
    func setDefence(setPlayers : [[UIImageView]] , whichTeamBatting : Int , awayP : Int , homeP : Int){
        playerName.text = ""
        playerPosition.text = ""
        playerBA.text = ""
        playerHit.text = ""
        playerBattingRecord.text = ""
        playerBattingOrder.text = ""
        UIView.animate(withDuration: 1.0, delay: 0 , animations: {
            self.baseball.center = self.hitBallLoc
        })
        UIView.animate(withDuration: 0.5 , delay: 0.5 , animations: {
            if whichTeamBatting == 1 {
                //主隊進攻
                fieldingTeam = 0
                for i in 0 ... 8 {
                    self.panBattingGesture[0][i].isEnabled = false
                    self.panBattingGesture[1][i].isEnabled = false
                    self.tapErrorGesture[0][i].isEnabled = true
                    self.tapErrorGesture[1][i].isEnabled = false
                    self.panRunnerGesture[0][i].isEnabled = false
                    self.panRunnerGesture[1][i].isEnabled = false
                    self.panExchangeGesture[0][i].isEnabled = true
                    self.panExchangeGesture[1][i].isEnabled = false
                    setPlayers[1][i].alpha = 0.0
                    setPlayers[0][i].alpha = 0.0
                    setPlayers[1][i].center = self.homeBenchLoc
                    setPlayers[0][i].center = self.awayBenchLoc
                }//end for
                //投手資訊
            }//end if
            else{
                //客隊進攻
                fieldingTeam = 1
                for i in 0 ... 8 {
                    self.panBattingGesture[1][i].isEnabled = false
                    self.panBattingGesture[0][i].isEnabled = false
                    self.tapErrorGesture[1][i].isEnabled = true
                    self.tapErrorGesture[0][i].isEnabled = false
                    self.panRunnerGesture[0][i].isEnabled = false
                    self.panRunnerGesture[1][i].isEnabled = false
                    self.panExchangeGesture[0][i].isEnabled = false
                    self.panExchangeGesture[1][i].isEnabled = true
                    setPlayers[0][i].alpha = 0.0
                    setPlayers[1][i].alpha = 0.0
                    setPlayers[0][i].center = self.awayBenchLoc
                    setPlayers[1][i].center = self.homeBenchLoc
                }//end for
                //投手資訊
            }//end for
            self.getPitcherInfo()
        })//end animation
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
        UIView.animate(withDuration: 0.5, animations: {
            for i in 0 ... 8{
                setPlayers[fieldingTeam][i].image = UIImage(named: "catcher.png")
                setPlayers[fieldingTeam][i].alpha = 1.0
                setPlayers[fieldingTeam][i].center = Player.arrayOfPlayer[fieldingTeam][i].location
            }
        })
        })
        
    }
    //-----setDefence ended------
    
    //func-hitcheck(0 = 客隊打擊 1 = 主隊打擊):讓攻擊方的安打數+1
    func hitCheck(whichTeam: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("scoreboard")
        if whichTeam == 0 {
            awayHits = awayHits + 1
            awayHit.text = String (awayHits)
            scoreboardRef.child("awayTotalHits").setValue(awayHits)
        }
        else{
            homeHits = homeHits + 1
            homeHit.text = String (homeHits)
            scoreboardRef.child("homeTotalHits").setValue(homeHits)
        }
    }
    //func-errorcheck(0 = 主隊守備 1 = 客隊守備):讓守備方的失誤數+1
    func errorCheck(whichTeam: Int){
        let scoreboardRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("scoreboard")
        if whichTeam == 0 {
            awayErrorCount = awayErrorCount + 1
            awayError.text = String (awayErrorCount)
            scoreboardRef.child("awayTotalError").setValue(awayErrorCount)
        }
        else{
            homeErrorCount = homeErrorCount + 1
            homeError.text = String (homeErrorCount)
            scoreboardRef.child("homeTotalError").setValue(homeErrorCount)
        }
    }
    //func-inningCheck(0 = 上換下 1 = 下換上):上半局換成下半局，或下半局換到下局的上半局，並setDefence
    func inningCheck(whichTeamBattingEnded: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("scoreboard")
        if scoringOfTheInning == 0 {
            scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(scoringOfTheInning)
        }
        eachBatterCount = 0
        scoringOfTheInning = 0
        if whichTeamBattingEnded == 0 {
            scores[0][inning-1].textColor = UIColor.white
            scores[1][inning-1].textColor = UIColor.yellow
            innings.text = String (inning) + "▼"
            topOrBot = "Bot"
            scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(0)
            awayOrHome = 1
        }
        else{
            if inning == 9{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "firstPage")
                self.present(vc!,animated: true,completion:nil)
            }
            else{
                scores[1][inning-1].textColor = UIColor.white
                inning = inning + 1
                scores[0][inning-1].textColor = UIColor.yellow
                innings.text = String (inning) + "▲"
                topOrBot = "Top"
                scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(0)
                awayOrHome = 0
            }
        }
        setDefence(setPlayers: batters, whichTeamBatting: awayOrHome, awayP: awayPitcher, homeP: homePitcher)
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
            setRecordPByP(input: "好球")
        }
        else if count == 2{
            strikeCount.text = "● ●"
            setRecordPByP(input: "好球")
        }
        else{
            result.text = "三振"
            setRecordPByP(input: "三振")
            setRecordResult(input: "三振")
            HitChangingRecord(bases: -1, error: 0)
            saveResult(input: "SO")
            //        投手紀錄
            getPitcherInfo()
            self.outChecking(Count: out)
            
            countReset()
        }
        eachPitchCount += 1
    }
    //func-callBall(本來的壞球數):投出壞球
    func callBall(count: Int){
        self.runnerOnBase.text = ""
        result.text = "壞球" + String (count)
        if count == 1{
            ballCount.text = "● ○ ○"
            setRecordPByP(input: "壞球")
        }
        else if count == 2{
            ballCount.text = "● ● ○"
            setRecordPByP(input: "壞球")
        }
        else if count == 3{
            ballCount.text = "● ● ●"
            setRecordPByP(input: "壞球")
        }
        else{
            result.text = "四壞球保送"
            setRecordPByP(input: "四壞球保送")
            setRecordResult(input: "四壞球保送")
            panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "BB")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBB()
            playerBattingRecord.text = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getbattingRecord()
            saveResult(input: "BB")
            //        投手紀錄
            getPitcherInfo()
            self.runner(batter: batterOn[awayOrHome], bases: 1)
            countReset()
        }
        eachPitchCount += 1
    }
    //func-scoring(0 = 客場得分 1 = 主場得分):增加得分方一分，並增加投手的自責分(率)
    func scoring(whichTeam: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("scoreboard")
        scoringOfTheInning = scoringOfTheInning + 1
        if whichTeam == 0 {
            awayScoring = awayScoring + 1
            awayScore.text = String (awayScoring)
            scoreboardRef.child("awayTotalScore").setValue(awayScoring)
        }
        else{
            homeScoring = homeScoring + 1
            homeScore.text = String (homeScoring)
            scoreboardRef.child("homeTotalScore").setValue(homeScoring)
        }
        saveResult(input: "R")
        //        投手紀錄
        getPitcherInfo()
        scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(scoringOfTheInning)
        
        
    }
    
    
    //func-runner(打擊的打者,壘打數):計算打者及跑者的壘包推進最小值(強迫進壘)
    func runner(batter: Int, bases: Int){
        panHitting.isEnabled = false
        panPitching.isEnabled = false
        var toFirstBase = false //有跑者進一壘的意圖
        var toSecondBase = false//有跑者進二壘的意圖
        var toThirdBase = false//有跑者進三壘的意圖
        //       if bases != 4{
        //         self.panRunnerGesture[awayOrHome][batter].isEnabled = true
        //   }
        self.batters[awayOrHome][batterOn[awayOrHome]].center = inBoxLoc
        if bases <= 0 {
            UIView.animate(withDuration: 1.0,animations: {
                self.batters[awayOrHome][batterOn[awayOrHome]].alpha = 0.0
                if awayOrHome == 0 {
                    self.batters[awayOrHome][batterOn[awayOrHome]].center = self.awayBenchLoc
                }
                else{
                    self.batters[awayOrHome][batterOn[awayOrHome]].center = self.homeBenchLoc
                }
            })
        }
        else{
            for j in 1 ... bases { //根據壘打數決定進行幾輪
                panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
                if j >= 1 { toFirstBase = true }
                if j >= 2 { toSecondBase = true }
                if j >= 3 { toThirdBase = true }
                for i in 0 ... 8 { //如果有人在打擊區，則進一壘意圖為T
                    if self.batters[awayOrHome][i].center == self.inBoxLoc{
                        toFirstBase = true
                    }
                }
                for i in 0 ... 8 { //如果有人在一壘，且進一壘意圖為T，則進二壘意圖為T
                    if self.batters[awayOrHome][i].center == base1Loc && toFirstBase == true{
                        toSecondBase = true
                    }
                }
                for i in 0 ... 8 { //如果有人在二壘，且進二壘意圖為T，則進三壘意圖為T
                    if self.batters[awayOrHome][i].center == base2Loc && toSecondBase == true{
                        toThirdBase = true
                    }
                }
                
                for i in 0 ... 8 {
                    //如果有人在打擊區，則上一壘
                    if self.batters[awayOrHome][i].center == inBoxLoc{
                        UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                            self.batters[awayOrHome][i].center = self.base1Loc
                        })
                    }
                        //如果一壘有人，且進一壘意圖為T，則一壘跑者上二壘
                    else if self.batters[awayOrHome][i].center == base1Loc && toFirstBase == true{
                        UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                            self.batters[awayOrHome][i].center = self.base2Loc
                        })
                    }
                        //如果二壘有人，且進二壘意圖為T，則二壘跑者上三壘
                    else if self.batters[awayOrHome][i].center == base2Loc && toSecondBase == true{
                        UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                            self.batters[awayOrHome][i].center = self.base3Loc
                        })
                    }
                        //如果三壘有人，且進三壘的意圖為T，則三壘跑者回本壘得分
                    else if self.batters[awayOrHome][i].center == base3Loc && toThirdBase == true{
                        UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                            self.batters[awayOrHome][i].center = self.homeBaseLoc
                        })
                        
                        UIView.animate(withDuration: 1.0,delay: TimeInterval(j) ,animations: {
                            self.batters[awayOrHome][i].alpha = 0.0
                            if awayOrHome == 0{
                                self.batters[awayOrHome][i].center = self.awayBenchLoc
                                
                            }
                            if awayOrHome == 1{
                                self.batters[awayOrHome][i].center = self.homeBenchLoc
                            }
                        })
                        scoring(whichTeam: awayOrHome)
                    }
                }
            }
        }
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
            setRecordBaseStatus(input: runnerOnBase.text!)
            out = 0
            inningCheck(whichTeamBattingEnded: awayOrHome)
        }
        
    }
    
    //點擊背景觸發func-call:讓下一位打者上打擊區
    @IBAction func call(_ sender: UITapGestureRecognizer) {
        eachPitchCount = 1
        callingCount += 1
        if callingCount == 1{
            let gameBoxRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("Box")
            let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList")
            Player.arrayOfPlayer[0].sort{$1.battingOrder > $0.battingOrder}
            Player.arrayOfPlayer[1].sort{$1.battingOrder > $0.battingOrder}
            for i in 0 ... 1{
                for j in 0 ... 8{
                    
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("AB").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("AB").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("H").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("H").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("double").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("double").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("triple").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("triple").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("HR").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("HR").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("BB").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("BB").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("SO").setValue(0)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("SO").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("DATE").setValue(dateInput)
                    gameBoxRef.child(String(i)).child(String(j+1)).child("Name").setValue(Player.arrayOfPlayer[i][j].getName())
                    if i == 0 {
                        playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("OPP").setValue(homeTeamInput)
                    }
                    else if i == 1{
                        playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("OPP").setValue(awayTeamInput)
                    }
                    
                }
            }
            for i in 0...8{
                if Player.arrayOfPlayer[1][i].position == "P"{
                    homePitcher = i
                    
                }
                if Player.arrayOfPlayer[0][i].position == "P"{
                    awayPitcher = i
                }
            }
            gameBoxRef.child("0/0/\(awayRPCount)").child("SO").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("IP").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("BB").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("H").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("ER").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("Count").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("ERA").setValue(0)
            gameBoxRef.child("0/0/\(awayRPCount)").child("Name").setValue(Player.arrayOfPlayer[0][awayPitcher].getName())
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/SO").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/IP").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/BB").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/H").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/ER").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/Count").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/ERA").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("SO").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("IP").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("BB").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("H").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("ER").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("Count").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("ERA").setValue(0)
            gameBoxRef.child("1/0/\(homeRPCount)").child("Name").setValue(Player.arrayOfPlayer[1][homePitcher].getName())
            playerLogRef.child(Player.arrayOfPlayer[0][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/SO").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/IP").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/BB").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/H").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/ER").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/Count").setValue(0)
            playerLogRef.child(Player.arrayOfPlayer[1][homePitcher].getName()).child("gamelog").child(gameKey!).child("Pitch/ERA").setValue(0)
            
            setDefence(setPlayers: batters, whichTeamBatting: awayOrHome, awayP: awayPitcher, homeP: homePitcher)
        }
        else{
            var anybodyOnplate = 0
            for i in 0 ... 1 {
                for j in 0 ... 8{
                    if batters[i][j].center == inBoxLoc{
                        anybodyOnplate += 1
                    }
                }
            }
            if anybodyOnplate != 0{
            }
            else{
                for i in 0 ... 1{
                    for j in 0 ... 8{
                        panBattingGesture[i][j].isEnabled = false
                    }
                }
                panPitching.isEnabled = true
                panHitting.isEnabled = true
                countReset()
                self.result.text = ""
                self.position.text = ""
                self.runnerOnBase.text = ""
                getRunnerOnBase()//文字更新目前壘上狀況
                setRecordBaseStatus(input: runnerOnBase.text!)
                UIView.animate(withDuration: 1.0, delay: 0 , animations: {
                    
                    self.baseball.center = self.hitBallLoc
                })
                UIView.animate(withDuration: 1.0,animations: {
                    batterOn[awayOrHome] = batterOn[awayOrHome] + 1
                    if batterOn[awayOrHome] == 9{
                        batterOn[awayOrHome] = 0
                    }
                    self.batters[awayOrHome][batterOn[awayOrHome]].image = UIImage(named: "helmet.png")
                    self.batters[awayOrHome][batterOn[awayOrHome]].alpha = 1.0
                    self.batters[awayOrHome][batterOn[awayOrHome]].center = self.inBoxLoc
                    eachBatterCount += 1
                    self.panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
                })
                //打者資訊
                let gameLogRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)")
                gameLogRef.child("Name").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName())
                playerName.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()
                playerPosition.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getPosition()
                playerBA.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getBA()
                playerHit.text? = "\(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())-\(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())"
                playerBattingRecord.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getbattingRecord()
                playerBattingOrder.text? = "\(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getBattingOrder())"
                
                let careerRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("career")
                careerRef.child("HR").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerHR = snapshot.value as! Int
                })
                careerRef.child("AB").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerAB = snapshot.value as! Int
                })
                careerRef.child("SO").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerSO = snapshot.value as! Int
                })
                careerRef.child("BB").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerBB = snapshot.value as! Int
                })
                careerRef.child("H").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerH = snapshot.value as! Int
                })
                careerRef.child("double").observeSingleEvent(of: .value, with: {(snapshot)in
                    career2B = snapshot.value as! Int
                })
                careerRef.child("triple").observeSingleEvent(of: .value, with: {(snapshot)in
                    career3B = snapshot.value as! Int
                })
                
                var careerPitcherRef:FIRDatabaseReference
                if awayOrHome == 1{
                    careerPitcherRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[0][awayPitcher].getName()).child("career/pitch")
                }
                else{
                    careerPitcherRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[1][homePitcher].getName()).child("career/pitch")
                }
                careerPitcherRef.child("IP").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerIP = snapshot.value as! Double
                })
                careerPitcherRef.child("SO").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerPitchSO = snapshot.value as! Int
                })
                careerPitcherRef.child("BB").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerPitchBB = snapshot.value as! Int
                })
                careerPitcherRef.child("H").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerPitchH = snapshot.value as! Int
                })
                careerPitcherRef.child("ER").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerPitchER = snapshot.value as! Int
                })
                careerPitcherRef.child("ERA").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerERA = snapshot.value as! Double
                })
                careerPitcherRef.child("Count").observeSingleEvent(of: .value, with: {(snapshot)in
                    careerCount = snapshot.value as! Int
                })
                
            }
        }
    }
    //func-getRunnerOnBase:文字提示更新目前壘上狀況
    func getRunnerOnBase(){
        var check1 = false
        var check2 = false
        var check3 = false
        for i in 0...8 {
            if self.batters[awayOrHome][i].center == base1Loc{
                check1 = true
            }
            else if self.batters[awayOrHome][i].center == base2Loc{
                check2 = true
            }
            else if self.batters[awayOrHome][i].center == base3Loc{
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
    @IBAction func hitLocation(sender: UIPanGestureRecognizer) {
        panPitching.isEnabled = false
        panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
        let point = sender.location(in: baseball)
        baseball.center.x = baseball.center.x + point.x
        baseball.center.y = baseball.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            panHitting.isEnabled = false
            if baseball.center.y < 30
                || (baseball.center.x < 30 && baseball.center.y < 70)
                || (baseball.center.x < 50 && baseball.center.y < 50)
                || (baseball.center.x > 435 && baseball.center.y < 70)
                || (baseball.center.x > 415 && baseball.center.y < 70)
            {
                addNP()
                if awayOrHome == 0{
                    pitchCount.text? = String(Player.arrayOfPlayer[1][homePitcher].getPitchCount())
                }
                if awayOrHome == 1{
                    pitchCount.text? = String(Player.arrayOfPlayer[0][awayPitcher].getPitchCount())
                }
                if baseball.center.x < 155 {
                    battingPosition = "左外野方向"
                    self.position.text = battingPosition
                }
                else if baseball.center.x < 311{
                    battingPosition = "中外野方向"
                    self.position.text = battingPosition
                }
                else {
                    battingPosition = "右外野方向"
                    self.position.text = battingPosition
                    
                }
                self.result.text = "全壘打"
                self.runnerOnBase.text = ""
                self.batters[awayOrHome][batterOn[awayOrHome]].center = inBoxLoc
                HitChangingRecord(bases: 4, error: 0)
                saveResult(input: "HR")
                //        投手紀錄
                getPitcherInfo()
                setRecordResult(input: battingPosition + "全壘打")
                setRecordPByP(input: battingPosition + "全壘打")
            }
            else if getPosition(x: baseball.center.x, y: baseball.center.y) == "NULL"{
                panHitting.isEnabled = true
                panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
                baseball.center = hitBallLoc
                }
            else{
                addNP()
                if awayOrHome == 0{
                    pitchCount.text? = String(Player.arrayOfPlayer[1][homePitcher].getPitchCount())
                }
                if awayOrHome == 1{
                    pitchCount.text? = String(Player.arrayOfPlayer[0][awayPitcher].getPitchCount())
                }
                if getPosition(x: baseball.center.x, y: baseball.center.y) == "界外球"{
                    panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
                    panHitting.isEnabled = true
                    panPitching.isEnabled = true
                    if strike < 2 {
                        strike = strike + 1
                    }
                    self.runnerOnBase.text = ""
                    if strike == 1{
                        strikeCount.text = "● ○"
                    }
                    else{
                        strikeCount.text = "● ●"
                    }
                    self.position.text = ""
                    self.result.text = "界外球"
                    //                    gameLogRef.setValue("界外球")
                    setRecordPByP(input: "界外球")
                    eachPitchCount += 1
                    self.runnerOnBase.text = ""
                    baseball.center = hitBallLoc
                }
                else{
                    battingPosition = getPosition(x: baseball.center.x, y: baseball.center.y)
                    self.position.text = battingPosition
                    self.result.text = ""
                    self.runnerOnBase.text = ""
                }
            }
        }
    }
    
    func HitChangingRecord(bases: Int, error: Int){
        if error == 1{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "E")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addOut()
        }
        else if bases == 1 {
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "H")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addHit()
        }
        else if bases == 2{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "2B")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addHit()
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].add2B()
        }
        else if bases == 3{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "3B")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addHit()
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].add3B()
        }
        else if bases == 4{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "HR")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addHit()
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addHR()
        }
        else if bases == 0{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "Out")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addOut()
        }
        else if bases == -1{
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "K")
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addOut()
            Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addSO()
        }
        
        //        打者打擊率
        playerBA.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getBA()
        //        打者打擊紀錄
        playerHit.text? = "\(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())-\(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())"
        playerBattingRecord.text? = Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getbattingRecord()
        if bases > 0 && error == 0{
            self.hitCheck(whichTeam: awayOrHome)
        }
        else if bases <= 0{
            out = out + 1
        }
        self.runner(batter: batterOn[awayOrHome], bases: bases)
    }
    
    //func-battingResult:拖曳打者決定壘打數或出局
    func battingResultInPlay(){
        panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
        panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
        if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == -10{
            self.batters[awayOrHome][batterOn[awayOrHome]].center = inBoxLoc
            panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
            panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
        }
        else{
            self.runnerOnBase.text = ""
            if errorModeState == 0{
                if getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 1{
                    self.result.text = "一壘安打"
                    setRecordPByP(input: battingPosition + "一壘安打")
                    setRecordResult(input: battingPosition + "一壘安打")
                    HitChangingRecord(bases: 1,error: 0)
                    saveResult(input: "H")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 2{
                    self.result.text = "二壘安打"
                    setRecordPByP(input: battingPosition + "二壘安打")
                    setRecordResult(input: battingPosition + "二壘安打")
                    HitChangingRecord(bases: 2, error: 0)
                    saveResult(input: "2B")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 3{
                    self.result.text = "三壘安打"
                    setRecordPByP(input: battingPosition + "三壘安打")
                    setRecordResult(input: battingPosition + "三壘安打")
                    HitChangingRecord(bases: 3, error: 0)
                    saveResult(input: "3B")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 4{
                    self.result.text = "全壘打"
                    setRecordResult(input: battingPosition + "全壘打")
                    setRecordPByP(input: battingPosition + "全壘打")
                    HitChangingRecord(bases: 4, error: 0)
                    saveResult(input: "HR")
                }
                    
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 0{
                    self.result.text = "出局"
                    setRecordResult(input: battingPosition + "出局")
                    setRecordPByP(input: battingPosition + "出局")
                    HitChangingRecord(bases: 0, error: 0)
                    saveResult(input: "OUT")
                    outChecking(Count: out)
                }
            }
            else if errorModeState == 1{
                if getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 1{
                    self.result.text = "失誤上一壘"
                    setRecordPByP(input: battingPosition + "失誤上一壘")
                    setRecordResult(input: battingPosition + "失誤上一壘")
                    HitChangingRecord(bases: 1, error: 1)
                    saveResult(input: "E")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 2{
                    self.result.text = "失誤上二壘"
                    setRecordPByP(input: battingPosition + "失誤上二壘")
                    setRecordResult(input: battingPosition + "失誤上二壘")
                    HitChangingRecord(bases: 2, error: 1)
                    saveResult(input: "E")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 3{
                    self.result.text = "失誤上三壘"
                    setRecordPByP(input: battingPosition + "失誤上三壘")
                    setRecordResult(input: battingPosition + "失誤上三壘")
                    HitChangingRecord(bases: 3, error: 1)
                    saveResult(input: "E")
                }
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 4{
                    self.result.text = "失誤回本壘"
                    setRecordResult(input: battingPosition + "失誤回本壘")
                    setRecordPByP(input: battingPosition + "失誤回本壘")
                    HitChangingRecord(bases: 4, error: 1)
                    saveResult(input: "E")
                }
                    
                else if  getBaseOfHits(x: self.batters[awayOrHome][batterOn[awayOrHome]].center.x, y: self.batters[awayOrHome][batterOn[awayOrHome]].center.y) == 0{
                    self.result.text = "出局"
                    setRecordResult(input: battingPosition + "出局")
                    setRecordPByP(input: battingPosition + "出局")
                    HitChangingRecord(bases: 0, error: 0)
                    saveResult(input: "OUT")
                    outChecking(Count: out)
                }
            }
            //        投手紀錄
            getPitcherInfo()
        }
        
        
    }
    
    @IBAction func gameSetBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "firstPage")
        self.present(vc!,animated: true,completion:nil)
    }
    @IBAction func displayNameFunction(sender: UITapGestureRecognizer) {
        let senderTag = sender.view!.tag
        if view!.viewWithTag(senderTag)?.alpha == 1{
            if senderTag < 100 {
                tapPlayerName.text = Player.arrayOfPlayer[0][senderTag - 50].getName()
                tapPlayerPos.text = Player.arrayOfPlayer[0][senderTag - 50].getPosition()
                tapPlayerBattingOrder.text = "\(Player.arrayOfPlayer[0][senderTag - 50].getBattingOrder())"
            }
            else{
                tapPlayerName.text = Player.arrayOfPlayer[1][senderTag - 150].getName()
                tapPlayerPos.text = Player.arrayOfPlayer[1][senderTag - 150].getPosition()
                tapPlayerBattingOrder.text = "Order: \(Player.arrayOfPlayer[1][senderTag - 150].getBattingOrder())"
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.tapPlayerName.text = ""
            self.tapPlayerPos.text = ""
            self.tapPlayerBattingOrder.text = ""
        })
    }
    func avoidRunnerOnSameBase(input: UIPanGestureRecognizer ,startBase:Int,newBase:Int, senderTag:Int ,startString:String,newString:String){
        var awayPlayerTag = 0
        var homePlayerTag = 0
        var x = CGFloat(0.0)
        var y = CGFloat(0.0)
        var onSameBaseOrNot = false
        var locationX = [0,base1Loc.x,base2Loc.x,base3Loc.x,homeBaseLoc.x]
        var locationY = [0,base1Loc.y,base2Loc.y,base3Loc.y,homeBaseLoc.y]
        self.view?.viewWithTag(senderTag)?.center.x = locationX[startBase]
        self.view?.viewWithTag(senderTag)?.center.y = locationY[startBase]
        var anybodyOnplate = 0
        for i in 0 ... 1 {
            for j in 0 ... 8{
                if self.batters[i][j].center == inBoxLoc{
                    anybodyOnplate += 1
                }
            }
        }
        if newBase == 0{
            if anybodyOnplate != 0{
                setRecordRunnerStatus(input:"\(startString)壘跑者出局", playSituation: "beforePlay")
            }
            else{
                setRecordRunnerStatus(input:"\(startString)壘跑者出局", playSituation: "afterPlay")
            }
            result.text = ("\(startString)壘跑者出局")
            saveResult(input: "runnerOUT")
            getPitcherInfo()
            UIView.animate(withDuration: 1, animations: {
                self.view?.viewWithTag(senderTag)?.alpha = 0.0
                if awayOrHome == 0{
                    self.view?.viewWithTag(senderTag)?.center = self.awayBenchLoc
                }
                if awayOrHome == 1{
                    self.view?.viewWithTag(senderTag)?.center = self.homeBenchLoc
                }
            })
            out = out + 1
            if anybodyOnplate != 0 && out == 3{
                batterOn[awayOrHome] = batterOn[awayOrHome] - 1
            }
            outChecking(Count: out)
        }
        else{
        for i in 0 ... 8{
            awayPlayerTag = 50 + i
            homePlayerTag = 150 + i
            if awayPlayerTag != senderTag{
                x = (self.view?.viewWithTag(awayPlayerTag)?.center.x)!
                y = (self.view?.viewWithTag(awayPlayerTag)?.center.y)!
                for j in startBase ... newBase{
                    if x == locationX[j] && y == locationY[j]{
//                        print("不可超越或重疊前位跑者")
                        onSameBaseOrNot = true
                    }
                }
            }
            if homePlayerTag != senderTag{
                x = (self.view?.viewWithTag(homePlayerTag)?.center.x)!
                y = (self.view?.viewWithTag(homePlayerTag)?.center.y)!
                for j in startBase ... newBase{
                    if x == locationX[j] && y == locationY[j]{
//                        print("不可超越或重疊前位跑者")
                        onSameBaseOrNot = true
                    }
                }
            }
        }
        if onSameBaseOrNot == false{
            UIView.animate(withDuration: TimeInterval(newBase - startBase),animations: {
                self.view?.viewWithTag(senderTag)?.center.x = locationX[newBase]
                self.view?.viewWithTag(senderTag)?.center.y = locationY[newBase]
            })
            if newBase == 4{
                scoring(whichTeam: awayOrHome)
                UIView.animate(withDuration: 1,delay:TimeInterval(newBase - startBase), animations: {
                    self.view?.viewWithTag(senderTag)?.alpha = 0.0
                    if awayOrHome == 0{
                        self.view?.viewWithTag(senderTag)?.center = self.awayBenchLoc
                    }
                    if awayOrHome == 1{
                        self.view?.viewWithTag(senderTag)?.center = self.homeBenchLoc
                    }
                })
            }
            var errorSituation = ""
            if errorModeState == 1{
                errorSituation = battingPosition + "失誤，"
            }
            if anybodyOnplate != 0{
                setRecordRunnerStatus(input:errorSituation + "\(startString)壘跑者\(newString)壘", playSituation: "beforePlay")
            }
            else{
                 setRecordRunnerStatus(input:errorSituation + "\(startString)壘跑者\(newString)壘", playSituation: "afterPlay")
            }
            result.text = ("\(startString)壘跑者\(newString)壘")
            getRunnerOnBase()
        }
        }
    }
    
    //-----------------拖曳打者觸發打擊結果-----------------------
    @IBAction func battingResultFunction(sender: UIPanGestureRecognizer) {
        let senderTag = sender.view!.tag
        let point = sender.location(in: sender.view?.viewWithTag(senderTag)!)
        self.view?.viewWithTag(senderTag)?.center.x = (self.view?.viewWithTag(senderTag)?.center.x)! + point.x
        self.view?.viewWithTag(senderTag)?.center.y = (self.view?.viewWithTag(senderTag)?.center.y)! + point.y
        if sender.state == UIGestureRecognizerState.ended {
            self.battingResultInPlay()
        }
    }
    @IBAction func runnerFunction(sender: UIPanGestureRecognizer){
        let senderTag = sender.view!.tag
        if sender.state == UIGestureRecognizerState.began{
            runnerStartPoint = (self.view?.viewWithTag(senderTag)?.center)!
        }
        let point = sender.location(in: sender.view?.viewWithTag(senderTag)!)
        self.view?.viewWithTag(senderTag)?.center.x = (self.view?.viewWithTag(senderTag)?.center.x)! + point.x
        self.view?.viewWithTag(senderTag)?.center.y = (self.view?.viewWithTag(senderTag)?.center.y)! + point.y
        if sender.state == UIGestureRecognizerState.ended {
            let x = (self.view?.viewWithTag(senderTag)?.center.x)!
            let y = (self.view?.viewWithTag(senderTag)?.center.y)!
            switch(runnerStartPoint){
            case (base1Loc):
                switch(getBaseOfHits(x: x, y: y)){
                case 2:
                    avoidRunnerOnSameBase(input: sender, startBase: 1, newBase: 2, senderTag: senderTag, startString: "一",newString: "上二")
                case 3:
                    avoidRunnerOnSameBase(input: sender, startBase: 1, newBase: 3, senderTag: senderTag,startString: "一",newString: "上三")
                case 4:
                    avoidRunnerOnSameBase(input: sender, startBase: 1, newBase: 4, senderTag: senderTag,startString: "一",newString: "回本")
                case 0:
                    avoidRunnerOnSameBase(input: sender, startBase: 1, newBase: 0, senderTag: senderTag, startString: "一", newString: "")
                    
                default:
                    self.view?.viewWithTag(senderTag)?.center = base1Loc
                }
            case (base2Loc):
                switch(getBaseOfHits(x: x, y: y)){
                case 3:
                    avoidRunnerOnSameBase(input: sender, startBase: 2, newBase: 3, senderTag: senderTag,startString: "二",newString: "上三")
                case 4:
                    avoidRunnerOnSameBase(input: sender, startBase: 2, newBase: 4, senderTag: senderTag,startString: "二",newString: "回本")
                case 0:
                    avoidRunnerOnSameBase(input: sender, startBase: 2, newBase: 0, senderTag: senderTag, startString: "二", newString: "")
                default:
                    self.view?.viewWithTag(senderTag)?.center = base2Loc
                }
            case (base3Loc):
                switch(getBaseOfHits(x: x, y: y)){
                case 4:
                    avoidRunnerOnSameBase(input: sender, startBase: 3, newBase: 4, senderTag: senderTag,startString: "三",newString: "回本")
                case 0:
                    avoidRunnerOnSameBase(input: sender, startBase: 3, newBase: 0, senderTag: senderTag, startString: "三", newString: "")
                default:
                    self.view?.viewWithTag(senderTag)?.center = base3Loc
                }
            default:
                break;
            }
        }
    }
    //-----------------拖曳打者觸發打擊結果 ended-----------------------
    
    //拖曳投手球，決定好壞球和觸身球
    @IBAction func pitch(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: pitchingBall)
        pitchingBall.center.x = pitchingBall.center.x + point.x
        pitchingBall.center.y = pitchingBall.center.y + point.y
        if sender.state == UIGestureRecognizerState.ended {
            addNP()
            if awayOrHome == 0{
                pitchCount.text? = String(Player.arrayOfPlayer[1][homePitcher].getPitchCount())
            }
            if awayOrHome == 1{
                pitchCount.text? = String(Player.arrayOfPlayer[0][awayPitcher].getPitchCount())
            }
            if pitchingBall.center.x > 217 && pitchingBall.center.x < 287 && pitchingBall.center.y > 263 {
                strike = strike + 1
                callStrike(count: strike)
            }
            else if pitchingBall.center.x > 167 && pitchingBall.center.x < 217 && pitchingBall.center.y > 243 && pitchingBall.center.y < 293 {
                self.result.text = "觸身球保送"
                //        gameLogRef.setValue("觸身球保送")
                setRecordResult(input: "觸身球保送")
                setRecordPByP(input: "觸身球保送")
                panRunnerGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
                Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].addBattingRecord(Record: "HBP")
                self.playerBattingRecord.text =  Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getbattingRecord()
                self.runnerOnBase.text = ""
                self.position.text = ""
                countReset()
                self.runner(batter: batterOn[awayOrHome], bases: 1)
            }
            else {
                ball = ball + 1
                callBall(count: ball)
            }
            UIView.animate(withDuration: 0.5,animations: {
                
                self.pitchingBall.center = self.pitchBallLoc
                
            })
        }
    }
    //失誤模式
    @IBAction func errorMode(sender: UITapGestureRecognizer){
        if(baseballFieldOfError.alpha == 0){
            errorCheck(whichTeam: awayOrHome)
            errorModeState = 1
            baseballFieldOfError.alpha = 1.0
            panHitting.isEnabled = false
            panPitching.isEnabled = false
            panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
            
            result.text = "發生失誤"
            
            if sender.view!.center == pitcherLoc{
                position.text = "投手"
            }
            if sender.view!.center == catcherLoc{
                position.text = "捕手"
            }
            if sender.view!.center == firstBaseLoc{
                position.text = "一壘手"
            }
            if sender.view!.center == secondBaseLoc{
                position.text = "二壘手"
            }
            if sender.view!.center == thirdBaseLoc{
                position.text = "三壘手"
            }
            if sender.view!.center == shortStopLoc{
                position.text = "游擊手"
            }
            if sender.view!.center == leftFielderLoc{
                position.text = "左外野手"
            }
            if sender.view!.center == centerFielderLoc{
                position.text = "中外野手"
            }
            if sender.view!.center == rightFielderLoc{
                position.text = "右外野手"
            }
            battingPosition = position.text!
        }
        else{
            errorModeState = 0
            baseballFieldOfError.alpha = 0
            panHitting.isEnabled = true
            panPitching.isEnabled = true
            panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = false
            self.result.text = ""
            self.position.text = ""
        }
    }
    
    //拖曳捕手，決定暴投或捕逸(待測試)
    /*
     @IBAction func PBorWP(sender: UIPanGestureRecognizer) {
     let point = sender.location(in: homePlayer2)
     let detect = sender.numberOfTouches
     var max = 0ll
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
     homePlayer2.center.x = (catcherX)
     homePlayer2.center.y = (catcherY)
     }
     
     }
     */
    
    @IBAction func exchangeDefFunction(sender: UIPanGestureRecognizer){
        let senderTag = sender.view!.tag
        let awayTagBase = 50
        let homeTagBase = 150
        var tagBase = 0
        var pitcherNum = 0
        if fieldingTeam == 0{
            pitcherNum = awayPitcher
        }
        else if fieldingTeam == 1{
            pitcherNum = homePitcher
        }
        let point = sender.location(in: sender.view?.viewWithTag(senderTag)!)
        if sender.state == UIGestureRecognizerState.began{
            switchPosition1Point = (self.view?.viewWithTag(senderTag)?.center)!
            switchPosition1 = getDefence(x:(self.view?.viewWithTag(senderTag)?.center.x)!,y:(self.view?.viewWithTag(senderTag)?.center.y)!)
        }
        self.view?.viewWithTag(senderTag)?.center.x = (self.view?.viewWithTag(senderTag)?.center.x)! + point.x
        self.view?.viewWithTag(senderTag)?.center.y = (self.view?.viewWithTag(senderTag)?.center.y)! + point.y
        if sender.state == UIGestureRecognizerState.ended {
            switchPosition2 = getDefence(x:(self.view?.viewWithTag(senderTag)?.center.x)!,y:(self.view?.viewWithTag(senderTag)?.center.y)!)
            switchPosition2Point = getLocation(position: switchPosition2)
            if switchPosition2 == "NULL" {
                self.view?.viewWithTag(senderTag)?.center = switchPosition1Point
            }
            else{
                for i in 0...8{
                    if fieldingTeam == 0{
                        tagBase = awayTagBase
                    }
                    else{
                        tagBase = homeTagBase
                    }
                    if Player.arrayOfPlayer[fieldingTeam][i].location == switchPosition2Point{
                        
                        Player.arrayOfPlayer[fieldingTeam][i].position = switchPosition1
                        Player.arrayOfPlayer[fieldingTeam][i].location = switchPosition1Point
                        batters[fieldingTeam][i].center = switchPosition1Point
                        
                        
                        Player.arrayOfPlayer[fieldingTeam][senderTag - tagBase].position = switchPosition2
                        Player.arrayOfPlayer[fieldingTeam][senderTag - tagBase].location = switchPosition2Point
                        self.view?.viewWithTag(senderTag)?.center = switchPosition2Point
                        if switchPosition1 == "P" && switchPosition2 != "NULL"{
                            if fieldingTeam == 0{
                                awayPitcher = i
                                pitcherNum = awayPitcher
                                awayRPCount += 1
                            }
                            else if fieldingTeam == 1{
                                homePitcher = i
                                pitcherNum = homePitcher
                                homeRPCount += 1
                            }
                            pitcherRecordReset()
                        }
                        else if switchPosition1 != "NULL" && switchPosition2 == "P" {
                            if fieldingTeam == 0{
                                awayPitcher = senderTag - tagBase
                                pitcherNum = awayPitcher
                                awayPitcher += 1
                            }
                            else if fieldingTeam == 1{
                                homePitcher = senderTag - tagBase
                                pitcherNum = homePitcher
                                homeRPCount += 1
                            }
                            pitcherRecordReset()
                        }
                        getPitcherInfo()
                        break;
                    }
                }
//                print(switchPosition1,"←→",switchPosition2)
            }
        }
    }
    
    
    func getPosition(x:CGFloat,y:CGFloat)->String{
        if y < 30 || (x < 30 && y < 70) || (x < 50 && y < 50) || (x > 435 && y < 70) || (x > 415 && y < 70)
        {
            if x < 155 {
                return "左外野方向"
            }
            else if x < 311{
                return "中外野方向"
            }
            else {
                return "右外野方向"
            }
        }
        else if x > (pitcherLoc.x - 30)
            && x < (pitcherLoc.x + 30)
            && y > (pitcherLoc.y - 30)
            && y < (pitcherLoc.y + 30){
            return  "投手方向"
        }
        else if x > (catcherLoc.x - 30)
            && x < (catcherLoc.x + 30)
            && y > (catcherLoc.y - 30)
            && y < (catcherLoc.y + 30){
            return  "本壘方向"
            
        }
        else if x > (firstBaseLoc.x - 30)
            && x < (firstBaseLoc.x + 30)
            && y > (firstBaseLoc.y - 30)
            && y < (firstBaseLoc.y + 30){
            return  "一壘方向"
        }
        else if x > (secondBaseLoc.x - 30)
            && x < (secondBaseLoc.x + 30)
            && y > (secondBaseLoc.y - 30)
            && y < (secondBaseLoc.y + 30){
            return  "二壘方向"
        }
        else if x > (thirdBaseLoc.x - 30)
            && x < (thirdBaseLoc.x + 30)
            && y > (thirdBaseLoc.y - 30)
            && y < (thirdBaseLoc.y + 30){
            return  "三壘方向"
            
        }
        else if x > (shortStopLoc.x - 30)
            && x < (shortStopLoc.x + 30)
            && y > (shortStopLoc.y - 30)
            && y < (shortStopLoc.y + 30){
            return  "游擊方向"
            
        }
        else if x > (centerFielderLoc.x - 30)
            && x < (centerFielderLoc.x + 30)
            && y > (centerFielderLoc.y - 30)
            && y < (centerFielderLoc.y + 30){
            return  "中外野方向"
            
        }
        else if x > (rightFielderLoc.x - 30)
            && x < (rightFielderLoc.x + 30)
            && y > (rightFielderLoc.y - 30)
            && y < (rightFielderLoc.y + 30){
            return  "右外野方向"
            
        }
        else if x > (leftFielderLoc.x - 30)
            && x < (leftFielderLoc.x + 30)
            && y > (leftFielderLoc.y - 30)
            && y < (leftFielderLoc.y + 30){
            return  "左外野方向"
        }
        else if ((x < 75 && y > 170)||(x < 148 && y > 210 ))||((x > 389 && y > 170) || (x < 316 && y > 210 )){
            return "界外球"
            
        }
        else{
            return"NULL"
        }
    }
    func getBaseOfHits(x:CGFloat,y:CGFloat)->Int{
        if  x > (base1Loc.x - 30)
            && x < (base1Loc.x + 30)
            && y > (base1Loc.y - 30)
            && y < (base1Loc.y + 30){
            return 1
        }
        else if x > (base2Loc.x - 30)
            && x < (base2Loc.x + 30)
            && y > (base2Loc.y - 30)
            && y < (base2Loc.y + 30){
            return 2
        }
        else if x > (base3Loc.x - 30)
            && x < (base3Loc.x + 30)
            && y > (base3Loc.y - 30)
            && y < (base3Loc.y + 30){
            return 3
        }
        else if x > (homeBaseLoc.x - 30)
            && x < (homeBaseLoc.x + 30)
            && y > (homeBaseLoc.y - 30)
            && y < (homeBaseLoc.y + 30){
            return 4
        }
            
        else if ((x < 75 && y > 170) || (x < 148 && y > 210)) || ((x > 389 && y > 170) || (x < 316 && y > 210)){
            
            return 0
        }
        else{
            return -10
        }
    }
    
    func getDefence(x:CGFloat,y:CGFloat)->String{
        if x > (pitcherLoc.x - 30)
            && x < (pitcherLoc.x + 30)
            && y > (pitcherLoc.y - 30)
            && y < (pitcherLoc.y + 30){
            return  "P"
        }
        else if x > (catcherLoc.x - 30)
            && x < (catcherLoc.x + 30)
            && y > (catcherLoc.y - 30)
            && y < (catcherLoc.y + 30){
            return  "C"
            
        }
        else if x > (firstBaseLoc.x - 30)
            && x < (firstBaseLoc.x + 30)
            && y > (firstBaseLoc.y - 30)
            && y < (firstBaseLoc.y + 30){
            return  "1B"
        }
        else if x > (secondBaseLoc.x - 30)
            && x < (secondBaseLoc.x + 30)
            && y > (secondBaseLoc.y - 30)
            && y < (secondBaseLoc.y + 30){
            return  "2B"
        }
        else if x > (thirdBaseLoc.x - 30)
            && x < (thirdBaseLoc.x + 30)
            && y > (thirdBaseLoc.y - 30)
            && y < (thirdBaseLoc.y + 30){
            return  "3B"
            
        }
        else if x > (shortStopLoc.x - 30)
            && x < (shortStopLoc.x + 30)
            && y > (shortStopLoc.y - 30)
            && y < (shortStopLoc.y + 30){
            return  "SS"
            
        }
        else if x > (centerFielderLoc.x - 30)
            && x < (centerFielderLoc.x + 30)
            && y > (centerFielderLoc.y - 30)
            && y < (centerFielderLoc.y + 30){
            return  "CF"
            
        }
        else if x > (rightFielderLoc.x - 30)
            && x < (rightFielderLoc.x + 30)
            && y > (rightFielderLoc.y - 30)
            && y < (rightFielderLoc.y + 30){
            return  "RF"
            
        }
        else if x > (leftFielderLoc.x - 30)
            && x < (leftFielderLoc.x + 30)
            && y > (leftFielderLoc.y - 30)
            && y < (leftFielderLoc.y + 30){
            return  "LF"
        }
        else{
            return "NULL"
        }
    }
    func getLocation(position: String)->CGPoint{
        switch(position){
        case "P": return pitcherLoc
        case "C": return catcherLoc
        case "1B": return firstBaseLoc
        case "2B": return secondBaseLoc
        case "3B": return thirdBaseLoc
        case "SS": return shortStopLoc
        case "LF": return leftFielderLoc
        case "RF": return rightFielderLoc
        case "CF": return centerFielderLoc
        default: return CGPoint(x:0,y:0)
        }
    }
    
    func getPitcherInfo(){
        var pitcherNum = 0
        if awayOrHome == 0{
            pitcherNum = homePitcher
        }
        else{
            pitcherNum = awayPitcher
        }
        pitchName.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getName()
        pitchIP.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getPitchIP()
        pitchERA.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getERA()
        pitchH.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getPitchH()
        pitchBB.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getPitchBB()
        pitchSO.text? = Player.arrayOfPlayer[fieldingTeam][pitcherNum].getPitchSO()
        pitchCount.text? = String(Player.arrayOfPlayer[fieldingTeam][pitcherNum].getPitchCount())
    }
}
