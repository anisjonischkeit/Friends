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

class DetailViewController: UIViewController {
    
    @IBOutlet weak var fnText: UITextField!
    @IBOutlet weak var lnText: UITextField!
    
    var delegate : DetailViewControllerDelegate!
    var friend : Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        addressCell.textLabel?.text = detailItem.address
        fnText.text = friend.firstName
        lnText.text = friend.lastName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

