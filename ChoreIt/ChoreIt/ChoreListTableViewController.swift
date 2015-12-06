//
//  ChoreListTableViewController.swift
//  ChoreIt
//
//  Created by Lucy Xiao on 12/5/15.
//  Copyright © 2015 Lucy Xiao. All rights reserved.
//

import UIKit

class ChoreListTableViewController: UITableViewController {

    var choresList = [Chore]()
    var rowOfLastChoreSelected: Int? = nil
    var selectedAChore = false
    var thisUser: User?
    var myChoreViewController: ChoreViewController!
    var users: [User?]!
    var pickerDelegateAndSource: PickerViewDelegateAndSource?
    var seg: UIStoryboardSegue?
    //var loginView: LoginViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = [User(username: "Joey"), User(username: "Sandy"), User(username: "Lucy")]
        pickerDelegateAndSource = PickerViewDelegateAndSource(allUsers: users)
        // Do any additional setup after loading the view, typically from a nib.
//        let chore1 = Chore(choreName: "eat ALLLL the fooooood", username: "helena")
//        choresList.append(chore1)
//        let chore2 = Chore(choreName: "punch people", username: "lucy")
//        choresList.append(chore2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choresList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChoreCell", forIndexPath: indexPath)
        cell.textLabel?.text = choresList[indexPath.row].choreName
        cell.detailTextLabel!.text = choresList[indexPath.row].person!.username
        if choresList[indexPath.row].finished == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rowOfLastChoreSelected = indexPath.row
        /*print("didSelectRowAtIndexPath:")
        if lastChoreSelected == nil {
            print("   nil")
        } else {
            print("   ", lastChoreSelected!.choreName)
        }*/
        selectedAChore = true
        prepareForSegue(seg!, sender: seg)
    //choresList[indexPath.row] = NSDate()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        seg = segue
        if (segue.identifier == "ToChoreDetailView") {
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! ChoreViewController
            if selectedAChore {
                dest.thisChore = choresList[rowOfLastChoreSelected!]
                dest.indexInList = rowOfLastChoreSelected
            }
            selectedAChore = false
            /*print("prepareForSegue:")
            if lastChoreSelected == nil {
                print("   nil")
            } else {
                print("   ", lastChoreSelected!.choreName)
            }*/
        } else if (segue.identifier == "ToAddChoreView") {
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! AddChoreTableViewController
            dest.choreTable = self
            dest.listOfUsers = users
            dest.delegateAndSource = pickerDelegateAndSource
        }
    }

    /*@IBAction func backFromAddChoreView(segue: UIStoryboardSegue) {
        self.tabBarController?.selectedIndex = 1
        
        for chore in choresList {
            print(chore.choreName, ": ", chore.finished)
        }
        
        let source = segue.sourceViewController as! AddChoreTableViewController
        let chore = source.chore as Chore!
        if ((chore) != nil) {
            choresList.append(chore)
            self.tableView.reloadData()
        }
    }*/
    
    func backFromAddChoreView(addedChore: Chore?) {
        self.tabBarController?.selectedIndex = 1
        if (addedChore != nil) {
            print(addedChore?.choreName, ": ", addedChore?.person.username)
            choresList.append(addedChore!)
            if addedChore!.person!.username == thisUser!.username {
                myChoreViewController.thisChore = addedChore
                myChoreViewController.reloadView()
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func segueBackFromAdd(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func backFromChoreView(segue: UIStoryboardSegue) {
        self.tabBarController?.selectedIndex = 1
        for chore in choresList {
            print(chore.choreName, ": ", chore.finished)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func backFromCancelAddChore(segue: UIStoryboardSegue) {
        print("MAKE UP YOUR MINDDDD")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            choresList.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            /*if (rowOfLastChoreSelected > 0) {
                rowOfLastChoreSelected! = rowOfLastChoreSelected! - 1
            }*/
        }
        
    }

}

