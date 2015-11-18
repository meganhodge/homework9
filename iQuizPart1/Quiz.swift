//
//  Quiz.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/6/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import RealmSwift

class Quiz {//: Object {
//    dynamic var quizTitle: String = ""
//    dynamic var quizDescription: String = ""
//    dynamic var quizQuestions: [Question]
     var quizTitle: String = ""
     var quizDescription: String = ""
     var quizQuestions: [Question]
    
    init(quizTitle: String, quizDescription: String, quizQuestions: [Question]) {
        self.quizTitle = quizTitle
        self.quizDescription = quizDescription
        self.quizQuestions = quizQuestions
        //super.init()
    }
    
    required convenience init() {
        self.init(quizTitle: "", quizDescription: "", quizQuestions: [])
    }
}