//
//  CalendarController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/13/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import Foundation
import UIKit

class CalendarController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self
        
        let HTML = "<iframe src='https://calendar.google.com/calendar/embed?src=svttqkqr143jcadd858a3da8u8%40group.calendar.google.com&ctz=America/New_York' style='border: 0' width='375' height='650' frameborder='0' scrolling='no'></iframe>"
        webView.loadHTMLString(HTML, baseURL: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
