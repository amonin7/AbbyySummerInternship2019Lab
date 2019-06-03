//
//  TodayViewController.swift
//  extension
//
//  Created by Andrey Minin on 03/06/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let name = UserDefaults.init(suiteName: "group.com.andreyminin.taskTracker")?.value(forKey: "name") {
            mainLabel.text = name as? String
        }
    }
    
    @IBOutlet weak var mainLabel: UILabel!
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
