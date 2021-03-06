//
//  DetailViewController.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit

// location of the persistance plist file
let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
let fileName = documentsDirectory.stringByAppendingPathComponent("friends.plist")

class MasterViewController: UITableViewController {

    var friendList = FriendList()
    var friend : Friend!
    var firstLoad : Bool = true
    
    override func viewWillAppear(animated: Bool) {
        
        for (i, element) in friendList.entries.enumerate() { //loops through all contacts with i as the index and element as the array item
            if(element.fullName().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "") && (element.photoData == nil || element.photoUrl == "") {// checks if first or last name have been entered or if a photo has been added
                friendList.entries.removeAtIndex(i) //if not, the item is removed (used to remove invalid contacts)
            }
        }
        
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
        
        //adds add and edit button
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    inserts a new blank Friend into the friendlist array and segues to the detail view
    func insertNewObject(sender: AnyObject) {
        friend = Friend(firstName: "", lastName: "", address: "", flikr: "", website: "", photoUrl: "")
        friendList.entries.append(friend)
        performSegueWithIdentifier("showDetail", sender: self)
    }

    // loads images before the app runs
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
    
    // saves friendlist array to a plist file
    func saveToFile() {
        let propertyList: NSArray = friendList.entries.map{ $0.propertyListRepresentation() }
        propertyList.writeToFile(fileName, atomically: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return friendList.entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

//         Configure the cell
        let object:Friend = friendList.entries[indexPath.row]
        cell.textLabel!.text = "\(object.fullName())"
        if object.photoData != nil,
            let image = UIImage(data: object.photoData!){
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = nil
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
            friendList.entries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveToFile()
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            if let dvc = segue.destinationViewController as? DetailViewController
            {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    friend = friendList.entries[indexPath.row]// as ContactListEntry //selects the selected contact
                }
                dvc.friend = friend
            }
        }
        
    }
 

}
