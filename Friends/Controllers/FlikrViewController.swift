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
    var photoId : Int = 0 // current photo id
    var photos : [UIImage] = [] // array of photos from the flikr feed
    var flikrPhotos : Array<FlickrPhoto>? // array of objects with the class FlikrPhoto (used to get to the actual photo and to get the title)
    var hasDeleteButton : Bool = true // lets us control whether we need a delete button (we don't need one when we first set up the account as you can still go back and change it
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the flickr api key and sees if it should add a delete button, then loads all photos
        FlickrAPIKey = "9c120b956e1a26d750e7dbaf9a33ad2d"
        navigationItem.title = "\(friend.flikr)'s Flickr"
        if hasDeleteButton {
            let trashButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "removeFlikrAccount:")
            trashButton.tintColor = .redColor()
            self.navigationItem.rightBarButtonItem = trashButton
        }
        loadAllPhotos()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when delete button is pressed, removes the friend's flikr username and pops back to the detail view controller
    func removeFlikrAccount(sender: AnyObject) {
        friend.flikr = ""
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //loads the FlickrPhoto objects into an array and then downloads the actual uiimages into a seperate array. I decided to download the high resolution photos without thumbnails as this way a user can never open a photo that hasn't yet been completely downloaded
    func loadAllPhotos() {
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        dispatch_async(queue, {
            //Loads all flikr photo data into the flikrPhoto array
            self.flikrPhotos = photosForUser(self.friend.flikr)
            
            // Downloads all image files into an array
            if self.flikrPhotos != nil {
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
            }
        })
        
    }
    
    // gets the next image that should be displayed in the imageviewcontroller and sends it to the imageviewcontroller's photo variable
    func getNextImage (dvc : ImageViewController, nextItem : Bool ) {
        if nextItem { //if we want the next item in the array
            if photos.count > photoId + 1 {
                photoId += 1
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }
        } else { //if we want the previous item in the array
            if photoId > 0 {
                photoId -= 1
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }
            
        }
        dvc.photo = photos[photoId]
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of items
        return photos.count
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

    // MARK: UICollectionViewDelegate
    
    //select currentPhoto on showDetail seque
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row < photos.count {
            photoId = indexPath.row //saves index of current photo (for deleting purposes)
            performSegueWithIdentifier("showImage", sender: self)
            
        }
        return true
    }
    
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            if let dvc = segue.destinationViewController as? ImageViewController{
                dvc.delegate = self
                dvc.photo = photos[photoId]
                dvc.navTitle = flikrPhotos![photoId].title
            }
        }
    }
    
    
}






























