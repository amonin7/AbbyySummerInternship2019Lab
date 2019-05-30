//
//  AddTaskViewController.swift
//  Task tracker
//
//  Created by Andrey Minin on 29/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit
import UserNotifications

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    var task = Task(name: "", date: Date(), descr: "", stat: "")

    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var noteText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        setup()
        // Do any additional setup after loading the view.
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
        
        task = Task(name: name!, date: time, descr: note ?? "", stat: "online")
        taskList.append(task)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension AddTaskViewController {
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
extension AddTaskViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as AnyObject? {
            let name = titleText.text
            var time = timePicker.date
            let note = noteText.text
            
            let timeinterval = floor(time.timeIntervalSinceReferenceDate / 60) * 60
            time = Date(timeIntervalSinceReferenceDate: timeinterval)
            
            task = Task(name: name!, date: time, descr: note ?? "", stat: "online")
        }
    }
    
    
}
