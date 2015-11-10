//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/9/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import Foundation
import UIKit


class FinishedViewController: UIViewController {
    
    @IBOutlet weak var correctnessLabel: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    
    var total = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let totalPercent = 1.0 * Double(self.score) / Double(self.total)
        finalScore.text = "\(self.score) / \(self.total)"
        if totalPercent < 0.5 {
            correctnessLabel.text = "You could do better!"
        } else if totalPercent == 0.5 {
            correctnessLabel.text = "You got half of them right! Try Again!"
        } else if totalPercent > 0.5 {
            correctnessLabel.text = "Great job! Keep up the good work!"
        }
    }
}