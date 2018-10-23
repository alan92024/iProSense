//
//  MainViewController.swift
//  iProSense
//
//  Created by Alan Singsaas on 10/22/18.
//  Copyright © 2018 Sensory Metrics. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ageYearsField: UITextField!
    @IBOutlet weak var ageMonthsField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var handField: UITextField!
    @IBOutlet weak var childIDField: UITextField!
    @IBOutlet weak var diagnosisField: UITextField!
    
    let agePicker = UIPickerView()
    let genderPicker = UIPickerView()
    let handPicker = UIPickerView()
  
    let ageYearsData = [String](arrayLiteral: "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15")
    let ageMonthsData = [String](arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11")
    let genderData = [String](arrayLiteral: "Male", "Female")
    let handData = [String](arrayLiteral: "Left", "Right")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        agePicker.delegate = self
        genderPicker.delegate = self
        handPicker.delegate = self
        
        agePicker.dataSource = self
        genderPicker.dataSource = self
        handPicker.dataSource = self
        
        ageYearsField.inputView = agePicker
        ageMonthsField.inputView = agePicker
        genderField.inputView = genderPicker
        handField.inputView = handPicker
 
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == agePicker {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var dataCount = 0
        
        if pickerView == agePicker {
            
            if component == 0 {
                dataCount = ageYearsData.count
                
            } else if component == 1 {
                dataCount = ageMonthsData.count
            }
            
        } else if pickerView == genderPicker {
            dataCount = genderData.count
            
        } else if pickerView == handPicker{
            dataCount = handData.count
        }
        
        return dataCount
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == agePicker {
            
            let yearSelected = ageYearsData[pickerView.selectedRow(inComponent: 0)]
            let monthSelected = ageMonthsData[pickerView.selectedRow(inComponent: 1)]
            
            ageYearsField.text = yearSelected
            ageMonthsField.text = monthSelected
            
            self.view.endEditing(true)
   
        } else if pickerView == genderPicker {
            genderField.text = genderData[row]
            
        } else if pickerView == handPicker {
            handField.text = handData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == agePicker {
            
            if component == 0 {
                return ageYearsData[row]
            }
            return ageMonthsData[row]
        }
        if pickerView == genderPicker {
            return genderData[row]
        }
        
        return handData[row]
    }


}

