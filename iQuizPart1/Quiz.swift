//
//  Quiz.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/6/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import RealmSwift

class Quiz : Object {
    var quizTitle: String = ""
    var quizDescription: String = ""
    var quizQuestions: [Question]
    
    init(quizTitle: String, quizDescription: String, quizQuestions: [Question]) {
        self.quizTitle = quizTitle
        self.quizDescription = quizDescription
        self.quizQuestions = quizQuestions
        super.init()
    }
    
    convenience required init() {
        self.init(quizTitle: "", quizDescription: "", quizQuestions: [Question()])
    }
}