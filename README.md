# ChoreIt

## Authors
* Helena Huang
* Lucy Xiao

##Purpose
ChoreIt is an app that allows a household to easily distribute chore responsibility as well as help members keep track of chore progress.

##Features
* Keep track of your chores for the week.
* See who is responsible for what chore.
* See who hasn’t completed his or her chore.
* Check off someone else if they completed the chore.
* Users can check out profiles to see streaks.

##Control Flow
* Users are initially presented with a logo screen, followed by a log in or create an account view. If the user creates a new account, they enter a username and create a new group/household or join an existing one. Otherwise, the user will be taken to their list of chore(s) (Chores tab) this week. The user can tap on their chore to complete it and send a request to any member of the household to verify that the chore was completed. The user can tap on either the Chores tab or the Household tab. In the Household tab, the user can check out other members’ profiles and chores. 

##Implementation
###Model
*User.Swift
###View
*LoginView
*ChoreListTableView
*HouseholdTableView
###Controller
*LoginViewController
*ChoreListTableViewController
*HouseholdTableView

