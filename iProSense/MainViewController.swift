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
    
    let ageYearsData = [String](arrayLiteral: "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15")
    let ageMonthsData = [String](arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11")
    let genderData = [String](arrayLiteral: "Male", "Female")
    let handData = [String](arrayLiteral: "Left", "Right")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createClientDataPickers() {
        
        let agePicker = UIPickerView()
        let genderPicker = UIPickerView()
        let handPicker = UIPickerView()
        
        agePicker.delegate = self
        genderPicker.delegate = self
        handPicker.delegate = self
        
        
        
        ageYearsField.inputView =  agePicker
        ageMonthsField.inputView = agePicker
        genderField.inputView = genderPicker
        handField.inputView = handPicker
    }


}

