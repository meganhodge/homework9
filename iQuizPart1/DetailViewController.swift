//
//  DetailViewController.swift
//  iQuiz Part 1
//
//  Created by Megan Hodge on 10/30/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submit: UIBarButtonItem!
    
    var questionNumber: Int = 1
    var answerSelected: Int = 0
    var totalScore: Int = 0
    
    var quizSelected = Quiz(quizTitle: "", quizDescription: "", quizQuestions: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.quizDescriptionLabel.text = self.quizSelected.quizQuestions[questionNumber - 1].question
        // Next can not be selected until an option is selected
        self.navigationItem.rightBarButtonItem!.enabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AnswerViewController
            let currentQuestion = self.quizSelected.quizQuestions[questionNumber - 1]
            controller.quizSelected = self.quizSelected
            controller.onQuestion = self.questionNumber
            controller.gotItRight = (currentQuestion.answers[answerSelected] == currentQuestion.correctAnswer)
            controller.numberCorrect = self.totalScore
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizSelected.quizQuestions[questionNumber - 1].answers.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("Answer")
        cell!.textLabel?.text = quizSelected.quizQuestions[questionNumber - 1].question
        cell?.textLabel?.textAlignment = .Center
        return cell
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Answer", forIndexPath: indexPath)
        cell.textLabel?.text = quizSelected.quizQuestions[questionNumber - 1].answers[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.answerSelected = indexPath.row
        self.navigationItem.rightBarButtonItem!.enabled = true
    }
}