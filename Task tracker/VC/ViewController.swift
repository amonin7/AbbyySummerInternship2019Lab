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
        dateFormater.locale = locale
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .short
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.taskName
        cell.detailTextLabel?.text = "Due " + dateFormater.string(from: task.taskDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskList.remove(at: indexPath.row)
            UserDefaults.saveListToUD(list: taskList)
            mainTableView.reloadData()
        }
    }
    
}

