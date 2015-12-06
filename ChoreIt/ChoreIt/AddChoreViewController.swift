//
//  AddChoreViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import Foundation
import UIKit

class AddChoreViewController: UIViewController {
    var chore: Chore?
    
    @IBOutlet var addChoreTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender !== self.saveButton ) {
            return
        }
        if (addChoreTextField.text!.characters.count > 0 ) {
            chore = Chore(choreName: addChoreTextField.text!)
        }
    }
    
}
