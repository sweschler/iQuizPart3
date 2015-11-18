//
//  Quiz.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/6/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation
import RealmSwift

class Quiz/* : Object*/ {
    var title: String = ""
    var desc: String = ""
    var questions: [Question]
    

    init(title: String, desc: String, questions: [Question]) {
        self.title = title
        self.desc = desc
        self.questions = questions
//        super.init()
    }
    
    convenience required init() {
        self.init(title: "", desc: "", questions:[])
    }
}

