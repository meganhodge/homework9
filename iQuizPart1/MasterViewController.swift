//
//  MasterViewController.swift
//  iQuiz Part 1
//
//  Created by Megan Hodge on 10/30/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct defaultKeys {
    // to access the data in the defaults
    static let localStorageKey = "LocalStorageKey"
}

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    
    // variable to hold the different quizzes the user could select
    var quizOptions: [Quiz] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
        
        let settings = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "didPressSettings:")
        self.navigationItem.rightBarButtonItem = settings
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // we are storing data in this for now
        // (we should never do this but we are doing this)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let firstString = defaults.stringForKey(defaultKeys.localStorageKey) {
            parseData(firstString)
            print("GETTING DATA FROM LOCAL STORAGE")
        } else {
            retrieveData("http://tednewardsandbox.site44.com/questions.json")
            print("GETTING DATA FROM URL")
        }
        
        self.refreshControl?.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refreshData(refreshControl : UIRefreshControl) {
        // erases the ones currently set so that the newly refreshed ones can be set
        self.quizOptions = []
        self.retrieveData("http://tednewardsandbox.site44.com/questions.json")
        refreshControl.endRefreshing()
    }

    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        
    }
    
    func didPressSettings(sender: AnyObject) {
        // segues to settings popover
        self.performSegueWithIdentifier("settingsSegue", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // sets quiz to the quiz that has been selected
                let quiz = quizOptions[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.quizSelected = quiz
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                // sets the navigation top title to the quiz title
                controller.navigationController?.topViewController?.title = quiz.quizTitle
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizOptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = quizOptions[indexPath.row].quizTitle
        cell.detailTextLabel?.text = quizOptions[indexPath.row].quizDescription
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // gets the data from a url as a string
    func retrieveData(url: String) {
        Alamofire.request(.GET, url).responseString() {response in
            switch response.result {
                // .SUCCESS and .FAILURE come from Alamofire
            case .Success:
                if let data = response.result.value {
                    // NSUserDefaults is like a dictionary stored on local storage
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(String(data), forKey: defaultKeys.localStorageKey)
                    defaults.synchronize()
                    self.parseData(data)
                    print("SAVING DATA TO LOCAL STORAGE")
                }
            case .Failure(let error):
                print(error)
            }
            // needs to load data so that it can be displayed because otherwise it sets up the tableview without the data? displays no cells
            self.tableView.reloadData()
        }
    }
    
    // takes in data and parses it by converting it to JSON and the parsing
    func parseData(data: AnyObject) {
        if let dataFromString = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let swiftyJson = JSON(data: dataFromString) // casts it to SwiftyJSON so that we can process it better
            let swiftyJsonArray = swiftyJson.array
            for eachQuiz in swiftyJsonArray! {
                let quiz = Quiz()
                quiz.quizTitle = eachQuiz["title"].stringValue
                quiz.quizDescription = eachQuiz["desc"].stringValue
                for eachQuestion in eachQuiz["questions"].array! {
                    let question = eachQuestion["text"].stringValue
                    let correctAnswer = eachQuestion["answer"].stringValue
                    let questionData = Question(question: question, answers: [], correctAnswer: correctAnswer)
                    for answerOption in eachQuestion["answers"].array! {
                        questionData.answers.append(answerOption.stringValue)
                    }
                    quiz.quizQuestions.append(questionData)
                }
                self.quizOptions.append(quiz)
            }
        }
    }
}