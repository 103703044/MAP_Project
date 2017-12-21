//
//  test.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/11/15.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//
import Foundation
import UIKit
import Firebase
public var awayTeamInput:String!
public var homeTeamInput:String!
public var dateInput:String!
public var timeInput:String!
public var avenueInput:String!
class TestController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var ref = FIRDatabase.database().reference()
    @IBOutlet weak var oppTextField:UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var selectHome: UITextField!
    @IBOutlet weak var myTeam: UILabel!
    @IBOutlet weak var avenueTextField: UITextField!
    @IBOutlet weak var lineupView: UIView!
    
    @IBOutlet weak var A1: UITextField!
    
    @IBOutlet weak var A2: UITextField!
    
    @IBOutlet weak var A3: UITextField!
    
    @IBOutlet weak var A4: UITextField!
    
    @IBOutlet weak var A5: UITextField!
    
    @IBOutlet weak var A6: UITextField!
    
    @IBOutlet weak var A7: UITextField!
    
    @IBOutlet weak var A8: UITextField!
    
    @IBOutlet weak var A9: UITextField!
    
    @IBOutlet weak var H1: UITextField!
    
    @IBOutlet weak var H2: UITextField!
    
    @IBOutlet weak var H3: UITextField!
    
    @IBOutlet weak var H4: UITextField!
    
    @IBOutlet weak var H5: UITextField!
    
    @IBOutlet weak var H6: UITextField!
    
    @IBOutlet weak var H7: UITextField!
    
    @IBOutlet weak var H8: UITextField!
    
    @IBOutlet weak var H9: UITextField!
    
    @IBOutlet weak var Aname1: UITextField!
    @IBOutlet weak var Aname2: UITextField!
    @IBOutlet weak var Aname3: UITextField!
    @IBOutlet weak var Aname4: UITextField!
    @IBOutlet weak var Aname5: UITextField!
    @IBOutlet weak var Aname6: UITextField!
    @IBOutlet weak var Aname7: UITextField!
    @IBOutlet weak var Aname8: UITextField!
    @IBOutlet weak var Aname9: UITextField!
    @IBOutlet weak var Hname1: UITextField!
    @IBOutlet weak var Hname2: UITextField!
    @IBOutlet weak var Hname3: UITextField!
    @IBOutlet weak var Hname4: UITextField!
    @IBOutlet weak var Hname5: UITextField!
    @IBOutlet weak var Hname6: UITextField!
    @IBOutlet weak var Hname7: UITextField!
    @IBOutlet weak var Hname8: UITextField!
    @IBOutlet weak var Hname9: UITextField!
    
    
    @IBOutlet weak var confirmHint: UILabel!
    @IBOutlet weak var ErrorWarning: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var confirm: UIButton!
    var positionTextField = [[UITextField]]()
    var positionPickerView = [[UIPickerView]]()
    var namePickerView = [[UIPickerView]]()
    var nameTextField = [[UITextField]]()
    let formatter = DateFormatter()
    let dateNow = Date()
    let datePicker = UIDatePicker()
    let oppPickerView = UIPickerView()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var teamArray: [String] = []
    var nameArray: [[String]] = [[],[]]
    var selectArray = ["Away","Home"]
    var positionArray = ["P","C","1B","2B","3B","SS","LF","CF","RF"]
    var awayPlayerCount : Int!
    var homePlayerCount : Int!
    let selectPickerView = UIPickerView()
    let PickerViewPA1 = UIPickerView()
    let PickerViewPA2 = UIPickerView()
    let PickerViewPA3 = UIPickerView()
    let PickerViewPA4 = UIPickerView()
    let PickerViewPA5 = UIPickerView()
    let PickerViewPA6 = UIPickerView()
    let PickerViewPA7 = UIPickerView()
    let PickerViewPA8 = UIPickerView()
    let PickerViewPA9 = UIPickerView()
    let PickerViewPH1 = UIPickerView()
    let PickerViewPH2 = UIPickerView()
    let PickerViewPH3 = UIPickerView()
    let PickerViewPH4 = UIPickerView()
    let PickerViewPH5 = UIPickerView()
    let PickerViewPH6 = UIPickerView()
    let PickerViewPH7 = UIPickerView()
    let PickerViewPH8 = UIPickerView()
    let PickerViewPH9 = UIPickerView()
    let PickerViewNA1 = UIPickerView()
    let PickerViewNA2 = UIPickerView()
    let PickerViewNA3 = UIPickerView()
    let PickerViewNA4 = UIPickerView()
    let PickerViewNA5 = UIPickerView()
    let PickerViewNA6 = UIPickerView()
    let PickerViewNA7 = UIPickerView()
    let PickerViewNA8 = UIPickerView()
    let PickerViewNA9 = UIPickerView()
    let PickerViewNH1 = UIPickerView()
    let PickerViewNH2 = UIPickerView()
    let PickerViewNH3 = UIPickerView()
    let PickerViewNH4 = UIPickerView()
    let PickerViewNH5 = UIPickerView()
    let PickerViewNH6 = UIPickerView()
    let PickerViewNH7 = UIPickerView()
    let PickerViewNH8 = UIPickerView()
    let PickerViewNH9 = UIPickerView()
    
    
    @IBAction func tap(_ sender: UIButton) {
        if selectHome.text != "Home" && selectHome.text != "Away"{
            let alert = UIAlertController(title: "Error", message:"請選擇先後攻", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else if oppTextField.text == ""{
            let alert = UIAlertController(title: "Error", message:"請選擇對戰隊伍", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else if oppTextField.text == myTeam.text{
            let alert = UIAlertController(title: "Error", message:"相同隊伍無法對戰", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else{
            if confirm.alpha == 1{
                let alert = UIAlertController(title: "Success", message:"已儲存雙方打序", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            confirm.alpha = 1
            confirmHint.alpha = 1
            
            ref.child("teams").child(oppTextField.text!).child("Abbreviation").observeSingleEvent(of: .value, with: {(opp)in
                if self.selectHome.text == "Home"{
                    awayTeamInput = opp.value! as! String
                    homeTeamInput = self.myTeam.text
                }
                else if self.selectHome.text == "Away"{
                    awayTeamInput = self.myTeam.text
                    homeTeamInput = opp.value! as! String
                }
                self.lineUpSetting(teamInput: homeTeamInput, awayOrHome: 1)
                self.lineUpSetting(teamInput: awayTeamInput, awayOrHome: 0)
            })
        }
    }
    
    @IBAction func updateData(_ sender: UIButton) {
        var positionRepeated:Bool = false
        var nameRepeated:Bool = false
        for i in 0 ... 1 {
            for j in 0 ... 7{
                for k in j+1 ... 8{
                    if positionTextField[i][j].text == positionTextField[i][k].text{
                        positionRepeated = true
                    }
                    if nameTextField[i][j].text == nameTextField[i][k].text{
                        nameRepeated = true
                    }
                }
            }
        }
        if positionRepeated == true{
            let alert = UIAlertController(title: "Error", message:"守位不可以重複", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else if nameRepeated == true{
            let alert = UIAlertController(title: "Error", message:"球員不可以重複", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else{
            if oppTextField.text == myTeam.text{
                let alert = UIAlertController(title: "Error", message:"隊伍不可以重複", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            else if selectHome.text != "Home" && selectHome.text != "Away"{
                let alert = UIAlertController(title: "Error", message:"請選擇先後攻", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            else if oppTextField.text == ""{
                let alert = UIAlertController(title: "Error", message:"請選擇對戰隊伍", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            else{
                for i in 0 ... 8{
                    avenueInput = avenueTextField.text
                    ref.child("teams").child(awayTeamInput).child("order").child(String(i+1)).child("Name").setValue(nameTextField[0][i].text)
                    ref.child("teams").child(homeTeamInput).child("order").child(String(i+1)).child("Name").setValue(nameTextField[1][i].text)
                    ref.child("teams").child(awayTeamInput).child("order").child(String(i+1)).child("Position").setValue(positionTextField[0][i].text)
                    ref.child("teams").child(homeTeamInput).child("order").child(String(i+1)).child("Position").setValue(positionTextField[1][i].text)
                }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainPage")
                self.present(vc!,animated: true,completion:nil)
            }
        }
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated:false)
        dateTextField.inputAccessoryView = toolbar
        timeTextField.inputAccessoryView = toolbar
        
        dateTextField.inputView = datePicker
        timeTextField.inputView = datePicker
    }
    func donePressed(){
        dateFormatter.dateFormat = "yyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        dateInput = dateFormatter.string(from: datePicker.date)
        timeInput = timeFormatter.string(from: datePicker.date)
        dateTextField.text = dateInput
        timeTextField.text = timeInput
        self.view.endEditing(true)
    }
    
    func lineUpSetting(teamInput: String, awayOrHome: Int){
        for i in 1 ... 9 {
            ref.child("teams").child(teamInput).child("order").child(String(i)).observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
                self.positionTextField[awayOrHome][i-1].text = snap.childSnapshot(forPath: "Position").value! as? String
                self.nameTextField[awayOrHome][i-1].text = snap.childSnapshot(forPath: "Name").value! as? String
            })
        }
        ref.child("teams").child(teamInput).child("Roster").observe(FIRDataEventType.value, with:{(snap:FIRDataSnapshot)in
            for i in 0 ... snap.childrenCount-1 {
                self.nameArray[awayOrHome].append((snap.childSnapshot(forPath:"\(i)/Name").value! as? String)!)
            }
        })
        lineupView.alpha = 1
        if awayOrHome == 1{
        ref.child("teams").child(teamInput).child("Ballpark").observeSingleEvent(of: .value, with: {(ballpark)in
            self.avenueTextField.text = ballpark.value! as? String
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("User/\(userUID)").observeSingleEvent(of: .value, with: {(UID)in
            self.myTeam.text = UID.value as? String
        })
        ref.child("teams/teamLists").observeSingleEvent(of: .value, with: {(count)in
            for i in 0 ... count.childrenCount-1 {
                self.ref.child("teams/teamLists").child(String(i)).observeSingleEvent(of: .value, with: {(team)in
                    self.teamArray.append(team.value as! String)
                })
            }
        })
        oppPickerView.delegate = self
        oppPickerView.dataSource = self
        selectPickerView.delegate = self
        selectPickerView.dataSource = self
        oppTextField.inputView = oppPickerView
        selectHome.inputView = selectPickerView
        createDatePicker()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        dateInput = dateFormatter.string(from: dateNow)
        timeInput = timeFormatter.string(from: dateNow)
        dateTextField.text = dateInput
        timeTextField.text = timeInput
        nameArray = [[],[]]
        positionTextField = [[A1,A2,A3,A4,A5,A6,A7,A8,A9] ,[H1,H2,H3,H4,H5,H6,H7,H8,H9]]
        nameTextField = [[Aname1,Aname2,Aname3,Aname4,Aname5,Aname6,Aname7,Aname8,Aname9],[Hname1,Hname2,Hname3,Hname4,Hname5,Hname6,Hname7,Hname8,Hname9]]
        positionPickerView = [[PickerViewPA1,PickerViewPA2,PickerViewPA3,PickerViewPA4,PickerViewPA5,PickerViewPA6,PickerViewPA7,PickerViewPA8,PickerViewPA9],[PickerViewPH1,PickerViewPH2,PickerViewPH3,PickerViewPH4,PickerViewPH5,PickerViewPH6,PickerViewPH7,PickerViewPH8,PickerViewPH9]]
        namePickerView = [[PickerViewNA1,PickerViewNA2,PickerViewNA3,PickerViewNA4,PickerViewNA5,PickerViewNA6,PickerViewNA7,PickerViewNA8,PickerViewNA9],[PickerViewNH1,PickerViewNH2,PickerViewNH3,PickerViewNH4,PickerViewNH5,PickerViewNH6,PickerViewNH7,PickerViewNH8,PickerViewNH9]]
        
        for i in 0 ... 1{
            for j in 0 ... 8{
                positionPickerView[i][j].delegate = self
                positionPickerView[i][j].dataSource = self
                namePickerView[i][j].delegate = self
                namePickerView[i][j].dataSource = self
                nameTextField[i][j].inputView = namePickerView[i][j]
                positionTextField[i][j].inputView = positionPickerView[i][j]
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if positionPickerView[0].contains(pickerView)||positionPickerView[1].contains(pickerView){
            return positionArray.count
        }
        else if namePickerView[0].contains(pickerView){
            return nameArray[0].count
        }
        else if namePickerView[1].contains(pickerView){
            return nameArray[1].count
        }
        else if pickerView == selectPickerView{
            return selectArray.count
        }
        else{
            return teamArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if positionPickerView[0].contains(pickerView)||positionPickerView[1].contains(pickerView){
            return positionArray[row]
        }
        else if namePickerView[0].contains(pickerView){
            return nameArray[0][row]
        }
        else if namePickerView[1].contains(pickerView){
            return nameArray[1][row]
        }
        else if pickerView == selectPickerView{
            return selectArray[row]
        }
        else{
            return teamArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == oppPickerView{
            self.oppTextField.text = self.teamArray[row]
        }
        else if pickerView == selectPickerView{
            self.selectHome.text = self.selectArray[row]
        }
        else{
            for i in 0 ... 1 {
                for j in 0 ... 8{
                    if pickerView == positionPickerView[i][j]{
                        self.positionTextField[i][j].text = self.positionArray[row]
                    }
                    else if pickerView == namePickerView[i][j]{
                        self.nameTextField[i][j].text = self.nameArray[i][row]
                    }
                }
            }
        }
        self.view.endEditing(false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
