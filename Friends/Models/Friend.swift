//
//  Friend.swift
//  Friends
//
//  Created by Anis on 24/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import Foundation

class Friend {
//    Variables for a Friend object
    var firstName: String
    var lastName: String
    var address: String
    var flikr: String
    var website: String
    var photoUrl: String
    var photoData: NSData?
    
//    Initialiser for a Friend object
    init(firstName: String, lastName: String, address: String, flikr: String, website: String, photoUrl: String){ //initialising variables
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.flikr = flikr
        self.website = website
        self.photoUrl = photoUrl
    }
//    Function that returns the full name of a Friend
    func fullName() -> String {
        return firstName + " " + lastName;
    }
    
    
}