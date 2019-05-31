//
//  ViewController.swift
//  Task tracker
//
//  Created by Andrey Minin on 29/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dateFormater = DateFormatter()
    let locale = NSLocale.current
    
    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.saveListToUD(list: taskList)
        mainTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.saveListToUD(list: taskList)
    }
    
    func setup() {
        dateFormater.locale = NSLocale.current
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .short
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        setup()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        let task = taskList[indexPath.row]
        cell.titileLabel.text = task.taskName
        cell.dateLabel.text = "Due " + dateFormater.string(from: task.taskDate)
        cell.statusLabel.text = task.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskList.remove(at: indexPath.row)
            UserDefaults.saveListToUD(list: taskList)
            mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskDetails", sender: indexPath.row)
    }
}
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetails" {
            let destVC = segue.destination as! UINavigationController
            if let detVC = destVC.topViewController as? DetailsViewController {
                let taskid = sender as? Int ?? -1
                detVC.taskID = taskid
            }
        }
    }
}

