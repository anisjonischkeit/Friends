//
//  DetailViewController.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
let fileName = documentsDirectory.stringByAppendingPathComponent("photos.plist")

class MasterViewController: UITableViewController {

    var friendList = FriendList()
    var friend : Friend!
    var firstLoad : Bool = true
    
    override func viewWillAppear(animated: Bool) {
        
        //makes sure it only gets triggered when the app is loading not when coming back to the master view from the detail view
        if firstLoad == true {
            firstLoad = false
            
            //checks if there is a photo.plist file in the app's document directory and if so it loads in the NSDictionary from the files into the PhotoList array using the PhotoExtension
            if (NSFileManager.defaultManager().fileExistsAtPath(fileName)) {
                let fileContent = NSArray(contentsOfFile: fileName) as! Array<NSDictionary>
                friendList.entries = fileContent.map { Friend(propertyList: $0) }
            }
            
            //Loads images for Photos added from the .PLIST
            for currentFriend in friendList.entries {
                currentFriend.photoData = loadImage(currentFriend.photoUrl)
            }
        }
        
        self.tableView.reloadData()
        saveToFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editObject:")
        self.navigationItem.leftBarButtonItem = editButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        friend = Friend(firstName: "", lastName: "", address: "", facebook: "", flikr: "", website: "", photoUrl: "")
        friendList.entries.append(friend)
//        self.tableView.reloadData()
        performSegueWithIdentifier("showDetail", sender: self)
    }

    func editObject(sender: AnyObject) {
        
    }
    
    func loadImage(urlName : String) -> NSData? {
        var imgData: NSData? = nil
        if let url = NSURL(string: urlName) {
            
            if let data = NSData(contentsOfURL: url),
                let _ = UIImage(data: data) {
                imgData = data
            }
        }
        return imgData
    }
    
    func saveToFile() {
        let propertyList: NSArray = friendList.entries.map{ $0.propertyListRepresentation() }
        propertyList.writeToFile(fileName, atomically: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendList.entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

//         Configure the cell...
        
        let object:Friend = friendList.entries[indexPath.row]
        cell.textLabel!.text = "\(object.fullName())"
        if object.photoData != nil,
            let image = UIImage(data: object.photoData!){
            cell.imageView?.image = image
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            if let dvc = segue.destinationViewController as? DetailViewController
            {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    friend = friendList.entries[indexPath.row]// as ContactListEntry //selects the selected contact
                }
//                dvc.delegate = self
                dvc.friend = friend
            }
        }
        
    }
 

}
