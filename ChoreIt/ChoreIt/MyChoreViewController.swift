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
    var thisUser: User!
    var indexOfUser: Int!
    var choreListTable: ChoreListTableViewController!
    var tabBar: UITabBarController!
    var navForChoreTableView: UINavigationController?
    var tableOfChores: ChoreListTableViewController?

    @IBOutlet var myChoreLabel: UILabel!
    @IBOutlet var myNameLabel: UILabel!
    @IBOutlet var myFinishedButton: UIButton!
    
    @IBAction func debugging(sender: AnyObject) {
        print(thisChore)
    }
    
    override func viewWillAppear(animated: Bool) {
        for chore in choreListTable.choresList {
            if chore.person.username == thisUser.username {
                thisChore = chore
            }
        }
        
        self.reloadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navForChoreTableView = tabBar.customizableViewControllers![1] as? UINavigationController
        tableOfChores = navForChoreTableView!.topViewController as? ChoreListTableViewController
        // Do any additional setup after loading the view, typically from a nib.
        //thisChore = Chore(choreName: "Eat", username: "Helena")
    }
    
    func reloadView() {
        if thisChore != nil {
            print("reloading detail view")
            print("thisChore!.person", thisChore!.person)
            if thisChore!.person!.username == thisUser.username {
                myNameLabel.text = thisUser.username + " (you)"
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
            myNameLabel.text = thisUser.username + " (you)"
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
            thisUser.finishedChore = false
            myFinishedButton.setTitle("Finished!", forState: .Normal)

            
        } else {
            thisChore!.finished = true
            thisUser.finishedChore = true
            myFinishedButton.setTitle("Working on it...", forState: .Normal)
        }
        let cellPath = NSIndexPath(forRow: thisChore!.indexRow, inSection: 0)
        let cell = choreListTable.tableView.cellForRowAtIndexPath(cellPath)
        print(cell)
        print(thisChore!.indexRow)
        choreListTable.checkOffFinishedChores(cell!, indexRow: thisChore!.indexRow)
        
        self.reloadView()
        print("clickedFinished: ", thisChore!.finished)
        
        
        tableOfChores!.choresList = choreListTable.choresList
        tableOfChores!.tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "unwindBackToTable") {
            let dest = segue.destinationViewController as! ChoreListTableViewController
            dest.choresList[indexInList!] = thisChore!
            
            print("prepareForSegue: ", thisChore!.finished)
        }
    }
    
    
}

