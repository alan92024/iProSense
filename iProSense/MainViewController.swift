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
    let genderData = [String](arrayLiteral: "M", "F")
    let handData = [String](arrayLiteral: "L", "R")
    
    var activeTextField: UITextField!
    var testData = false
    var testID = ""
    
    @IBAction func clearClientDataButton(_ sender: Any) {
        
        ageYearsField.text = ""
        ageMonthsField.text = ""
        genderField.text = ""
        handField.text = ""
        diagnosisField.text = ""
    }
    @IBAction func testButton(_ sender: Any) {
        
        clearClientDataButton(self)
        testData = true
        let random = UInt32.random(in: 1...1000000)
        testID = "test" + String(random)
        isValidData()
    }
    
    func isValidData() {
        
        let alert = UIAlertController(title: "Input Error", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if !testData {
            
            if let inputStr = ageYearsField.text, inputStr.isEmpty {
                
                alert.message = "Please enter age in years"
                self.present(alert, animated: true, completion: nil)
            }

            if let inputStr = ageMonthsField.text, inputStr.isEmpty {
                
                alert.message = "Please enter age in months"
                self.present(alert, animated: true, completion: nil)
            }

            if let inputStr = genderField.text, inputStr.isEmpty {
                
                alert.message = "Please enter gender"
                self.present(alert, animated: true, completion: nil)
            }

            if let inputStr = handField.text, inputStr.isEmpty {
                
                alert.message = "Please enter handedness"
                self.present(alert, animated: true, completion: nil)
            }

            if let inputStr = childIDField.text, inputStr.isEmpty {
                
                alert.message = "Please enter a unique child ID"
                self.present(alert, animated: true, completion: nil)
            }

            if let inputStr = diagnosisField.text, inputStr.isEmpty {
                
                alert.message = "Please enter a diagnosis"
                self.present(alert, animated: true, completion: nil)
            }
            
            testID = ageYearsField.text! + "." + ageMonthsField.text! + "_" + genderField.text!
            + handField.text! + "_" + childIDField.text!
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeDataPicker()
        createToolBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if activeTextField == diagnosisField || activeTextField == childIDField {
            view.frame.origin.y = -100
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
        activeTextField = nil
    }

    deinit {
        // Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        dismissKeyboard()
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        ageYearsField.inputAccessoryView = toolBar
        ageMonthsField.inputAccessoryView = toolBar
        genderField.inputAccessoryView = toolBar
        handField.inputAccessoryView = toolBar
    }
    
    func initializeDataPicker() {
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




