//
//  User.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import UIKit
import Foundation

struct User {
    var username: String?
    
    init(username: String?) {
        self.username = username
    }
    
    init() {
        self.username = ""
    }
}
