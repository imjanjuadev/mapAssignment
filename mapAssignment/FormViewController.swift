//
//  FormViewController.swift
//  mapAssignment
//
//  Created by Macbook Pro on 21/04/2022.
//

import UIKit
import QuartzCore
import RadioButton

class FormViewController : UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var nameError: UILabel!

    @IBOutlet weak var userCellNumber: UITextField!
    @IBOutlet weak var cellNumberError: UILabel!
    @IBOutlet weak var riderName: UITextField!
    
    @IBOutlet weak var tripDateLable: UILabel!
    @IBOutlet weak var riderLable: UILabel!
    
    @IBOutlet weak var userLocationLable: UITextField!
    @IBOutlet weak var userLocationPicker: UIPickerView!
    
    @IBOutlet weak var paymentMethod: UITextField!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var creditBtn: UIButton!
    
    @IBAction func cashBtnAction(_ sender: UIButton) {
        if sender.tag == 1 {
            cashBtn.isSelected = true
            creditBtn.isSelected = false
            paymentMethod.text = "CASH"
        }
        
        else if sender.tag == 2{
            cashBtn.isSelected = false
            creditBtn.isSelected = true
            paymentMethod.text = "CREDIT"
        }
    }
        
    let datePicker = UIDatePicker()
    
    var recieveRiderName = ""
    
    let userLocationData = [String](arrayLiteral: "New Dehli", "London", "Lahore","New York City")
        
    /*ViewDidLoad Function*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        riderName.text = recieveRiderName
        userLocationPicker.delegate = self
        createTripDateLable()
        createRiderLable()
    }
    
    
    func resetForm(){
        nameError.text = "Required"
        cellNumberError.text = "Required"
    }
    @IBAction func nameChanged(_ sender: Any) {
    }
    
    @IBAction func cellNumberChanged(_ sender: Any) {
        if let cellNumber = userCellNumber.text{
            if let errorMessage = invalidCellNumber(cellNumber){
                cellNumberError.text = errorMessage
                cellNumberError.isHidden = false
            }
            else{
                cellNumberError.isHidden = true
            }
        }
    }
    
    
    func invalidCellNumber(_ value: String) -> String?{
        
        if (value.count != 10)
        {
            return "Cell Number Must have 10 Digits"
        }
        return nil
    }
    func createTripDateLable(){
        riderLable.layer.cornerRadius = 5
        riderLable.layer.masksToBounds = true
    }
    func createRiderLable(){
        tripDateLable.layer.cornerRadius = 5
        tripDateLable.layer.masksToBounds = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userLocationData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userLocationData[row];

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userLocationLable.text = userLocationData[row]
    }
}
