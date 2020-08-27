//
//  AddNewActivityViewController.swift
//  myapp2
//
//  Created by Alvian Gozali on 12/03/20.
//  Copyright © 2020 Alvian Gozali. All rights reserved.
//

import UIKit

class AddNewActivityViewController: UIViewController {
    
    @IBOutlet weak var titleNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeStartTextBox: UITextField!
    @IBOutlet weak var timeFinishStartBox: UITextField!
    @IBOutlet weak var addActivityBtn: UIButton!
    
    private var datePicker : UIPickerView?
    private var timePickerStart = UIDatePicker()
    private var timePickerFinish = UIDatePicker()
    private var activity: Activity!
    var wow = "test"
    
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddNewActivityViewController.viewTapped(gestureReconizer:)))
        view.addGestureRecognizer(tapGesture)
        
        createDatePickerForTextField(dateTextField)
        createTimePickerForTextFieldStart(timeStartTextBox,timePickerStart)
        createTimePickerForTextFieldFinish(timeFinishStartBox,timePickerFinish)
    }
    
    @IBAction func backToViewActivityBtn(_ sender: Any) {
        //self.performSegue(withIdentifier: "backToView", sender: self)
    }
    
    @IBAction func addActivityBtnPressed(_ sender: Any) {
        let title = titleNameTextField.text!
        let day = dateTextField.text!
        let startTime = timeStartTextBox.text!
        let finishTIme = timeFinishStartBox.text!
        
        let act = Activity.init(title, startTime, finishTIme, day)
        activity = act
        self.performSegue(withIdentifier: "addToGroupedActivity", sender: self)
    }
    
    @objc func viewTapped(gestureReconizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //DATE AND TIME
    func createDatePickerForTextField(_ textField: UITextField) {
//        let currentDate = Date()
//        datePicker = UIDatePicker()
//        datePicker?.datePickerMode = .date
//        datePicker?.minimumDate = currentDate as Date
//        datePicker?.date = currentDate as Date
//        datePicker?.addTarget(self, action: #selector(AddNewActivityViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //textField.inputView = datePicker
        
        datePicker = UIPickerView()
        datePicker!.dataSource = self
        datePicker!.delegate = self
        textField.inputView = datePicker
        
    }
    
    func createTimePickerForTextFieldStart(_ textField: UITextField, _ timePicker: UIDatePicker) {
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChangedStart(timePicker:)), for: .valueChanged)
        textField.inputView = timePicker
    }
    
    func createTimePickerForTextFieldFinish(_ textField: UITextField, _ timePicker: UIDatePicker) {
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(AddNewActivityViewController.timeChangedFinish(timePicker:)), for: .valueChanged)
        textField.inputView = timePicker
    }
    
//    @objc func dateChanged(datePicker: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        dateTextField.text = dateFormatter.string(from: datePicker.date)
//        //view.endEditing(true)
//    }
    
    @objc func timeChangedStart(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeStartTextBox.text = timeFormatter.string(from: timePicker.date)
    }
    
    @objc func timeChangedFinish(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFinishStartBox.text = timeFormatter.string(from: timePicker.date)
    }
    
    // SEND DATA
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ViewController
        if activity != nil {
            //print("test")
            vc?.addToGroupedActivities(activity)
        }
    }
}

// Day Picker View

extension AddNewActivityViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateTextField.text = days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
}
