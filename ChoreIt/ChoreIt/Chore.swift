//
//  Chore.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

struct Chore {
    var choreName: String?
    var person: User!
    var finished: Bool
    var timeCompleted: NSDate?
    
    init(choreName: String?) {
        self.choreName = choreName
        self.finished  = false
        self.person = User(username: "You")
    }
    
    init(choreName: String?, username: String?) {
        self.choreName = choreName
        self.finished  = false
        self.person = User(username: username)
    }
    
    
}
