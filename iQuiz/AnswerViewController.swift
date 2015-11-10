//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/8/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    
    var isCorrect = false
    var quiz: Quiz = Quiz(title: "", description: "", questions: [])
    var score = 0
    var total = 0
    var questionIndex = 0
    
    @IBOutlet weak var checkAnswerLabel: UILabel!
    
    @IBOutlet weak var solution: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBAction func didSelectNext(sender: AnyObject) {
        if questionIndex == (quiz.questions.count - 1){
            performSegueWithIdentifier("FinalPageSegue", sender: self)
        } else {
            questionIndex++
            performSegueWithIdentifier("NextQuestionSegue", sender: self)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NextQuestionSegue" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.quiz = self.quiz
            controller.questionIndex = self.questionIndex
            controller.score = self.score
            controller.total = self.total
        } else {
           let controller = (segue.destinationViewController as! UINavigationController).topViewController as! FinishedViewController
            controller.score = self.score
            controller.total = self.total
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Back button is disabled so make sure you cannot cheat 
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.solution.text = "Correct Answer: \(self.quiz.questions[questionIndex].answer)"
        self.questionLabel.text = "Question: \(self.quiz.questions[questionIndex].question)"
        if !isCorrect {
            checkAnswerLabel.text = "Incorrect"
            checkAnswerLabel.textColor = UIColor.redColor()
            total++
            
        } else {
            total++
            score++ 
        }
    }
}