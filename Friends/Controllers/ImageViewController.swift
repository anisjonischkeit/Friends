//
//  ImageViewController.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

protocol imageViewControllerDelegate {
    func getNextImage (dvc : ImageViewController, nextItem : Bool)
}

class ImageViewController: UIViewController {

    @IBOutlet weak var fsImage: UIImageView!
    
    var delegate : imageViewControllerDelegate!
    var navTitle : String = ""
    var photo : UIImage!
    var photoCount: Int = 0
    
    // gets next image from flikr view controller, re sets title and image
    @IBAction func leftSwipe(sender: AnyObject) {
        delegate.getNextImage(self, nextItem: true)
        navigationItem.title = navTitle
        fsImage.image = photo
    }
    
    // gets previous image from flikr view controller, re sets title and image
    @IBAction func rightSwipe(sender: AnyObject) {
        delegate.getNextImage(self, nextItem: false)
        navigationItem.title = navTitle
        fsImage.image = photo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets title and image to display
        navigationItem.title = navTitle
        fsImage.image = photo
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
