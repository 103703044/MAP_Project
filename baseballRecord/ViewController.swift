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
    var playerTest = [Int:Player]()
    var playTest = [Player]()
    var gameKey: String!
    
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
    @IBOutlet var awayNameOnboard: UILabel!
    @IBOutlet var homeNameOnboard: UILabel!
    
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

    @IBAction func checkScoreboard(_ sender: Any) {
        if scoreboard.alpha != 0{
            scoreboard.alpha = 0
        }//end if
        else{
            scoreboard.alpha = 0.8
       }//end else
    }//end checkScoreboard
    var scores = [[UILabel]]()
    var batters = [[UILabel]]()
    var panBattingGesture = [[UIPanGestureRecognizer]]()
    var tapErrorGesture = [[UITapGestureRecognizer]]()
    var panRunnerGesture = [[UIPanGestureRecognizer]]()
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
    let base1X:CGFloat = 327
    let base1Y:CGFloat = 179
    let base2X:CGFloat = 232
    let base2Y:CGFloat = 103
    let base3X:CGFloat = 137
    let base3Y:CGFloat = 179
    let inBoxX:CGFloat = 201
    let inBoxY:CGFloat = 260
    let homeBaseX:CGFloat = 232
    let homeBaseY:CGFloat = 257
    
    let hitBallX:CGFloat = 286
    let hitBallY:CGFloat = 231
    let pitchBallX:CGFloat = 232
    let pitchBallY:CGFloat = 185
    
    //defender position
    
    let pitcherX:CGFloat = 232
    let pitcherY:CGFloat = 143
    let catcherX:CGFloat = 232
    let catcherY:CGFloat = 299
    let firstBaseX:CGFloat = 342
    let firstBaseY:CGFloat = 141
    let secondBaseX:CGFloat = 284
    let secondBaseY:CGFloat = 91
    let thirdBaseX:CGFloat = 125
    let thirdBaseY:CGFloat = 141
    let shortStopX:CGFloat = 185
    let shortStopY:CGFloat = 91
    let shortStopNameX:CGFloat = 179
    let shortStopNameY:CGFloat = 79
    let leftFielderX:CGFloat = 98
    let leftFielderY:CGFloat = 83
    let rightFielderX:CGFloat = 367
    let rightFielderY:CGFloat = 83
    let centerFielderX:CGFloat = 232
    let centerFielderY:CGFloat = 36
    let homeBenchX:CGFloat = 360
    let homeBenchY:CGFloat = 250
    let awayBenchX:CGFloat = 100
    let awayBenchY:CGFloat = 250
    
    
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
    
    var eachPitchCount = 1
    var eachBatterCount = 0
    var topOrBot = "Top"
    var battingPosition : String!
 
    
    //---------------IBoutlet&varible number ended-------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        //let playerRef = ref?.child("player")
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList")
        let awayTeamRef = ref?.child("teams").child("Yankees")
        let homeTeamRef = ref?.child("teams").child("Phillies")
        let awayBattingOrderRef = awayTeamRef?.child("order")
        let homeBattingOrderRef = homeTeamRef?.child("order")
        gameKey = ref?.child("Game").childByAutoId().key
        awayTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("posts").child(self.gameKey!).child("Away").setValue(snap.value)
            self.AwayTeam.text = (snap.value as AnyObject).description
            self.awayNameOrder.text = (snap.value as AnyObject).description
            self.awayNameOnboard.text = (snap.value as AnyObject).description
        })
        homeTeamRef?.child("Abbreviation").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            self.ref?.child("posts").child(self.gameKey!).child("Home").setValue(snap.value)
            self.HomeTeam.text = (snap.value as AnyObject).description
            self.homeNameOrder.text = (snap.value as AnyObject).description
            self.homeNameOnboard.text = (snap.value as AnyObject).description
        })
        
    
        tapErrorGesture = [[tapErrorModeA1,tapErrorModeA2,tapErrorModeA3,tapErrorModeA4,tapErrorModeA5,tapErrorModeA6,tapErrorModeA7,tapErrorModeA8,tapErrorModeA9],[tapErrorModeH1,tapErrorModeH2,tapErrorModeH3,tapErrorModeH4,tapErrorModeH5,tapErrorModeH6,tapErrorModeH7,tapErrorModeH8,tapErrorModeH9]]
        
        panBattingGesture = [[panBattingResultAway1,panBattingResultAway2,panBattingResultAway3,panBattingResultAway4,panBattingResultAway5,panBattingResultAway6,panBattingResultAway7,panBattingResultAway8,panBattingResultAway9],[panBattingResultHome1,panBattingResultHome2,panBattingResultHome3,panBattingResultHome4,panBattingResultHome5,panBattingResultHome6,panBattingResultHome7,panBattingResultHome8,panBattingResultHome9]]
        
        panRunnerGesture = [[panRunnerA1,panRunnerA2,panRunnerA3,panRunnerA4,panRunnerA5,panRunnerA6,panRunnerA7,panRunnerA8,panRunnerA9],[panRunnerH1,panRunnerH2,panRunnerH3,panRunnerH4,panRunnerH5,panRunnerH6,panRunnerH7,panRunnerH8,panRunnerH9]]
        
        batters = [[awayPlayer1,awayPlayer2,awayPlayer3,awayPlayer4,awayPlayer5,awayPlayer6,awayPlayer7,awayPlayer8,awayPlayer9] , [homePlayer1,homePlayer2,homePlayer3,homePlayer4,homePlayer5,homePlayer6,homePlayer7,homePlayer8,homePlayer9]]
        
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
        
        let scoreboardRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("scoreboard")
        
        
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
        
        for i in 0 ... 8{
            scoreboardRef.child("\(i+1)").child("Top").observe(FIRDataEventType.value,with:{(score)in
                self.scores[0][i].text = String(describing: score.value as! AnyObject)
            })
            scoreboardRef.child("\(i+1)").child("Bot").observe(FIRDataEventType.value,with:{(score)in
                self.scores[1][i].text = String(describing: score.value as! AnyObject)
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
        baseballField.isUserInteractionEnabled = true
        baseball.isUserInteractionEnabled = true
        pitchingBall.isUserInteractionEnabled = true
    }
    //-----setDefence------
    //func-setDefence: 讓進攻方球員回到休息區並透明化，讓守備方球員到各自的守備位置並顯示
    func setDefence(setPlayers : [[UILabel]] , whichTeamBatting : Int , awayP : Int , homeP : Int){
        var fieldingTeam = 1
        playerName.text = ""
        playerPosition.text = ""
        playerBA.text = ""
        playerHit.text = ""
        playerBattingRecord.text = ""
        playerBattingOrder.text = ""
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
                    setPlayers[1][i].alpha = 0.0
                    setPlayers[1][i].center.x = self.homeBenchX
                    setPlayers[1][i].center.y = self.homeBenchY
                }//end for
                    //投手資訊
                    self.pitchName.text? = Player.arrayOfPlayer[0][awayP].getName()
                    self.pitchIP.text? = Player.arrayOfPlayer[0][awayP].getPitchIP()
                    self.pitchERA.text? = Player.arrayOfPlayer[0][awayP].getERA()
                    self.pitchH.text? = Player.arrayOfPlayer[0][awayP].getPitchH()
            }//end if
            else{
                //客隊進攻
                for i in 0 ... 8 {
                    self.panBattingGesture[1][i].isEnabled = false
                    self.panBattingGesture[0][i].isEnabled = false
                    self.tapErrorGesture[1][i].isEnabled = true
                    self.tapErrorGesture[0][i].isEnabled = false
                    self.panRunnerGesture[0][i].isEnabled = false
                    self.panRunnerGesture[1][i].isEnabled = false
                    setPlayers[0][i].alpha = 0.0
                    setPlayers[0][i].center.x = self.awayBenchX
                    setPlayers[0][i].center.y = self.awayBenchY
                }//end for
                    //投手資訊
                    self.pitchName.text? = Player.arrayOfPlayer[1][homeP].getName()
                    self.pitchIP.text? = Player.arrayOfPlayer[1][homeP].getPitchIP()
                    self.pitchERA.text? = Player.arrayOfPlayer[1][homeP].getERA()
                    self.pitchH.text? = Player.arrayOfPlayer[1][homeP].getPitchH()
            }//end for
        })//end animation
        UIView.animate(withDuration: 0.5 , delay: 1.0, animations: {
            for i in 0 ... 8{
                setPlayers[fieldingTeam][i].alpha = 1.0
                setPlayers[fieldingTeam][i].center.x = Player.arrayOfPlayer[fieldingTeam][i].locationX
                setPlayers[fieldingTeam][i].center.y = Player.arrayOfPlayer[fieldingTeam][i].locationY
            }
    })

    }
    //-----setDefence ended------

    //func-hitcheck(0 = 客隊打擊 1 = 主隊打擊):讓攻擊方的安打數+1
    func hitCheck(whichTeam: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("scoreboard")
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
    //func-inningCheck(0 = 上換下 1 = 下換上):上半局換成下半局，或下半局換到下局的上半局，並setDefence
    
    func inningCheck(whichTeamBattingEnded: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("scoreboard")
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
            scores[1][inning-1].textColor = UIColor.white
            inning = inning + 1
            scores[0][inning-1].textColor = UIColor.yellow
            innings.text = String (inning) + "▲"
            topOrBot = "Top"
            scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(0)
            awayOrHome = 0
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
        let gameLogRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("\(eachPitchCount)")
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("gamelog").child(gameKey!)

        self.runnerOnBase.text = ""
        result.text = "好球" + String (count)
        if count == 1{
            strikeCount.text = "● ○"
            gameLogRef.setValue("好球")
        }
        else if count == 2{
            strikeCount.text = "● ●"
            gameLogRef.setValue("好球")

        }
        else{
            result.text = "三振"
            gameLogRef.setValue("三振")
            HitChangingRecord(bases: -1)
            playerLogRef.child("SO").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getSO())
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            self.outChecking(Count: self.out)
            countReset()
        }
        eachPitchCount += 1
    }
    //func-callBall(本來的壞球數):投出壞球
    func callBall(count: Int){
          let gameLogRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("\(eachPitchCount)")
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("gamelog").child(gameKey!)
        
        self.runnerOnBase.text = ""
        result.text = "壞球" + String (count)
        if count == 1{
            ballCount.text = "● ○ ○"
            gameLogRef.setValue("壞球")
        }
        else if count == 2{
            ballCount.text = "● ● ○"
            gameLogRef.setValue("壞球")

        }
        else if count == 3{
            ballCount.text = "● ● ●"
            gameLogRef.setValue("壞球")

        }
        else{
            result.text = "四壞球保送"
            gameLogRef.setValue("四壞球保送")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "BB")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBB()
            playerBattingRecord.text = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getbattingRecord()
            playerLogRef.child("BB").setValue( Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getBB())
            self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
            countReset()
        }
        eachPitchCount += 1
    }
    //func-scoring(0 = 客場得分 1 = 主場得分):增加得分方一分，並增加投手的自責分(率)
    func scoring(whichTeam: Int) {
        let scoreboardRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("scoreboard")
        scoringOfTheInning = scoringOfTheInning + 1
        if whichTeam == 0 {
            awayScoring = awayScoring + 1
            awayScore.text = String (awayScoring)
            scoreboardRef.child("awayTotalScore").setValue(awayScoring)
           // inningScore[0][inning - 1].text = String(scoringOfTheInning)
        }
        else{
            homeScoring = homeScoring + 1
            homeScore.text = String (homeScoring)
            scoreboardRef.child("homeTotalScore").setValue(homeScoring)
          //  inningScore[1][inning - 1].text = String(scoringOfTheInning)
        }
        if awayOrHome == 1{
            Player.arrayOfPlayer[0][awayPitcher].addER()
            pitchERA.text? = Player.arrayOfPlayer[0][awayPitcher].getERA()
            
        }else{
            Player.arrayOfPlayer[1][homePitcher].addER()
            pitchERA.text? = Player.arrayOfPlayer[1][homePitcher].getERA()
        }

        scoreboardRef.child("\(inning)").child("\(topOrBot)").setValue(scoringOfTheInning)
        

    }
    
    
