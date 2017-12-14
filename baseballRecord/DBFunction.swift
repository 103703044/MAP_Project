//
//  DBFunction.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/11/21.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import Foundation
import  Firebase

func saveResult(input: String){
    var whichTeamPitch = 0
    var pitcherNum = 0
    var RPcount = 0
    if(awayOrHome == 0){
        whichTeamPitch = 1
        pitcherNum = homePitcher
        RPcount = homeRPCount
    }
    else{
        whichTeamPitch = 0
        pitcherNum = awayPitcher
        RPcount = awayRPCount
    }
    let pitcherLogRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName()).child("gamelog").child(gameKey!).child("Pitch")
    let batterLogRef = FIRDatabase.database().reference().child("Player").child("PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("gamelog").child(gameKey!)

    
    let pitcherCareerRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName()).child("career/pitch")
    let batterCareerRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName()).child("career")

    
    let gameBoxPitcherRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("Box").child("\(whichTeamPitch)/0/\(RPcount)")
    let gameBoxBatterRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("Box").child(String(awayOrHome)).child(String(batterOn[awayOrHome]+1))
    
    
    gameBoxPitcherRef.child("Name").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName())
    gameBoxBatterRef.child("Name").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName())
    
    
    switch input {
    case "SO":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        batterLogRef.child("SO").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getSO())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("SO").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getSO())
        careerSO += 1
        batterCareerRef.child("SO").setValue(careerSO)
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchSO()
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addIP()
        pitcherLogRef.child("ERA").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA())
        pitcherLogRef.child("SO").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchSO())
        pitcherLogRef.child("IP").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP())
        careerPitchSO += 1
        addCareerIP()
        pitcherCareerRef.child("ERA").setValue(Double(getCareerERA()))
        pitcherCareerRef.child("SO").setValue(careerPitchSO)
        pitcherCareerRef.child("IP").setValue(careerIP)

        
        gameBoxPitcherRef.child("ERA").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA()))
        gameBoxPitcherRef.child("SO").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchSO())
        gameBoxPitcherRef.child("IP").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP()))
        
        
    case "OUT":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addIP()
        pitcherLogRef.child("ERA").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA())
        pitcherLogRef.child("IP").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP())
        addCareerIP()
        pitcherCareerRef.child("ERA").setValue(Double(getCareerERA()))
        pitcherCareerRef.child("IP").setValue(careerIP)
        gameBoxPitcherRef.child("ERA").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA()))
        gameBoxPitcherRef.child("IP").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP()))
        
    case "E":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        pitcherLogRef.child("ERA").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA())
        pitcherLogRef.child("IP").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP())
        pitcherCareerRef.child("ERA").setValue(Double(getCareerERA()))
        pitcherCareerRef.child("IP").setValue(careerIP)
        gameBoxPitcherRef.child("ERA").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA()))
        gameBoxPitcherRef.child("IP").setValue(Double(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchIP()))
        
    case "BB":
        batterLogRef.child("BB").setValue( Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getBB())
        gameBoxBatterRef.child("BB").setValue( Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getBB())
        careerBB += 1
        batterCareerRef.child("BB").setValue(careerBB)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchBB()
        
        pitcherLogRef.child("BB").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchBB())
        
        careerPitchBB += 1
        pitcherCareerRef.child("BB").setValue(careerPitchBB)
        
        gameBoxPitcherRef.child("BB").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchBB())
    case "H":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        batterLogRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        careerH += 1
        batterCareerRef.child("H").setValue(careerH)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchH()

        pitcherLogRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
        
        careerPitchH += 1
        pitcherCareerRef.child("H").setValue(careerPitchH)
        
        gameBoxPitcherRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())

    case "2B":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        batterLogRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        batterLogRef.child("double").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].get2B())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        gameBoxBatterRef.child("double").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].get2B())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        careerH += 1
        batterCareerRef.child("H").setValue(careerH)
        career2B += 1
        batterCareerRef.child("double").setValue(career2B)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchH()
        pitcherLogRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
        
        careerPitchH += 1
        pitcherCareerRef.child("H").setValue(careerPitchH)

        gameBoxPitcherRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
    case "3B":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        batterLogRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        batterLogRef.child("triple").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].get3B())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        gameBoxBatterRef.child("triple").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].get3B())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        careerH += 1
        batterCareerRef.child("H").setValue(careerH)
        career3B += 1
        batterCareerRef.child("triple").setValue(career3B)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchH()
        
        pitcherLogRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
        
        careerPitchH += 1
        pitcherCareerRef.child("H").setValue(careerPitchH)

        gameBoxPitcherRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())

    case "HR":
        batterLogRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        batterLogRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        batterLogRef.child("HR").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHR())
        gameBoxBatterRef.child("AB").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getAtBat())
        gameBoxBatterRef.child("H").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHit())
        gameBoxBatterRef.child("HR").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getHR())
        careerAB += 1
        batterCareerRef.child("AB").setValue(careerAB)
        careerH += 1
        batterCareerRef.child("H").setValue(careerH)
        careerHR += 1
        batterCareerRef.child("HR").setValue(careerHR)
        
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchH()
        pitcherLogRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
        
        careerPitchH += 1
        pitcherCareerRef.child("H").setValue(careerPitchH)

        gameBoxPitcherRef.child("H").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchH())
        
    case "R":
        Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addER()
        gameBoxPitcherRef.child("ER").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchER())
        gameBoxPitcherRef.child("ERA").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA())
        pitcherLogRef.child("ER").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchER())
        pitcherLogRef.child("ERA").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getERA())
        careerPitchER += 1
        pitcherCareerRef.child("ER").setValue(careerPitchER)
        pitcherCareerRef.child("ERA").setValue(Double(getCareerERA()))

    case "RESET": break
    default: break
    }
    
}



