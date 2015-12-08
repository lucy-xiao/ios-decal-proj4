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
    // RENAME QQ "choreOwner"
    var thisUser: User!
    var choreListTable: ChoreListTableViewController!
    
    
    @IBOutlet var thisChoreLabel: UILabel!
    @IBOutlet var thisNameLabel: UILabel!
    @IBOutlet var thisFinishedButton: UIButton!

    
    
//    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var choreLabel: UILabel!
//    @IBOutlet var dueDateLabel: UILabel!
//    @IBOutlet var finishedButton: UIButton!
    
    @IBAction func debugging(sender: AnyObject) {
        print(thisChore)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.reloadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //thisChore = Chore(choreName: "Eat", username: "Helena")
        self.reloadView()
    }
    
    func reloadView() {
        if thisChore != nil {
            print("reloading detail view")
            print("thisChore!.person", thisChore!.person)
            print("thisChore!.choreName", thisChore!.choreName)
//            print(thisChoreLabel)
            if thisChore!.person!.username == thisUser.username {
                print("They are equivalent?")
                print(thisChore!.person!.username)
                thisNameLabel.text = thisUser.username + " (you)"
            } else {
                print("They are NOT equivalent")
//                print(choreLabel)
//                print(nameLabel)
//                print(thisNameLabel.text)
                print(thisChore!.person)
                print(thisChore!.person!.username)
                self.thisNameLabel.text = thisChore!.person!.username
            }
            thisChoreLabel.text = thisChore!.choreName
            if thisChore!.finished {
                thisFinishedButton.setTitle("Finished!", forState: .Normal)
            } else {
                thisFinishedButton.setTitle("Working on it...", forState: .Normal)
            }
        } else {
            thisNameLabel.text = thisUser.username
            thisChoreLabel.text = "No chores! 🎉"
            thisFinishedButton.setTitle("", forState: .Normal)
        }
    }
    
    @IBAction func clickedFinished() {
        if thisChore == nil {
            return
        }
        if thisChore!.finished {
//            print(thisChore!.finished)
            thisChore!.finished = false
            thisUser.finishedChore = false
        } else {
//             print(thisChore!.finished)
            thisChore!.finished = true
            thisUser.finishedChore = true
        }
        let cellPath = NSIndexPath(forRow: thisChore!.indexRow, inSection: 0)
        let cell = choreListTable.tableView.cellForRowAtIndexPath(cellPath)
        print(cell)
        print(thisChore!.indexRow)
        choreListTable.checkOffFinishedChores(cell!, indexRow: thisChore!.indexRow)
        
        //choreListTable.choresList
        //choreListTable.tableView.reloadData()
        //for cell in choreListTable.tableView.
        self.reloadView()
        print("clickedFinished: ", thisChore!.finished)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "unwindBackToTable") {
            let dest = segue.destinationViewController as! ChoreListTableViewController
            if (thisChore != nil) {
                dest.choresList[indexInList!] = thisChore!
                dest.users[thisUser.userIndexRow] = thisUser
                print("prepareForSegue: ", thisChore!.finished)
            }
        }
    }


}

