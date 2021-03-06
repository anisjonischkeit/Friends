//
//  FriendExtension.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//
import Foundation

//declaring Constants incase things change in our Friend class
let firstNameKey = "firstName"
let lastNameKey = "lastName"
let addressKey = "address"
let flikrKey = "flikr"
let websiteKey = "website"
let photoUrlKey = "photoUrl"

//Extension of Friend Class, used to save to file and unload from file
extension Friend {
    
    // converts Friend object to NSDictionary Object
    func propertyListRepresentation() -> NSDictionary {
        let propertyList: NSDictionary = [ firstNameKey : firstName , lastNameKey : lastName , addressKey : address, flikrKey : flikr, websiteKey : website, photoUrlKey : photoUrl ]
        return propertyList
    }
    
    // converts NSDictionary object to Friend Object
    convenience init (propertyList: NSDictionary) {
        self.init(firstName: "", lastName: "", address: "", flikr: "", website: "", photoUrl: "")
        self.firstName = (propertyList.objectForKey(firstNameKey) as! NSString) as String
        self.lastName = (propertyList.objectForKey(lastNameKey) as! NSString) as String
        self.address = (propertyList.objectForKey(addressKey) as! NSString) as String
        self.flikr = (propertyList.objectForKey(flikrKey) as! NSString) as String
        self.website = (propertyList.objectForKey(websiteKey) as! NSString) as String
        self.photoUrl = (propertyList.objectForKey(photoUrlKey) as! NSString) as String
    }
    
    
    
}