func setRecordPByP(input: String){
    let gameLogRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)")
    gameLogRef.child("Pitch").child("\(eachPitchCount)").setValue(input)
    gameLogRef.child("Count").setValue(eachPitchCount)
    gameLogRef.child("Name").setValue(Player.arrayOfPlayer[awayOrHome][batterOn[awayOrHome]].getName())
}
func setRecordBaseStatus(input: String){
    let gameLogRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)")
    if eachBatterCount != 0 {
        if input == ""{
            gameLogRef.child("BaseStatus").setValue(input)
        }
        else{
            gameLogRef.child("BaseStatus").setValue("，" + input)
        }
    }
    if eachBatterCount != 0 && out == 0{
        gameLogRef.child("OutStatus").setValue("無人出局")
    }
    else if eachBatterCount != 0 && out == 1{
        gameLogRef.child("OutStatus").setValue("一人出局")
    }
    else if eachBatterCount != 0 && out == 2{
        gameLogRef.child("OutStatus").setValue("兩人出局")
    }
    else if eachBatterCount != 0 && out == 3{
        gameLogRef.child("OutStatus").setValue("三人出局")
    }
}
func setRecordResult(input: String){
    let gameLogRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("\(inning)").child("\(topOrBot)").child("\(eachBatterCount)")
    gameLogRef.child("Result").setValue(input)
}
func addNP(){
    var whichTeamPitch = 0
    var pitcherNum = 0
    var NP = 0
    var RPCount = 0
    if(awayOrHome == 0){
//        homeNP += 1
        whichTeamPitch = 1
        pitcherNum = homePitcher
        RPCount = homeRPCount
//        NP = homeNP
    }
    else{
//        awayNP += 1
        whichTeamPitch = 0
        pitcherNum = awayPitcher
        RPCount = awayRPCount
//        NP = awayNP
    }
    Player.arrayOfPlayer[whichTeamPitch][pitcherNum].addPitchCount()
    NP = Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getPitchCount()
    
    let pitcherLogRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName()).child("gamelog").child(gameKey!).child("Pitch")
    let pitcherCareerRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName()).child("career/pitch")
    let gameBoxPitcherRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("Box").child("\(whichTeamPitch)/0/\(RPCount)")
    
    pitcherLogRef.child("Count").setValue(NP)
    gameBoxPitcherRef.child("Count").setValue(NP)
    careerCount += 1
    pitcherCareerRef.child("Count").setValue(careerCount)
}

func pitcherRecordReset(){
    var whichTeamPitch = 0
    var pitcherNum = 0
    var RPcount = 0
    if(awayOrHome == 0){
        whichTeamPitch = 1
        pitcherNum = homePitcher
        RPcount = homeRPCount
    }
    else{
        whichTeamPitch = 0
        pitcherNum = awayPitcher
        RPcount = awayRPCount
    }
    let gameBoxRef = FIRDatabase.database().reference().child("newPosts").child(gameKey!).child("Box").child("\(whichTeamPitch)/0/\(RPcount)")
    let pitcherLogRef = FIRDatabase.database().reference().child("Player/PlayerList").child(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName()).child("gamelog").child(gameKey!).child("Pitch")
    gameBoxRef.child("SO").setValue(0)
    gameBoxRef.child("IP").setValue(0)
    gameBoxRef.child("BB").setValue(0)
    gameBoxRef.child("H").setValue(0)
    gameBoxRef.child("ER").setValue(0)
    gameBoxRef.child("Count").setValue(0)
    gameBoxRef.child("ERA").setValue(0)
    gameBoxRef.child("Name").setValue(Player.arrayOfPlayer[whichTeamPitch][pitcherNum].getName())
    
    pitcherLogRef.child("SO").setValue(0)
    pitcherLogRef.child("IP").setValue(0)
    pitcherLogRef.child("BB").setValue(0)
    pitcherLogRef.child("H").setValue(0)
    pitcherLogRef.child("ER").setValue(0)
    pitcherLogRef.child("Count").setValue(0)
    pitcherLogRef.child("ERA").setValue(0)
}
