//
//  AnswerViewController.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/9/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var quizQuestion: UILabel!
    @IBOutlet weak var rightWrongIndicator: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    
    var onQuestion = 0
    var gotItRight = false
    var numberCorrect = 0
    var quizSelected = Quiz(quizTitle: "", quizDescription: "", quizQuestions: [])

    @IBAction func nextButton(sender: AnyObject) {
        // if this is the last question then go to finish screen
        if onQuestion == quizSelected.quizQuestions.count {
            performSegueWithIdentifier("goToFinish", sender: self)
        } else { // if this is not then go to the next question
            onQuestion++
            performSegueWithIdentifier("goToNextQuestion", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentQuestion = self.quizSelected.quizQuestions[onQuestion - 1]
        self.quizQuestion.text = currentQuestion.question
        self.correctAnswer.text = currentQuestion.answers[Int(currentQuestion.correctAnswer)! - 1]
        self.navigationItem.setHidesBackButton(true, animated: true)
        if gotItRight {
            self.numberCorrect++
            self.rightWrongIndicator.text = "Yay! That's correct"
        } else {
            self.rightWrongIndicator.text = "Nooooooo. That is incorrect"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // sets the navigation top title to the quiz title
        //controller.navigationController?.topViewController?.title = quiz.quizTitle
        if segue.identifier == "goToFinish" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! FinalViewController
            controller.totalQuestions = self.quizSelected.quizQuestions.count
            controller.score = self.numberCorrect
        } else {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.quizSelected = self.quizSelected
            controller.questionNumber = self.onQuestion
            controller.totalScore = self.numberCorrect
        }
    }
    
    
}