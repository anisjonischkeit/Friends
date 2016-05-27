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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FlickrAPIKey = "9c120b956e1a26d750e7dbaf9a33ad2d"
        flikrPhotos = photosForUser(friend.flikr)
        
        /*
            for photo in flikrPhotos {
                guard let photoURLString = urlString(photo),
                url = NSURL(string: photoURLString),
                photoData = NSData(contentsOfURL: url),
                image = UIImage(data: photoData) else {
                    print("could not load photo for \(friend.flikr)")
                    return
                }
                photos.append(image)
                
            }
 */
        

//        if photo != nil {
//            for photo in photos! {
//                photoURLString = urlString(photo),
//                url = NSURL(string: photoURLString),
//                photoData = NSData(contentsOfURL: url),
//                image = UIImage(data: photoData)
//            }
//        }
        
        
//        guard let photos = photosForUser(friend.flikr),
//            photo = photos.first,
//            photoURLString = urlString(photo),
//            url = NSURL(string: photoURLString),
//            photoData = NSData(contentsOfURL: url),
//            image = UIImage(data: photoData) else {
//                print("could not load photo for \(friend.flikr)")
//                return
//        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

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
            return flikrPhotos!.count
        } else {
            return 0
        }
    }

    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.cellImage.image = nil // resets reuse identifier
        
        
//        guard let photoURLString = urlString(flikrPhotos![indexPath.row]),
//            url = NSURL(string: photoURLString),
//            photoData = NSData(contentsOfURL: url),
//            image = UIImage(data: photoData) else {
//                print("could not load photo for \(friend.flikr)")
//                return
//        }
//        photos.append(image)
        
        
        
            let p = flikrPhotos![indexPath.row]
            if let urlStr = urlString(p, format: .Thumbnail) {
                if let url = NSURL(string: urlStr) {
                    if let photoData = NSData(contentsOfURL: url) {
                        if let image = UIImage(data: photoData) {
                            cell.cellImage.image = image
                        }
                    }
                }
            }
        collectionView.reloadItemsAtIndexPaths([indexPath])
        return cell
    }

    
    func getNextImage (dvc : ImageViewController, photoId: Int) {
        dvc.photo = photos[photoId]
    }

    // MARK: UICollectionViewDelegate
    
    //select currentPhoto on showDetail seque
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            //photo = photos[indexPath.row]
            photoId = indexPath.row //saves index of current photo (for deleting purposes)
        print(photoId)
            performSegueWithIdentifier("showImage", sender: self)
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
                dvc.photoCount = photos.count
            }
        }
    }

}
 














/*

import UIKit

//Global Constant Declarations
let reuseIdentifier = "Cell"

class FlikrViewController: UICollectionViewController, imageViewControllerDelegate {
    
    // Variable Declerations
    var friends :
    var currentPhotoId: Int? = nil
    var photos = PhotoList()
    var firstLoad: Bool = true
    
    override func viewWillAppear(animated: Bool) {
        
        //makes sure it only gets triggered when the app is loading not when coming back to the master view from the detail view
        if firstLoad == true {
            firstLoad = false
            
            //checks if there is a photo.plist file in the app's document directory and if so it loads in the NSDictionary from the files into the PhotoList array using the PhotoExtension
            if (NSFileManager.defaultManager().fileExistsAtPath(fileName)) {
                let fileContent = NSArray(contentsOfFile: fileName) as! Array<NSDictionary>
                photos.entries = fileContent.map { Photo(propertyList: $0) }
            }
            
            //Loads images for Photos added from the .PLIST
            for photo in photos.entries {
                photo.image = loadImage(photo.url)
                if photo.image == nil {
                    photo.image = loadImage()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //adds the add button to the MasterViewController nav bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        
    }
    
    //reloads data when view disapears and saves PhotoList Array to file. This is the best place to save to a file as it is whenever any image gets saved/deleted (makes sure that the file gets updated whenever anything in the array changes)
    override func viewDidAppear(animated: Bool) {
        collectionView?.reloadData()
        saveToFile()
    }
    
    //function that creates a blank object photo, inserts the object into the array, remembers the index path and triggues segue
    func insertNewObject(sender: AnyObject) {
        currentPhoto = Photo(title: "", tags: "", url: "")
        photos.entries.append(currentPhoto)
        self.collectionView?.reloadData()
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    //setup before segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" || segue.identifier == "showImage" {
            if let dvc = segue.destinationViewController as? DetailViewController
            {
                dvc.delegate = self
                dvc.detailItem = currentPhoto
            } else if let dvc = segue.destinationViewController as? ImageViewController {
                dvc.delegate = self
                dvc.detailItem = currentPhoto
                dvc.detailItemId = currentPhotoId!
                dvc.detailItemCount = photos.entries.count            }
        }
    }
    
    //updates image when image is loaded
    func detailViewDidChange(photo: Photo) {
        collectionView?.reloadData()
    }
    
    //delegate function to delete a photo
    func deleteItem(detailItemId: Int) {
        photos.entries.removeAtIndex(detailItemId)
        collectionView?.reloadData()
    }
    
    //sets the detailItem for the ImageViewController to the next image in the array that should be loaded by the ImageField. Also sets the variable that is used to monitor the size of the array ( to prevent the app from loading an image in the array that is out of bounds)
    func getNextImage (dvc : ImageViewController, detailItemId: Int) {
        dvc.detailItem = photos.entries[detailItemId]
        dvc.detailItemCount = photos.entries.count
    }
    
    //empty deleteItem delegate function in order to conform with the DetailViewControllerDelegate
    func deleteItem() {
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //Return the number of sections
        return 1
    }
    
    // tell the collection view how many cells to make
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.entries.count
    }
    
    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.cellImage.image = nil // resets reuse identifier
        let p = photos.entries[indexPath.row]
        if (p.image != nil) {
            let pic = UIImage(data: p.image!)
            cell.cellImage.image = pic
        }
        collectionView.reloadItemsAtIndexPaths([indexPath])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    //select currentPhoto on showDetail seque
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        currentPhoto = photos.entries[indexPath.row]
        currentPhotoId = indexPath.row //saves index of current photo (for deleting purposes)
        performSegueWithIdentifier("showImage", sender: self)
        return true
    }
    
    //saves the array to a plist file by converting the PhotoList array to an NSArray and then writing the array to the photos.plist file
    func saveToFile() {
        let propertyList: NSArray = photos.entries.map{ $0.propertyListRepresentation() }
        propertyList.writeToFile(fileName, atomically: true)
    }
    
    //loads an image (if no image is selected to be loaded, it will load a generic image. Only used when the application first loads as the image does not get downloaded in the background and therefore it shouldn't be used other then when the app is first launched)
    func loadImage(photoUrl: String = genericImage) -> NSData? {
        let urlName = photoUrl
        var imgData: NSData? = nil
        if let url = NSURL(string: urlName) {
            
            if let data = NSData(contentsOfURL: url),
                let _ = UIImage(data: data) {
                imgData = data
            }
        }
        return imgData
    }
}





*/
