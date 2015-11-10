//
//  DetailViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 10/30/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var next: UIBarButtonItem!
    
    var selectedIndex = 0
    var questionIndex = 0
    var score = 0
    var total = 0
    
    //TODO: Change this to make it work without setting a random object Quiz
    var quiz: Quiz = Quiz(title: "", description: "", questions: [])


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.detailDescriptionLabel.text = self.quiz.description
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellIdentifier = "HeaderCell"
        var headerCell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        if headerCell == nil {
            headerCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        let label = headerCell!.textLabel!
        label.text = quiz.questions[questionIndex].question
        label.font = UIFont.boldSystemFontOfSize(16.0)
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0

        return headerCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        if cell!.accessoryType == UITableViewCellAccessoryType.None {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedIndex = indexPath.row
            next.enabled = true
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
            next.enabled = false
        }
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiz.questions[questionIndex].answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(tableViewIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableViewIdentifier)
        }
        let answer = quiz.questions[questionIndex].answers[indexPath.row]
        cell!.textLabel!.text = answer
        
        return cell!
        
    }
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AnswerViewController
        let question = self.quiz.questions[questionIndex]
        controller.isCorrect = (question.answers[selectedIndex] == question.answer)
        controller.questionIndex = self.questionIndex
        controller.quiz = self.quiz
        controller.score = self.score
        controller.total = self.total
    }

}

