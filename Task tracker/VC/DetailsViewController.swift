//
//  DetailsViewController.swift
//  Task tracker
//
//  Created by Andrey Minin on 31/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var taskID = -1
    
    var dateFormater = DateFormatter()

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        dateFormater.locale = NSLocale.current
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .short
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if taskID != -1 {
            setup()
            statusLabel.text = taskList[taskID].status
            taskNameLabel.text = taskList[taskID].taskName
            noteLabel.text = taskList[taskID].taskDescription
            dateLabel.text = dateFormater.string(from: taskList[taskID].taskDate)
        } else {
            statusLabel.text = "task not found"
            taskNameLabel.text = "task not found"
            noteLabel.text = "task not found"
            dateLabel.text = "task not found"
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: taskID)
    }
}
extension DetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let destVC = segue.destination as! UINavigationController
            if let detVC = destVC.topViewController as? EditViewController {
                let taskid = sender as? Int ?? -1
                detVC.taskID = taskid
            }
        }
    }
}
