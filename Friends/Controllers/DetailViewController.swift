//
//  ViewController.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fnText: UITextField!
    @IBOutlet weak var lnText: UITextField!
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var webText: UILabel!
    @IBOutlet weak var flikrText: UILabel!
    
    @IBOutlet weak var pictureText: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var friend : Friend!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        addressCell.textLabel?.text = detailItem.address
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // set the title of the view
        if(friend.fullName().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "") {
            navigationItem.title = "New Friend"
        } else {
            navigationItem.title = friend.fullName()
        }
        
        // set the fields of the detail view
        fnText.text = friend.firstName
        lnText.text = friend.lastName
        addressText.text = friend.address
        flikrText.text = friend.flikr
        webText.text = friend.website
        pictureText.text = friend.photoUrl
        if friend.photoData != nil{
            image.image = UIImage(data: friend.photoData!)
        }
        
//        reloads table data
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loadImage()
        friend.firstName = fnText.text!
        friend.lastName = lnText.text!
        if(friend.fullName().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "") {
            navigationItem.title = "New Friend"
        } else {
            navigationItem.title = friend.fullName()
        }
        return true
    }
    
    //loads the image in the background so as to not disturb the user interface
    func loadImage() {
        let urlName = pictureText.text!
        if urlName == "" {
            friend.photoData = nil
            image.image = nil
        } else {
            
            if let url = NSURL(string: urlName) {
                let queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
            
                dispatch_async(queue2, {
                    if let data = NSData(contentsOfURL: url),
                        let image = UIImage(data: data) {
                        
                        let mainQueue2 = dispatch_get_main_queue()
                        dispatch_async(mainQueue2, {
                            self.image.image = image
                            self.friend.photoData = data
                        
                        })
                    }
                })
            }
        }
        
    }
    
    // saves fields that could have been changed in this view and loads image.
    override func viewWillDisappear(animated: Bool) {
        friend.firstName = fnText.text!
        friend.lastName = lnText.text!
        friend.photoUrl = pictureText.text!
        loadImage()
        
        // set title for when going to the next view
        if(friend.fullName().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "") {
            navigationItem.title = "New Friend"
        } else {
            navigationItem.title = friend.fullName()
        }
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the friend to the new view controller.
        
        if segue.identifier == "showMap" {
            if let dvc = segue.destinationViewController as? MapViewController
            {
                dvc.friend = friend
            }
        } else if segue.identifier == "showWebsite" {
            if let dvc = segue.destinationViewController as? WebViewController
            {
                dvc.friend = friend
            }
        } else if segue.identifier == "showFlikr" {
            if let dvc = segue.destinationViewController as? FlikrViewController
            {
                dvc.friend = friend
            }
        } else if segue.identifier == "showLogin" {
            if let dvc = segue.destinationViewController as? LoginViewController
            {
                dvc.friend = friend
            }
        }
        
    }
    
    // if the user hasn't set a flikr username then perform then go to the showLogin view (view that is used to add a new flikr account)
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let ident = identifier {
            if ident == "showFlikr" {
                if friend.flikr == "" {
                    performSegueWithIdentifier("showLogin", sender: self)
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
    
    
}

