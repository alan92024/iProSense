//
//  MainViewController.swift
//  iProSense
//
//  Created by Alan Singsaas on 10/22/18.
//  Copyright © 2018 Sensory Metrics. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var ageYearsField: UITextField!
    @IBOutlet weak var ageMonthsField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var handField: UITextField!
    @IBOutlet weak var childIDField: UITextField!
    @IBOutlet weak var diagnosisField: UITextField!
    
    let yearPicker = UIPickerView()
    let monthPicker = UIPickerView()
    let genderPicker = UIPickerView()
    let handPicker = UIPickerView()
  
    let ageYearsData = [String](arrayLiteral: "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15")
    let ageMonthsData = [String](arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11")
    let genderData = [String](arrayLiteral: "Male", "Female")
    let handData = [String](arrayLiteral: "Left", "Right")
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeTextFields()
        createToolBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if activeTextField == diagnosisField || activeTextField == childIDField {
            view.frame.origin.y = -100
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
    }
    
    deinit {
        // Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        
        case yearPicker:
            return ageYearsData.count
            
        case monthPicker:
            return ageMonthsData.count
            
        case genderPicker:
            return genderData.count
            
        case handPicker:
            return handData.count
        
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
            
        case yearPicker:
            return ageYearsData[row]
            
        case monthPicker:
            return ageMonthsData[row]
            
        case genderPicker:
            return genderData[row]
            
        case handPicker:
            return handData[row]
            
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
            
        case yearPicker:
            ageYearsField.text = ageYearsData[row]
            
        case monthPicker:
            ageMonthsField.text = ageMonthsData[row]
            
        case genderPicker:
            genderField.text = genderData[row]
            
        case handPicker:
            handField.text = handData[row]
            
        default:
            break
        }
    }
    
    func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(MainViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        ageYearsField.inputAccessoryView = toolBar
        ageMonthsField.inputAccessoryView = toolBar
        genderField.inputAccessoryView = toolBar
        handField.inputAccessoryView = toolBar
    }
    
    func initializeTextFields () {
        ageYearsField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        ageYearsField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        ageMonthsField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        ageMonthsField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        genderField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        genderField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        handField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        handField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        
        yearPicker.delegate = self
        monthPicker.delegate = self
        genderPicker.delegate = self
        handPicker.delegate = self
        
        yearPicker.dataSource = self
        monthPicker.dataSource = self
        genderPicker.dataSource = self
        handPicker.dataSource = self
        
        childIDField.delegate = self
        diagnosisField.delegate = self
        
        ageYearsField.inputView = yearPicker
        ageMonthsField.inputView = monthPicker
        genderField.inputView = genderPicker
        handField.inputView = handPicker
    }
}




