//
//  ViewController.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    
}

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var fnText: UITextField!
    @IBOutlet weak var lnText: UITextField!
    @IBOutlet weak var addressText: UILabel!
    
    var delegate : DetailViewControllerDelegate!
    var friend : Friend!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        addressCell.textLabel?.text = detailItem.address
        
    }
    
    override func viewWillAppear(animated: Bool) {
        fnText.text = friend.firstName
        lnText.text = friend.lastName
        addressText.text = friend.address
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showMap" {
            if let dvc = segue.destinationViewController as? MapViewController
            {
//                dvc.delegate = self
                dvc.friend = friend
            }
        }
        
    }

}

