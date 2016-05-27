//
//  FlikrViewController.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//



import UIKit

class FlikrViewController: UICollectionViewController, imageViewControllerDelegate {
    
    let reuseIdentifier = "Cell"
    var friend : Friend!
    var photoId : Int = 0
    var photos : [UIImage] = []
    var flikrPhotos : Array<FlickrPhoto>?
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FlickrAPIKey = "9c120b956e1a26d750e7dbaf9a33ad2d"
        navigationItem.title = "\(friend.firstName)'s Flickr"
        loadAllPhotos()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if flikrPhotos != nil {
            return photos.count
        } else {
            return 0
        }
    }

    // make a cell for each cell index path
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.cellImage.image = nil // resets reuse identifier
        cell.cellImage.image = photos[indexPath.row]

        collectionView.reloadItemsAtIndexPaths([indexPath])
        return cell
    }

    
    func getNextImage (dvc : ImageViewController, nextItem : Bool ) {
        if nextItem {
            if photos.count > photoId + 1 {
                photoId += 1
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }
        } else {
            if photoId > 0 {
                photoId -= 1
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }

        }
        dvc.photo = photos[photoId]
        
    }

    // MARK: UICollectionViewDelegate
    
    //select currentPhoto on showDetail seque
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row < photos.count {
//          photo = photos[indexPath.row]
            photoId = indexPath.row //saves index of current photo (for deleting purposes)
            print(photoId)
            performSegueWithIdentifier("showImage", sender: self)
            
        }
        return true
    }
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            if let dvc = segue.destinationViewController as? ImageViewController{
                dvc.delegate = self
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }
        }
    }
    
    func loadAllPhotos() {
        
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        
        dispatch_async(queue, {
            //Loads all flikr photo data into the flikrPhoto array
            self.flikrPhotos = photosForUser(self.friend.flikr)
            
            // Downloads all image files into an array
            for photo in self.flikrPhotos!{
                let urlName = urlString(photo, format: .Big)
                if let url = NSURL(string: urlName!) {
                    if let data = NSData(contentsOfURL: url),
                        let image = UIImage(data: data) {
                        let mainQueue = dispatch_get_main_queue()
                        dispatch_async(mainQueue, {
                            self.photos.append(image)
                            self.collectionView?.reloadData()
                        })
                    }
                }
            }
        })
        
    }
}






























