//
//  CalendarController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/13/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import Foundation
import UIKit

class CalendarController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/zrskemp.gmail.com/events?maxResults=15&key=AIzaSyBmI5kwmgjJWgNIIpYdxNoR3a0gKU5tL2A")
//        
//        webView.loadRequest(URLRequest(url: url!))
//        var HTML = "<iframe src='https://calendar.google.com/calendar/embed?src=" + "svttqkqr143jcadd858a3da8u8%40group.calendar.google.com&ctz=America/New_York' style='border: 0'" + "width='" + 150 + "' height='" + 200 + "' frameborder='0' scrolling='no'></iframe>"
//        webView.loadHTMLString(HTML, baseURL: <#T##URL?#>)

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size.height = 1
        let height = webView.scrollView.contentSize.height
        var wvRect = webView.frame
        wvRect.size.height = height
        webView.frame = wvRect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
