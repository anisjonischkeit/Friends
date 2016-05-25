//
//  Friend.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import Foundation

class Friend {
    var firstName: String
    var lastName: String
    var address: String
    var facebook: String
    var flikr: String
    var website: String
    var photoUrl: String
    var photoData: NSData?
    
    init(firstName: String, lastName: String, address: String, facebook: String, flikr: String, website: String, photoUrl: String){ //initialising variables
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.facebook = facebook
        self.flikr = flikr
        self.website = website
        self.photoUrl = photoUrl
    }
    
    func fullName() -> String {
        return firstName + " " + lastName;
    }
    
    
}