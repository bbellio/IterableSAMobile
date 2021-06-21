//
//  User.swift
//  IterableSAChallenge
//
//  Created by Bethany Bellio on 6/19/21.
//

import Foundation

class User {
    
    init(firstName: String, email: String, isRegisteredUser: Bool, key: String) {
        self.firstName = firstName
        self.email = email
        self.isRegisteredUser = isRegisteredUser
        self.key = key
    }
    
    let firstName: String
    let email: String
    let isRegisteredUser: Bool
    let key: String
    
}

let currentUser = User(firstName: "Bethany", email: "bellio.bethany@gmail.com", isRegisteredUser: true, key: "completed")