//func-runner(打擊的打者,壘打數):計算打者及跑者的壘包推進最小值(強迫進壘)
    func runner(batter: Int, bases: Int){
        var toFirstBase = false //有跑者進一壘的意圖
        var toSecondBase = false//有跑者進二壘的意圖
        var toThirdBase = false//有跑者進三壘的意圖
 //       if bases != 4{
   //         self.panRunnerGesture[awayOrHome][batter].isEnabled = true
     //   }
        self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (inBoxX)
        self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (inBoxY)
        if bases <= 0 {
            UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 0.0
            if self.awayOrHome == 0 {
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (self.awayBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (self.awayBenchY)
            }
            else{
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (self.homeBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (self.homeBenchY)
            }
        })
        }
        else{
        for j in 1 ... bases { //根據壘打數決定進行幾輪
            if j >= 1 { toFirstBase = true }
            if j >= 2 { toSecondBase = true }
            if j >= 3 { toThirdBase = true }
            for i in 0 ... 8 { //如果有人在打擊區，則進一壘意圖為T
                if self.batters[awayOrHome][i].center.x == self.inBoxX &&
                    self.batters[awayOrHome][i].center.y == self.inBoxY{
                    toFirstBase = true
                    }
            }
            for i in 0 ... 8 { //如果有人在一壘，且進一壘意圖為T，則進二壘意圖為T
                if self.batters[awayOrHome][i].center.x == self.base1X &&
                    self.batters[awayOrHome][i].center.y == self.base1Y && toFirstBase == true{
                    toSecondBase = true
                    }
                }
            for i in 0 ... 8 { //如果有人在二壘，且進二壘意圖為T，則進三壘意圖為T
                    if self.batters[awayOrHome][i].center.x == self.base2X &&
                        self.batters[awayOrHome][i].center.y == self.base2Y && toSecondBase == true{
                        toThirdBase = true
                        }
                    }
        
            for i in 0 ... 8 {
                //如果有人在打擊區，則上一壘
                if self.batters[awayOrHome][i].center.x == self.inBoxX &&
                self.batters[awayOrHome][i].center.y == self.inBoxY{
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                        self.batters[self.awayOrHome][i].center.x = self.base1X
                        self.batters[self.awayOrHome][i].center.y = self.base1Y
                    })
                }
                //如果一壘有人，且進一壘意圖為T，則一壘跑者上二壘
                else if self.batters[awayOrHome][i].center.x == CGFloat(self.base1X) &&
                self.batters[awayOrHome][i].center.y == self.base1Y && toFirstBase == true{
                    UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                        self.batters[self.awayOrHome][i].center.x = self.base2X
                        self.batters[self.awayOrHome][i].center.y = self.base2Y
                    })
                }
                //如果二壘有人，且進二壘意圖為T，則二壘跑者上三壘
                else if self.batters[awayOrHome][i].center.x == (self.base2X) &&
                self.batters[awayOrHome][i].center.y == (self.base2Y) && toSecondBase == true{
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                        self.batters[self.awayOrHome][i].center.x = (self.base3X)
                        self.batters[self.awayOrHome][i].center.y = (self.base3Y)
                    })
                }
                //如果三壘有人，且進三壘的意圖為T，則三壘跑者回本壘得分
                else if self.batters[awayOrHome][i].center.x == (self.base3X) &&
                self.batters[awayOrHome][i].center.y == (self.base3Y) && toThirdBase == true{
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                        self.batters[self.awayOrHome][i].center.x = (self.homeBaseX)
                        self.batters[self.awayOrHome][i].center.y = (self.homeBaseY)
                    })
                
                    UIView.animate(withDuration: 1.0,delay: TimeInterval(j) ,animations: {
                        self.batters[self.awayOrHome][i].alpha = 0.0
                        if self.awayOrHome == 0{
                            self.batters[self.awayOrHome][i].center.x = (self.awayBenchX)
                            self.batters[self.awayOrHome][i].center.y = (self.awayBenchY)

                        }
                        if self.awayOrHome == 1{
                            self.batters[self.awayOrHome][i].center.x = (self.homeBenchX)
                            self.batters[self.awayOrHome][i].center.y = (self.homeBenchY)
                        }
                    })
                    scoring(whichTeam: awayOrHome)
                }
            }
            }
        }
    }
    
    //func-batterOutFunc:打者出局，更新打者與投手紀錄，並檢查出局數和局數
    /*
    func batterOutFunc(){
        UIView.animate(withDuration: 1.0,animations: {
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addOut()
            //        打者打擊率
            self.playerBA.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getBA()
            //        打者打擊紀錄
            self.playerHit.text? = "\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())-\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())"
            self.playerBattingRecord.text? =             Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getbattingRecord()

            //        投手紀錄
            if self.awayOrHome == 1{
                Player.arrayOfPlayer[0][self.awayPitcher].addIP()
                self.pitchIP.text? = Player.arrayOfPlayer[0][self.awayPitcher].getPitchIP()
                self.pitchERA.text? = Player.arrayOfPlayer[0][self.awayPitcher].getERA()
            }else{
                Player.arrayOfPlayer[1][self.homePitcher].addIP()
                self.pitchIP.text? = Player.arrayOfPlayer[1][self.homePitcher].getPitchIP()
                self.pitchERA.text? = Player.arrayOfPlayer[1][self.homePitcher].getERA()
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 0.0
            if self.awayOrHome == 0 {
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (self.awayBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (self.awayBenchY)
            }
            else{
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (self.homeBenchX)
                self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (self.homeBenchY)
            }
        })
            self.out = self.out + 1
            self.outChecking(Count: self.out)

    }
 */
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
            inningCheck(whichTeamBattingEnded: awayOrHome)
        }
 
    }
    
    //點擊背景觸發func-call:讓下一位打者上打擊區
