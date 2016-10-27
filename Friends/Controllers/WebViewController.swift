//
//  WebViewController.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

protocol WebViewControllerDelegate {
//    func save(friend : Friend)
}

class WebViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchField: UITextField!
    
    var delegate : WebViewControllerDelegate!
    var friend : Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // sets the view's title and textfield and goes to the webaddress (if one exists)
        navigationItem.title = "Website"
        searchField.text! = friend.website
        loadToWebView(friend.website)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when enter is pressed, load the loadToWebView function
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let url = searchField.text!
        loadToWebView(url)
        
        
        textField.resignFirstResponder()
        return true
    }
    
    // if url can be accessed, return the NSURL. If it can't be accessed, add http:// to the url and see if it can be accessed again. If it still can't be accessed, return nil
    func urlTest (urlStr: String, firstTry: Bool = true) -> NSURL? {
        var returner: NSURL? = nil
        if let url = NSURL(string: urlStr) {
            if UIApplication.sharedApplication().canOpenURL(url) == false {
                if firstTry == true {
                    returner = urlTest("http://" + urlStr, firstTry: false)
                }
            } else {
                print("[ Loading Webpage ]")
                return url
                
            }
        }
        return returner
    }
    
    //When WebView is loaded set textfield to whatever the current url is
    func webViewDidFinishLoad(webView: UIWebView) {
        let currentURL : String = (webView.request?.URL!.absoluteString)!
        searchField.text! = currentURL
        print("[ Done Loading Webpage ]")
    }
    
    //load image into webview
    func loadToWebView(urlStr: String) {
        
        let url = urlTest(urlStr) //tests if url can be loaded, if not adds http and tries once more
        // if url could be loaded
        if url !== nil {
            let urlRequest = NSURLRequest(URL: url!)
            webView.loadRequest(urlRequest)
        }
        
        
    }
    
    // sets the current friend's website property to whatever is in the searchfield
    override func viewWillDisappear(animated: Bool) {
        friend.website = searchField.text!
    }
    
}

