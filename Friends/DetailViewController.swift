//
//  ViewController.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func detailViewDidChange()
}

class DetailViewController: UITableViewController, UITextFieldDelegate, WebViewControllerDelegate, MapViewControllerDelegate {
    
    @IBOutlet weak var fnText: UITextField!
    @IBOutlet weak var lnText: UITextField!
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var webText: UILabel!
    @IBOutlet weak var flikrText: UILabel!
    
    @IBOutlet weak var pictureText: UITextField!
    @IBOutlet weak var image: UIImageView!
    
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
        
        flikrText.text = friend.flikr
        webText.text = friend.website
        
        pictureText.text = friend.photoUrl
        if friend.photoData != nil{
            image.image = UIImage(data: friend.photoData!)
        }
    
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save(friend : Friend) {
        //        friend = self.friend
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loadImage()
        self.delegate.detailViewDidChange()
        return true
    }
    
    func loadImage() {
        let urlName = pictureText.text!
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
    
    override func viewWillDisappear(animated: Bool) {
        friend.firstName = fnText.text!
        friend.lastName = lnText.text!
        friend.photoUrl = pictureText.text!
        loadImage()
        self.delegate.detailViewDidChange()
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showMap" {
            if let dvc = segue.destinationViewController as? MapViewController
            {
                dvc.delegate = self
                dvc.friend = friend
            }
        } else if segue.identifier == "showWebsite" {
            if let dvc = segue.destinationViewController as? WebViewController
            {
                dvc.delegate = self
                dvc.friend = friend
            }
        }
        
    }
    
    
}

