//
//  newViewController.swift
//  calendarView
//
//  Created by Md Ibrahim Hassan on 29/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class newViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let departmentArray : [String] = ["Kitchen", "Sales", "Maintainence"]
    let namesArray : [String] = ["Ibrahim", "Suleyman", "Sal", "Lolla"]
    var selectedNameIndex : Int = 0
    var selectedDepartmentIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        let view1 = UIView.init(frame: CGRect.init(x: 0, y: 5, width: 32, height: 32))
//        let imageView1 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 32, height: 32))
//        imageView1.image = UIImage.init(named: "arrow_down")
//        view1.addSubview(imageView1)
//        self.departmentSelectTextField.rightView = view1
//        self.departmentSelectTextField.rightViewMode = .always
//        let view2 = UIView.init(frame: CGRect.init(x: 0, y: 5, width: 32, height: 32))
//        let imageView2 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 32, height: 32))
//        imageView2.image = UIImage.init(named: "arrow_down")
//        view2.addSubview(imageView2)
//        self.nameTextField.rightViewMode = .always
//        self.nameTextField.rightView = view2
        let pickerCat = UIPickerView.init()
        pickerCat.tag = 1000
        pickerCat.delegate = self
        pickerCat.dataSource = self
        pickerCat.showsSelectionIndicator = false
        let pickerSub = UIPickerView.init()
        pickerSub.tag = 1001
        pickerSub.delegate = self
        pickerSub.dataSource = self
        pickerSub.showsSelectionIndicator = false
        let toolBar = UIToolbar.init()
        let toolBarFrame = CGRect(x: 0, y: 0, width:self.view.frame.size.width , height: 44)
        toolBar.frame = toolBarFrame
        let cancel = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed(sender:)))
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed(sender:)))
        toolBar.items = [cancel,flexibleSpace,done];
        self.departmentSelectTextField.inputView = pickerCat
        self.departmentSelectTextField.inputAccessoryView = toolBar
        self.nameTextField.inputView = pickerSub
        self.nameTextField.inputAccessoryView = toolBar
        /*Adding Date Picker*/
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .dateAndTime
        self.fromTimeTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        let datePickerView1:UIDatePicker = UIDatePicker()
        datePickerView1.datePickerMode = .dateAndTime
        self.totextField.inputView = datePickerView1
        datePickerView1.addTarget(self, action: #selector(datePickerValueChanged1), for: UIControlEvents.valueChanged)
        self.totextField.inputAccessoryView = toolBar
        self.fromTimeTextField.inputAccessoryView = toolBar
    }
    func datePickerValueChanged (sender : UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        fromTimeTextField.text = dateFormatter.string(from: sender.date)
    }
    func datePickerValueChanged1 (sender : UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        totextField.text = dateFormatter.string(from: sender.date)
    }
    @IBOutlet weak var departmentSelectTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fromTimeTextField: UITextField!
    @IBOutlet weak var totextField: UITextField!
    @IBAction func submitButton(_ sender: UIButton) {
        print ("Validate here and send to Firebase")
    }
    //Picker View Delegate and Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func cancelButtonPressed(sender: UIBarButtonItem) {
        if (self.totextField.isEditing){
            self.totextField.text = ""
        }
        if (self.fromTimeTextField.isEditing){
            self.fromTimeTextField.text = ""
        }
        self.view.endEditing(true)
    }
    func doneButtonPressed(sender: UIBarButtonItem) {
        if (self.departmentSelectTextField.isEditing){
        self.departmentSelectTextField.text = self.departmentArray[self.selectedDepartmentIndex]
        self.departmentSelectTextField.resignFirstResponder()
        }
        if (self.nameTextField.isEditing){
        self.nameTextField.text = self.namesArray[self.selectedNameIndex]
        self.nameTextField.resignFirstResponder()
        }
        if (self.totextField.isEditing){
            self.totextField.resignFirstResponder()
        }
        if (self.fromTimeTextField.isEditing){
            self.fromTimeTextField.resignFirstResponder()
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1000)
        {
            return self.departmentArray.count
        }
        else
        {
            return self.namesArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1001)
        {
            return self.namesArray[row]
        }
        else
        {
            return self.departmentArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1001)
        {
            self.selectedDepartmentIndex = row
        }
        else
        {
            self.selectedNameIndex = row
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
