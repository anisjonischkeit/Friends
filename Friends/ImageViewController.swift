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
    
    @IBAction func leftSwipe(sender: AnyObject) {
        delegate.getNextImage(self, nextItem: true)
        navigationItem.title = navTitle
        fsImage.image = photo
    }
    
    @IBAction func rightSwipe(sender: AnyObject) {
        delegate.getNextImage(self, nextItem: false)
        navigationItem.title = navTitle
        fsImage.image = photo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        fsImage.image = photo
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
