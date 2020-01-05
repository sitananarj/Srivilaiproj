//
//  WebViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 19/12/2562 BE.
//  Copyright © 2562 siwa. All rights reserved.
//

import UIKit
class WebViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    var url = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  urlreq = URLRequest(url: url!)
        webView.loadRequest(urlreq)

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
