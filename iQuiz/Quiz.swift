//
//  Quiz.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/6/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation

class Quiz {
    var title: String = ""
    var description: String = ""
    var questions: [Question]
    

    init(title: String, description: String, questions: [Question]) {
        self.title = title
        self.description = description
        self.questions = questions
    }
    
    convenience init() {
        self.init(title: "", description: "", questions:[])
    }
}

