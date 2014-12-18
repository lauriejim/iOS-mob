//
//  ConnectionViewController.swift
//  ios-mob
//
//  Created by Kévin Chassagne on 18/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

import UIKit

class ConnectionViewController: SlackRequestController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    func webViewDidFinishLoad(_webView: UIWebView!) {
        var url = _webView.request?.URL.absoluteString as String!
        var uri = url.componentsSeparatedByString("code=") as Array
        if uri.count == 2 {
            var code = uri[1].componentsSeparatedByString("&")[0]
            self.getToken(code)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "https://slack.com/oauth/authorize?client_id=3221071404.3240178857")
        let request = NSURLRequest(URL: url!)
        webView.delegate = self
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}