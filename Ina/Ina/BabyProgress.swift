//
//  BabyProgress.swift
//  Ina
//
//  Created by Zachary Skemp on 6/6/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//


import UIKit

class BabyProgress: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let preferences = UserDefaults.standard
        
        let dueDateKey = "DueDate"
        
        if preferences.object(forKey: dueDateKey) == nil {
            //  Doesn't exist
        } else {
            let dateString = preferences.string(forKey: dueDateKey)
            
            //Today's Date
            let date = Date()
            
            //Due Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            let dueDate = dateFormatter.date(from: dateString!)
            
            print(date)
            print(dueDate ?? "Default fail?")
            
            let calendar = Calendar.current
            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: date)
            let date2 = calendar.startOfDay(for: dueDate!)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            let dateDifference = String(describing: components.day!)
            dateLabel.text = dateDifference
            //Here is the difference between the dateDifference
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
