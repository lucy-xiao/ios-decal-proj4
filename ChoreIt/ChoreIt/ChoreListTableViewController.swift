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
    var choreViewController: MyChoreViewController!
//    var choreViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MyChoreViewController") as! MyChoreViewController
    var users: [User?]!
    var pickerDelegateAndSource: PickerViewDelegateAndSource?
    var seg: UIStoryboardSegue?
    var tabBar: UITabBarController!
    //var loginView: LoginViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        users = [User(username: "Joey"), User(username: "Sandy"), User(username: "Lucy")]
        pickerDelegateAndSource = PickerViewDelegateAndSource(allUsers: users)
        // Do any additional setup after loading the view, typically from a nib.
//        let chore1 = Chore(choreName: "eat ALLLL the fooooood", username: "helena")
//        choresList.append(chore1)
//        let chore2 = Chore(choreName: "punch people", username: "lucy")
//        choresList.append(chore2)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear: ", users)
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
        self.checkOffFinishedChores(cell, indexRow: indexPath.row)
        return cell
    }
    
    func checkOffFinishedChores(cell: UITableViewCell, indexRow: Int) {
        if choresList[indexRow].finished == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rowOfLastChoreSelected = indexPath.row
        /*print("didSelectRowAtIndexPath:")
        if lastChoreSelected == nil {
            print("   nil")
        } else {
            print("   ", lastChoreSelected!.choreName)
        }*/
        print("didsselecttrowatindexpath: ", rowOfLastChoreSelected)
        selectedAChore = true
//        prepareForSegue(seg!, sender: seg)
        performSegueWithIdentifier("ToChoreDetailView", sender: nil)

    //choresList[indexPath.row] = NSDate()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        seg = segue
        if (segue.identifier == "ToChoreDetailView") {
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! ChoreViewController
            print("PRINITING CHORESLIST")
            print(rowOfLastChoreSelected)
            for item in choresList {
                print(item)
            }
            print(choresList[rowOfLastChoreSelected!])
            print(choresList[rowOfLastChoreSelected!].person)
            print(choresList[rowOfLastChoreSelected!].person.username)
            //dest.thisUserName = choresList[rowOfLastChoreSelected!].person.username
            dest.thisUser = thisUser!
            print("selectedAChore111: ",selectedAChore)
            if selectedAChore {
                dest.thisChore = choresList[rowOfLastChoreSelected!]
                dest.indexInList = rowOfLastChoreSelected
                dest.choreListTable = self
//                dest.thisChoreLabel.text = choresList[rowOfLastChoreSelected!].choreName
//                print("dest.thisChoreLabel.text: ", dest.thisChoreLabel.text)
//                dest.reloadView()
            }
            selectedAChore = false
            /*print("prepareForSegue:")
            if lastChoreSelected == nil {
                print("   nil")
            } else {
                print("   ", lastChoreSelected!.choreName)
            }*/
        } else if (segue.identifier == "ToAddChoreView") {
            pickerDelegateAndSource = PickerViewDelegateAndSource(allUsers: users)
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
    
    func backFromAddChoreView(var addedChore: Chore?) {
        self.tabBarController?.selectedIndex = 1
        if (addedChore != nil) {
            addedChore!.indexRow = choresList.count
            choresList.append(addedChore!)
            if addedChore!.person!.username == thisUser!.username {
                choreViewController.thisChore = addedChore
                choreViewController.reloadView()
            }
            self.tableView.reloadData()
        }
    }
    
    func backFromAddHouseMemberView(var addedMember: User?) {
        self.tabBarController?.selectedIndex = 2
        if (addedMember != nil) {
            addedMember!.userIndexRow = users.count
            users.append(addedMember!)
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
            if (indexPath.row < (choresList.count - 1)) {
                for index in (indexPath.row)...(choresList.count - 1) {
                    choresList[index].indexRow = index
                }
            }
            self.tableView.reloadData()
            /*if (rowOfLastChoreSelected > 0) {
                rowOfLastChoreSelected! = rowOfLastChoreSelected! - 1
            }*/
        }
        
    }

}

