//
//  MasterViewController.swift
//  iQuiz Part 1
//
//  Created by Megan Hodge on 10/30/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
//    var detailViewController: DetailViewController? = nil
//    let categories = ["Mathematics", "Marvel Super Heroes", "Science"]
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.tableFooterView = UIView()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        let settings = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "didPressSettings:")
//        self.navigationItem.rightBarButtonItem = settings
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
//    }
    
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
        
        // sets up math quiz
        var firstQuestion = Question(question: "8 - 5", answers: ["1", "4", "3", "100"], correctAnswer: "3")
        var secondQuestion = Question(question: "28 + 12", answers: ["14", "40", "37", "0"], correctAnswer: "40")
        var thirdQuestion = Question(question: "7 * 4", answers: ["28", "48", "36", "400"], correctAnswer: "28")
        var fourthQuestion = Question(question: "8 / 4", answers: ["2", "50", "1", "8"], correctAnswer: "2")
        let mathQuiz = Quiz(quizTitle: "Mathematics", quizDescription: "Math quiz to test your math skills", quizQuestions: [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion])
        
        // sets up the marvel quiz
        firstQuestion = Question(question: "Spiderman", answers: ["1", "4", "3", "100"], correctAnswer: "3")
        secondQuestion = Question(question: "Superman", answers: ["14", "40", "37", "0"], correctAnswer: "40")
        thirdQuestion = Question(question: "Batman", answers: ["28", "48", "36", "400"], correctAnswer: "28")
        fourthQuestion = Question(question: "Wonderwoman", answers: ["2", "50", "1", "8"], correctAnswer: "2")
        let marvelQuiz = Quiz(quizTitle: "Marvel Super Heroes", quizDescription: "Tests your super hero knowledge", quizQuestions: [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion])
        
        // sets up the science quiz
        firstQuestion = Question(question: "Chem", answers: ["1", "4", "3", "100"], correctAnswer: "3")
        secondQuestion = Question(question: "Bio", answers: ["14", "40", "37", "0"], correctAnswer: "40")
        thirdQuestion = Question(question: "Physics", answers: ["28", "48", "36", "400"], correctAnswer: "28")
        fourthQuestion = Question(question: "Labs", answers: ["2", "50", "1", "8"], correctAnswer: "2")
        let scienceQuiz = Quiz(quizTitle: "Science", quizDescription: "Tests to see how much you know about science", quizQuestions: [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion])
        
        self.quizOptions = [mathQuiz, marvelQuiz, scienceQuiz]
    }

    
    func didPressSettings(sender: AnyObject) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = categories[indexPath.row]
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
    
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
}