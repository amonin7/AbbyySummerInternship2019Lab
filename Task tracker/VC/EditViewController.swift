//
//  EditViewController.swift
//  Task tracker
//
//  Created by Andrey Minin on 31/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {

    var task = Task(name: "", date: Date(), descr: "", stat: "")
    
    var taskID = -1
    
    var status = "Новая"
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var noteText: UITextField!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if taskID != -1 {
            setup()
            let curTask = taskList[taskID]
            titleText.text = curTask.taskName
            noteText.text = curTask.taskDescription
            timePicker.date = curTask.taskDate
            segControl.selectedSegmentIndex = returnStatIndex(status: curTask.status)
            status = curTask.status
        } else {
            titleText.text = "task not found"
            noteText.text = "task not found"
            timePicker.date = Date()
        }
    }
    
    func returnStatIndex(status: String) -> Int{
        switch status {
        case "Новая":
            return 0
        case "В процессе":
            return 1
        case "Выполнена":
            return 2
        default:
            return 0
        }
    }
    
    func setup() {
        timePicker.minimumDate = Date()
        timePicker.locale = NSLocale.current
    }
    
    func checkTitle() {
        let text = titleText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func checkDate() {
        if NSDate().earlierDate(timePicker.date) == timePicker.date {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        checkDate()
    }
    
    @IBAction func save(_ sender: Any) {
        let name = titleText.text
        let time = timePicker.date
        let note = noteText.text
        
        task = Task(name: name!, date: time, descr: note ?? "", stat: status)
        taskList[taskID] = task
        self.dismiss(animated: true, completion: nil)
    }
    
    /// UserDefaults.saveListToUD(list: taskList) ///
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segControlTapped(_ sender: Any) {
        let getIndex = segControl.selectedSegmentIndex
        print(getIndex)
        
        switch (getIndex) {
        case 0:
            status = "Новая"
        case 1:
            status = "В процессе"
        case 2:
            status = "Выполнена"
        default:
            print("didn't select any")
        }
    }
    
}
extension EditViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTitle()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
}
