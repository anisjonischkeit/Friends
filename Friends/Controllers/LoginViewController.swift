//
//  LoginViewController.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var flikrText: UITextField!
    
    var friend : Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets title of the view
        navigationItem.title = "Flickr Setup"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    sets the flikr property of the current friend to whatever is in the textfield
    override func viewWillDisappear(animated: Bool) {
        friend.flikr = flikrText.text!
    }
    
//    segues to the flikrviewcontroller when the enter key is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        performSegueWithIdentifier("showFlikr", sender: self)
        return true
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFlikr" {
            if let dvc = segue.destinationViewController as? FlikrViewController{
                dvc.friend = friend
                dvc.hasDeleteButton = false // sets the hasDeleteButton variable to false as we will come back through this view so a user can still change the flikr username
            }
        }
    }
 

}
