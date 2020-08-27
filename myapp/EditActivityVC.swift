//
//  EditActivityVC.swift
//  myapp2
//
//  Created by Alvian Gozali on 17/03/20.
//  Copyright © 2020 Alvian Gozali. All rights reserved.
//

import UIKit

class EditActivityVC: UIViewController {
    private var activity: Activity!
    private var row = 0
    private var section = 0
    private var datePicker : UIPickerView?
    private var timePickerStart = UIDatePicker()
    private var timePickerFinish = UIDatePicker()
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @IBOutlet weak var titleEdit: UITextField!
    @IBOutlet weak var startEdit: UITextField!
    @IBOutlet weak var finishEdit: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddNewActivityViewController.viewTapped(gestureReconizer:)))
        view.addGestureRecognizer(tapGesture)
        createTimePickerForTextFieldStart(startEdit,timePickerStart)
        createTimePickerForTextFieldFinish(finishEdit,timePickerFinish)
        
        titleEdit.placeholder = activity.getTitle()
        //dayEdit.placeholder = activity.getDay()
        startEdit.placeholder = activity.getStartTime()
        finishEdit.placeholder = activity.getFinishTime()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backToView(_ sender: Any) {
        
    }
    
    @IBAction func editActivityBtn(_ sender: Any) {
        activity.setTitle(titleEdit.text!)
        activity.setStartTime(startEdit.text!)
        activity.setFinishTIme(finishEdit.text!)
        
        self.performSegue(withIdentifier: "editActivitySegue", sender: self)
    }
    
    //SETTER
    func setActivity(_ activity: Activity) {
        self.activity = activity
    }
    
    func setRow(_ row: Int){
        self.row = row
    }
    
    func setSection(_ section: Int){
        self.section = section
    }
    
    @objc func viewTapped(gestureReconizer: UITapGestureRecognizer){
            view.endEditing(true)
        }
        
    //DATE AND TIME
        
    func createTimePickerForTextFieldStart(_ textField: UITextField, _ timePicker: UIDatePicker) {
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(AddNewActivityViewController.timeChangedStart(timePicker:)), for: .valueChanged)
            textField.inputView = timePicker
    }
        
    func createTimePickerForTextFieldFinish(_ textField: UITextField, _ timePicker: UIDatePicker) {
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(AddNewActivityViewController.timeChangedFinish(timePicker:)), for: .valueChanged)
        textField.inputView = timePicker
    }
        
    @objc func timeChangedStart(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        startEdit.text = timeFormatter.string(from: timePicker.date)
    }
        
    @objc func timeChangedFinish(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        finishEdit.text = timeFormatter.string(from: timePicker.date)
    }
        
        // SEND DATA
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ViewController
        if activity != nil {
                //print("test")
            vc?.editActivity(activity, section, row)
        }
    }

}
