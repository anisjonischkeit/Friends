//
//  FriendsTests.swift
//  FriendsTests
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import XCTest
@testable import Friends

class FriendsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Constants Declarations
    let firstName = "Example first"
    let lastName = "Example last"
    let address = "Example address"
    let flikr = "Example flikr"
    let website = "www.google.com"
    let photoUrl = "https://ias.griffith.edu.au/griffith/skin/images/griffith-logo-landscape.gif"
    
    //tests that all properties are propperly initialised
    func testFriendInitialisers() {
        let friend1 = Friend(firstName: firstName, lastName: lastName, address: address, flikr: flikr, website: website, photoUrl: photoUrl)
        XCTAssertEqual(friend1.firstName, firstName)
        XCTAssertEqual(friend1.lastName, lastName)
        XCTAssertEqual(friend1.address, address)
        XCTAssertEqual(friend1.flikr, flikr)
        XCTAssertEqual(friend1.website, website)
        XCTAssertEqual(friend1.photoUrl, photoUrl)
    }
    
    func testPhotoDataProperty() {
        let friend1 = Friend(firstName: firstName, lastName: lastName, address: address, flikr: flikr, website: website, photoUrl: photoUrl)
        var imgData : NSData?
        if let url = NSURL(string: photoUrl) {
            
            if let data = NSData(contentsOfURL: url),
                let _ = UIImage(data: data) {
                imgData = data
                friend1.photoData = data
            } else {
                XCTFail("Image could not be loaded, check your internet connection and that the image still exists")
            }
        } else {
            XCTFail("not a valid URL")
        }
        XCTAssertEqual(friend1.photoData, imgData)
        friend1.photoData = nil
        imgData = nil
        XCTAssertEqual(friend1.photoData, imgData)
        
    }
    
    //tests that the Friend class can return the fullname of a Friend
    func testFullName() {
        let friend1 = Friend(firstName: firstName, lastName: lastName, address: "", flikr: "", website: "", photoUrl: "")
        XCTAssertEqual(friend1.fullName(), firstName + " " + lastName)
    }
    
    //tests the save and load extension
    func testSaveAndOnload() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("friends.plist")
        
        let friendList = FriendList()
        
        //creates to Photo objects
        let friend1 = Friend(firstName: firstName, lastName: lastName, address: address, flikr: flikr, website: website, photoUrl: photoUrl)
        let friend2 = Friend(firstName: "First Name 2", lastName: "Last Name 2", address: "Address 2", flikr: "Flikr 2", website: "wwww.yahoo.com", photoUrl: photoUrl)
        
        //creates to friendList entries
        friendList.entries.append(friend1)
        friendList.entries.append(friend2)
        
        //writes friendList array to file
        var propertyList: NSArray = friendList.entries.map{ $0.propertyListRepresentation() }
        propertyList.writeToFile(fileName, atomically: true)
        
        //loads array from the PLIST into the new friendlistw Array to compare to the first friendlist array
        let friendList2 = FriendList()
        let fileContent = NSArray(contentsOfFile: fileName) as! Array<NSDictionary>
        friendList2.entries = fileContent.map { Friend(propertyList: $0) }
        
        //compares together the first item of the friendGallary Arrays
        XCTAssertEqual(friendList2.entries[0].firstName, friendList.entries[0].firstName)
        XCTAssertEqual(friendList2.entries[0].lastName, friendList.entries[0].lastName)
        XCTAssertEqual(friendList2.entries[0].address, friendList.entries[0].address)
        XCTAssertEqual(friendList2.entries[0].flikr, friendList.entries[0].flikr)
        XCTAssertEqual(friendList2.entries[0].website, friendList.entries[0].website)
        XCTAssertEqual(friendList2.entries[0].photoUrl, friendList.entries[0].photoUrl)
        
        //compares together the second items of the friendGallary Arrays
        XCTAssertEqual(friendList2.entries[1].firstName, friendList.entries[1].firstName)
        XCTAssertEqual(friendList2.entries[1].lastName, friendList.entries[1].lastName)
        XCTAssertEqual(friendList2.entries[1].address, friendList.entries[1].address)
        XCTAssertEqual(friendList2.entries[1].flikr, friendList.entries[1].flikr)
        XCTAssertEqual(friendList2.entries[1].website, friendList.entries[1].website)
        XCTAssertEqual(friendList2.entries[1].photoUrl, friendList.entries[1].photoUrl)
        
        //delete all items from PLIST file
        friendList.entries.removeAll(keepCapacity: false)
        propertyList = friendList.entries.map{ $0.propertyListRepresentation() }
        propertyList.writeToFile(fileName, atomically: true)
    }

    
    
    
}
