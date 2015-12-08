//
//  User.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

func == (lhs: User, rhs: User) -> Bool {
    return  lhs.username == rhs.username
}

import UIKit
import Foundation

//class User: Equatable, Hashable {
struct User {
    var username: String!
    var finishedChore: Bool
    var userIndexRow = 0
    
    init(username: String?) {
        self.username = username
        self.finishedChore = false
    }
    
    init() {
        self.username = ""
        self.finishedChore = false
    }
    
    func equals(other: User!) -> Bool!{
        return self.username! == other.username
    }

    var hashValue: Int {
        get {
            return username!.hashValue << 15
        }
    }
    
}