@IBAction func call(_ sender: UITapGestureRecognizer) {
        eachPitchCount = 1
        callingCount += 1
        if callingCount == 1{
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList")
            Player.arrayOfPlayer[0].sort{$1.battingOrder > $0.battingOrder}
            Player.arrayOfPlayer[1].sort{$1.battingOrder > $0.battingOrder}
            for i in 0 ... 1{
                for j in 0 ... 8{
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("AB").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("H").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("2B").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("3B").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("HR").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("BB").setValue(0)
                    playerLogRef.child(Player.arrayOfPlayer[i][j].getName()).child("gamelog").child(gameKey!).child("SO").setValue(0)
                }
            }
            
        setDefence(setPlayers: batters, whichTeamBatting: awayOrHome, awayP: awayPitcher, homeP: homePitcher)
        for i in 0...8{
            if Player.arrayOfPlayer[1][i].position == "P"{
                homePitcher = i
            }
            if Player.arrayOfPlayer[0][i].position == "P"{
                awayPitcher = i
            }
        }
        if self.awayOrHome == 0{
            pitchName.text? = Player.arrayOfPlayer[1][homePitcher].getName()
            pitchIP.text? = Player.arrayOfPlayer[1][homePitcher].getPitchIP()
            pitchERA.text? = Player.arrayOfPlayer[1][homePitcher].getERA()
            pitchH.text? = Player.arrayOfPlayer[1][homePitcher].getPitchH()
        }
        else{
            pitchName.text? = Player.arrayOfPlayer[0][awayPitcher].getName()
            pitchIP.text? = Player.arrayOfPlayer[0][awayPitcher].getPitchIP()
            pitchERA.text? = Player.arrayOfPlayer[0][awayPitcher].getERA()
            pitchH.text? = Player.arrayOfPlayer[0][awayPitcher].getPitchH()
            }
    }
        else{
            for i in 0 ... 1 {
                for j in 0 ... 8{
                    panBattingGesture[i][j].isEnabled = false
                }
            }
        self.result.text = ""
        self.position.text = ""
        self.runnerOnBase.text = ""
        getRunnerOnBase()//文字更新目前壘上狀況
        UIView.animate(withDuration: 1.0, delay: 0 , animations: {
            self.baseball.center.x = (self.hitBallX)
            self.baseball.center.y = (self.hitBallY)
        })
        UIView.animate(withDuration: 1.0,animations: {
            self.batterOn[self.awayOrHome] = self.batterOn[self.awayOrHome] + 1
            if self.batterOn[self.awayOrHome] == 9{
                self.batterOn[self.awayOrHome] = 0
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 1.0
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (self.inBoxX)
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (self.inBoxY)
            self.eachBatterCount += 1
        })
        //打者資訊
        playerName.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getName()
        playerPosition.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getPosition()
        playerBA.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getBA()
        playerHit.text? = "\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())-\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())"
        playerBattingRecord.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getbattingRecord()
        playerBattingOrder.text? = "\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getBattingOrder())"
    }
    }
    //func-getRunnerOnBase:文字提示更新目前壘上狀況
    func getRunnerOnBase(){
        var check1 = false
        var check2 = false
        var check3 = false
        for i in 0...8 {
            if self.batters[awayOrHome][i].center.x == (self.base1X) &&
                self.batters[awayOrHome][i].center.y == (self.base1Y){
                check1 = true
            }
            else if self.batters[awayOrHome][i].center.x == (self.base2X) &&
                self.batters[awayOrHome][i].center.y == (self.base2Y){
                check2 = true
            }
            else if self.batters[awayOrHome][i].center.x == (self.base3X) &&
                self.batters[awayOrHome][i].center.y == (self.base3Y){
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
        panBattingGesture[awayOrHome][batterOn[awayOrHome]].isEnabled = true
         let gameLogRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("\(eachPitchCount)")
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("gamelog").child(gameKey!)
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
                    self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = (inBoxX)
                    self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = (inBoxY)
                    HitChangingRecord(bases: 4)
                playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
                    playerLogRef.child("H").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())
                playerLogRef.child("HR").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHR())
                    gameLogRef.setValue(battingPosition + "全壘打")
            }
            else if getPosition(x: baseball.center.x, y: baseball.center.y) == "NULL"{}
            else{
                if getPosition(x: baseball.center.x, y: baseball.center.y) == "界外球"{
                    if strike < 2 {
                        strike = strike + 1
                    }
                    callStrike(count: strike)
                    self.position.text = ""
                    self.result.text = "界外球"
                    gameLogRef.setValue("界外球")
                    self.runnerOnBase.text = ""
                    baseball.center.x = (hitBallX)
                    baseball.center.y = (hitBallY)
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
    
    func HitChangingRecord(bases: Int){
        if bases == 1 {
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "H")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addHit()
        }
        else if bases == 2{
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "2B")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addHit()
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].add2B()
        }
        else if bases == 3{
        Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "3B")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addHit()
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].add3B()
        }
        else if bases == 4{
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "HR")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addHit()
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addHR()
        }
        else if bases == 0{
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "Out")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addOut()
        }
        else if bases == -1{
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "K")
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addOut()
            Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addSO()
        }
        //        打者打擊率
        playerBA.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getBA()
        //        打者打擊紀錄
        playerHit.text? = "\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())-\(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())"
        playerBattingRecord.text? = Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getbattingRecord()
        //        投手紀錄
        if awayOrHome == 1{
            if bases > 0 {
            Player.arrayOfPlayer[0][awayPitcher].addPitchH()
            self.hitCheck(whichTeam: self.awayOrHome)
            }
            else if bases <= 0{
                Player.arrayOfPlayer[0][self.awayPitcher].addIP()
                self.out = self.out + 1
            }
            pitchIP.text? = Player.arrayOfPlayer[0][awayPitcher].getPitchIP()
            pitchH.text? = Player.arrayOfPlayer[0][awayPitcher].getPitchH()
            self.runner(batter: self.batterOn[self.awayOrHome], bases: bases)

        }
        else{
            if bases > 0 {
            Player.arrayOfPlayer[1][homePitcher].addPitchH()
            self.hitCheck(whichTeam: self.awayOrHome)
            }
            else if bases <= 0{
                Player.arrayOfPlayer[1][self.homePitcher].addIP()
                self.out = self.out + 1
            }
            pitchIP.text? = Player.arrayOfPlayer[1][homePitcher].getPitchIP()
            pitchH.text? = Player.arrayOfPlayer[1][homePitcher].getPitchH()
            self.runner(batter: self.batterOn[self.awayOrHome], bases: bases)
        }

    }
    
    //func-battingResult:拖曳打者決定壘打數或出局
    func battingResultInPlay(){
        let gameLogRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("\(eachPitchCount)")
        let playerLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("gamelog").child(gameKey!)
        if  getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == -10{
        }
        else{
            
            self.runnerOnBase.text = ""
        if getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == 1{
                self.result.text = "一壘安打"
            gameLogRef.setValue(battingPosition + "一壘安打")
            HitChangingRecord(bases: 1)
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            playerLogRef.child("H").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())
        }
        else if  getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == 2{
            self.result.text = "二壘安打"
            gameLogRef.setValue(battingPosition + "二壘安打")
            HitChangingRecord(bases: 2)
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            playerLogRef.child("H").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())
            playerLogRef.child("2B").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].get2B())
        }
        else if  getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == 3{
            self.result.text = "三壘安打"
            gameLogRef.setValue(battingPosition + "三壘安打")
            HitChangingRecord(bases: 3)
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            playerLogRef.child("H").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())
            playerLogRef.child("3B").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].get3B())
        }
        else if  getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == 4{
            self.result.text = "全壘打"
            gameLogRef.setValue(battingPosition + "全壘打")
            HitChangingRecord(bases: 4)
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            playerLogRef.child("H").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHit())
            playerLogRef.child("HR").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getHR())
        }
            
        else if  getBaseOfHits(x: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x, y: self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y) == 0{
            self.result.text = "出局"
            gameLogRef.setValue(battingPosition + "出局")
            HitChangingRecord(bases: 0)
            playerLogRef.child("AB").setValue(Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getAtBat())
            self.outChecking(Count: self.out)
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
        let point = sender.location(in: sender.view?.viewWithTag(senderTag)!)
        self.view?.viewWithTag(senderTag)?.center.x = (self.view?.viewWithTag(senderTag)?.center.x)! + point.x
        self.view?.viewWithTag(senderTag)?.center.y = (self.view?.viewWithTag(senderTag)?.center.y)! + point.y
        if sender.state == UIGestureRecognizerState.ended {
            let x = (self.view?.viewWithTag(senderTag)?.center.x)!
            let y = (self.view?.viewWithTag(senderTag)?.center.y)!
            if (x > base2X - 30 && x < base2X + 30) && (y > base2Y - 30 && y < base2Y + 30){
                self.view?.viewWithTag(senderTag)?.center.x = base2X
                self.view?.viewWithTag(senderTag)?.center.y = base2Y
                self.result.text = "跑者上到二壘"
            }
            else if (x > base3X - 30 && x < base3X + 30) && (y > base3Y - 30 && y < base3Y + 30){
                self.view?.viewWithTag(senderTag)?.center.x = base3X
                self.view?.viewWithTag(senderTag)?.center.y = base3Y
                self.result.text = "跑者上到三壘"
            }
            else if (x > homeBaseX - 30 && x < homeBaseX + 30) && (y > homeBaseY - 30 && y < homeBaseY + 30){
                sender.view?.center.x = homeBaseX
                sender.view?.center.y = homeBaseY
                scoring(whichTeam: awayOrHome)
                self.result.text = "跑者回本壘得分"
            }
        }
    }
    //-----------------拖曳打者觸發打擊結果 ended-----------------------
    
    //拖曳投手球，決定好壞球和觸身球
    @IBAction func pitch(sender: UIPanGestureRecognizer) {
        let gameLogRef = FIRDatabase.database().reference().child("posts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("\(eachPitchCount)")
        
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
        gameLogRef.setValue("觸身球保送")
        Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].addBattingRecord(Record: "HBP")
        self.playerBattingRecord.text =  Player.arrayOfPlayer[self.awayOrHome][self.batterOn[self.awayOrHome]].getbattingRecord()
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

        self.pitchingBall.center.x = (self.pitchBallX)
        self.pitchingBall.center.y = (self.pitchBallY)
                
            })
        }
    }
    //失誤模式
    @IBAction func errorMode(sender: UITapGestureRecognizer){
        if(baseballFieldOfError.alpha == 0){
        baseballFieldOfError.alpha = 1.0
    
        self.result.text = "發生失誤"
        
        if sender.view!.center.x == 232 && sender.view!.center.y == 143{
            self.position.text = "投手"
        }
        if sender.view!.center.x == 232 && sender.view!.center.y == 299{
             self.position.text = "捕手"
        }
        if sender.view!.center.x == 342 && sender.view!.center.y == 141{
            self.position.text = "一壘手"
        }
        if sender.view!.center.x == 284 && sender.view!.center.y == 91{
            self.position.text = "二壘手"
        }
        if sender.view!.center.x == 125 && sender.view!.center.y == 141{
            self.position.text = "三壘手"
        }
        if sender.view!.center.x == 185 && sender.view!.center.y == 91{
            self.position.text = "游擊手"
        }
        if sender.view!.center.x == 98 && sender.view!.center.y == 83{
            self.position.text = "左外野手"
        }
        if sender.view!.center.x == 232 && sender.view!.center.y == 36{
            self.position.text = "中外野手"
        }
        if sender.view!.center.x == 367 && sender.view!.center.y == 83{
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
    /*
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
         homePlayer2.center.x = (catcherX)
         homePlayer2.center.y = (catcherY)
        }
        
    }
 */



    

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
        else if x > (pitcherX - 30)
            && x < (pitcherX + 30)
            && y > (pitcherY - 30)
            && y < (pitcherY + 30){
            return  "投手方向"
        }
        else if x > (catcherX - 30)
            && x < (catcherX + 30)
            && y > (catcherY - 30)
            && y < (catcherY + 30){
            return  "本壘方向"
            
        }
        else if x > (firstBaseX - 30)
            && x < (firstBaseX + 30)
            && y > (firstBaseY - 30)
            && y < (firstBaseY + 30){
            return  "一壘方向"
        }
        else if x > (secondBaseX - 30)
            && x < (secondBaseX + 30)
            && y > (secondBaseY - 30)
            && y < (secondBaseY + 30){
            return  "二壘方向"
        }
        else if x > (thirdBaseX - 30)
            && x < (thirdBaseX + 30)
            && y > (thirdBaseY - 30)
            && y < (thirdBaseY + 30){
            return  "三壘方向"
            
        }
        else if x > (shortStopX - 30)
            && x < (shortStopX + 30)
            && y > (shortStopY - 30)
            && y < (shortStopY + 30){
            return  "游擊方向"
            
        }
        else if x > (centerFielderX - 30)
            && x < (centerFielderX + 30)
            && y > (centerFielderY - 30)
            && y < (centerFielderY + 30){
            return  "中外野方向"
            
        }
        else if x > (rightFielderX - 30)
            && x < (rightFielderX + 30)
            && y > (rightFielderY - 30)
            && y < (rightFielderY + 30){
            return  "右外野方向"
            
        }
        else if x > (leftFielderX - 30)
            && x < (leftFielderX + 30)
            && y > (leftFielderY - 30)
            && y < (leftFielderY + 30){
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
        print (x)
        print (y)
        if  x > (base1X - 30)
            && x < (base1X + 30)
            && y > (base1Y - 30)
            && y < (base1Y + 30){
            return 1
        }
        else if x > (base2X - 30)
            && x < (base2X + 30)
            && y > (base2Y - 30)
            && y < (base2Y + 30){
            return 2
         }
        else if x > (base3X - 30)
            && x < (base3X + 30)
            && y > (base3Y - 30)
            && y < (base3Y + 30){
            return 3
        }
        else if x > (homeBaseX - 30)
            && x < (homeBaseX + 30)
            && y > (homeBaseY - 30)
            && y < (homeBaseY + 30){
            return 4
        }
            
        else if ((x < 75 && y > 170) || (x < 148 && y > 210)) || ((x > 389 && y > 170) || (x < 316 && y > 210)){
  
    return 0
    }
        else{
            return -10
        }
}
}
