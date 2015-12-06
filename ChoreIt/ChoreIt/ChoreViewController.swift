//
//  MyChoreViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import UIKit

class ChoreViewController: UIViewController {
    
    var thisChore: Chore?
    var indexInList: Int?
    var thisUserName: String!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var choreLabel: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var finishedButton: UIButton!
        
    @IBAction func debugging(sender: AnyObject) {
        print(thisChore)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //thisChore = Chore(choreName: "Eat", username: "Helena")
        self.reloadView()
    }
    
    func reloadView() {
        if thisChore != nil {
            if thisChore!.person!.username == thisUserName {
                nameLabel.text = thisUserName + " (you)"
            } else {
                nameLabel.text = thisChore!.person!.username
            }
            choreLabel.text = thisChore!.choreName
            if thisChore!.finished {
                finishedButton.setTitle("Finished!", forState: .Normal)
            } else {
                finishedButton.setTitle("Working on it...", forState: .Normal)
            }
        } else {
            nameLabel.text = thisUserName + " (you)"
            choreLabel.text = "No chores! 🎉"
            finishedButton.setTitle("", forState: .Normal)
        }
    }
    
    @IBAction func clickedFinished() {
        if thisChore == nil {
            return
        }
        if thisChore!.finished {
            finishedButton.setTitle("Working on it...", forState: .Normal)
            thisChore!.finished = false
        } else {
            finishedButton.setTitle("Finished!", forState: .Normal)
            thisChore!.finished = true
        }
        print("clickedFinished: ", thisChore!.finished)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedBack() {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "unwindBackToTable") {
            let dest = segue.destinationViewController as! ChoreListTableViewController
            dest.choresList[indexInList!] = thisChore!
            print("prepareForSegue: ", thisChore!.finished)
        }
    }


}

