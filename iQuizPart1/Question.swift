//
//  Questions.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/6/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import RealmSwift

class Question {//: Object {
//    dynamic var question: String = ""
//    dynamic var answers: [String] = [""]
//    dynamic var correctAnswer: String = ""
     var question: String = ""
     var answers: [String] = [""]
     var correctAnswer: String = ""
    
    init(question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
        //super.init()
    }
    
    required convenience init() {
        self.init(question: "", answers: [], correctAnswer: "")
    }
}