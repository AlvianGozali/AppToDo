//
//  ViewController.swift
//  myapp
//
//  Created by Alvian Gozali on 05/03/20.
//  Copyright © 2020 Alvian Gozali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    private var groupedActivities = [GroupedActivities]()
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        addDummyData()
    }
    
    @IBAction func rewindBackToViewActivity(segue: UIStoryboardSegue) {
        
    }
    
    // ACTIONS
    
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {

        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    func addToGroupedActivities(_ activity: Activity) {
        for item in groupedActivities {
            if item.getSection() == activity.getDay() {
                item.addActivity(activity)
            }
        tableView.reloadData()
        }
    }
    
    func addDummyData() {
        
        for day in days {
            groupedActivities.append(GroupedActivities.init(day))
        }
    }
    
    func editActivity(_ activity2: Activity, _ section: Int, _ row: Int){
        groupedActivities[section].getActivities()[row].setFinishTIme(activity2.getFinishTime())
        groupedActivities[section].getActivities()[row].setStartTime(activity2.getStartTime())
        groupedActivities[section].getActivities()[row].setTitle(activity2.getTitle())
        
        tableView.reloadData()
    }
    
    //TABLE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedActivities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedActivities[section].getActivities().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "\(groupedActivities[indexPath.section].getActivities()[indexPath.row].getTitle())\nFrom: \(groupedActivities[indexPath.section].getActivities()[indexPath.row].getStartTime()) - \(groupedActivities[indexPath.section].getActivities()[indexPath.row].getFinishTime())"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 15, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = colorWithHexString(hexString: "#5994FF")
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width, height: 40))
        lbl.text = groupedActivities[section].getSection()
        lbl.textColor = .white
        view.addSubview(lbl)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupedActivities[indexPath.section].removeActivity(indexPath.row)

            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditActivityVC") as? EditActivityVC
        vc?.setActivity(groupedActivities[indexPath.section].getActivities()[indexPath.row])
        vc?.setRow(indexPath.row)
        vc?.setSection(indexPath.section)
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }

//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let editButton = UITableViewRowAction(style: .normal, title: "Edit") {(rowAction, indexPath) in
//
//        }
//        editButton.backgroundColor = UIColor.green
//
//        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") {
//            (rowAction, indexPath) in
//            self.groupedActivities[indexPath.section].removeActivity(indexPath.row)
//
//            tableView.reloadData()
//        }
//        deleteButton.backgroundColor = UIColor.red
//
//        return [editButton, deleteButton]
//    }
    
    
}



