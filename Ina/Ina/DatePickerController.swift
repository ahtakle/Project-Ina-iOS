//
//  DatePickerController.swift
//  Ina
//
//  Created by Zachary Skemp on 6/6/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    @IBOutlet weak var optionSelector: UISegmentedControl!
   
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func submit(_ sender: Any) {
        let preferences = UserDefaults.standard
        let dueDateKey = "DueDate"
        let birthdayKey = "Birthday"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        if optionSelector.selectedSegmentIndex == 0 {
            _ = preferences.set(dateString, forKey: dueDateKey)
            _ = preferences.set("", forKey: birthdayKey)
            
            //  Save to disk
            preferences.synchronize()
        } else if optionSelector.selectedSegmentIndex == 1 {
            _ = preferences.set("", forKey: dueDateKey)
            _ = preferences.set(dateString, forKey: birthdayKey)
            
            //  Save to disk
            preferences.synchronize()
        }
        
        performSegue(withIdentifier: "HomeSegue", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            _ = segue.destination as? ViewController 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Other view stuff
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
