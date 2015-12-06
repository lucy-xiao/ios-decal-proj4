//
//  PickerViewDelegateAndSource.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/6/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class PickerViewDelegateAndSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var users: [User?]!
    var designeeName: String?
    
    init(allUsers: [User?]!) {
        self.users = allUsers
        print("users: ", users)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if users == nil {
            return 0
        } else {
            return users!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if users == nil {
            print("why the fuck is users nil?")
            return ""
        } else {
            print("titleForRow: ", users[row]!.username)
            return users[row]!.username
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if users != nil {
            designeeName = users[row]!.username
        }
    }
}
