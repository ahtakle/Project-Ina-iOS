//
//  SplashScreenController.swift
//  Ina
//
//  Created by Zachary Skemp on 6/6/17.
//  Copyright © 2017 ProjectIna. All rights reserved
//
//
// NOTE: THIS SHOULD LOOK THE SAME AS THE LaunchScreenStoryboard BUT JUST HAS THE LOGIC :)
//

import UIKit

class SplashScreenController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        
        let dueDateKey = "DueDate"
        let birthdayKey = "Birthday"

        if (preferences.object(forKey: dueDateKey) == nil && preferences.object(forKey: birthdayKey) == nil) {
            //  Doesn't exist
            performSegue(withIdentifier: "DatePickerSegue", sender: self)
        } else {
            performSegue(withIdentifier: "HomeSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            _ = segue.destination as? ViewController
        }
        if segue.identifier == "DatePickerSegue" {
            _ = segue.destination as? DatePickerController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
