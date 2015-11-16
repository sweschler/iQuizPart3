//
//  Question.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/6/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation
import RealmSwift

class Question : Object {
    dynamic var question: String = ""
    dynamic var answer: String = ""
    dynamic var answers: [String]
    
    init(question: String, answer: String, answers: [String]) {
        self.question = question
        self.answer = answer
        self.answers = answers
        super.init()
    }

    required init() {
        answers = []
        super.init()
    }
}