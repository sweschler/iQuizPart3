//
//  Question.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/6/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation

class Question {
    var question: String = ""
    var answer: String = ""
    var answers: [String]
    
    init(question: String, answer: String, answers: [String]) {
        self.question = question
        self.answer = answer
        self.answers = answers
    }
}