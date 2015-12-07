//
//  MyChoreViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import UIKit

class MyChoreViewController: UIViewController {
    
    var thisChore: Chore?
    var indexInList: Int?
    var thisUserName: String!
    var choreListTable: ChoreListTableViewController!
//    var choreListTable = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ChoreListTableViewController") as! ChoreListTableViewController

    @IBOutlet var myChoreLabel: UILabel!
    @IBOutlet var myNameLabel: UILabel!
    @IBOutlet var myFinishedButton: UIButton!
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
    }
    
    func reloadView() {
        if thisChore != nil {
            print("reloading detail view")
            print("thisChore!.person", thisChore!.person)
            if thisChore!.person!.username == thisUserName {
                myNameLabel.text = thisUserName + " (you)"
            } else {
                print(myNameLabel)
                print(myNameLabel.text)
                print(thisChore!.person)
                print(thisChore!.person!.username)
                myNameLabel.text = thisChore!.person!.username
            }
            myChoreLabel.text = thisChore!.choreName
            if thisChore!.finished {
                myFinishedButton.setTitle("Finished!", forState: .Normal)
            } else {
                myFinishedButton.setTitle("Working on it...", forState: .Normal)
            }
        } else {
            myNameLabel.text = thisUserName + " (you)"
            myChoreLabel.text = "No chores! 🎉"
            myFinishedButton.setTitle("", forState: .Normal)
        }
    }
    
    @IBAction func clickedFinished() {
        if thisChore == nil {
            return
        }
        if thisChore!.finished {
            thisChore!.finished = false
        } else {
            thisChore!.finished = true
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

