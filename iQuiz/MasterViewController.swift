//
//  MasterViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 10/30/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var quizzes: [Quiz] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
        
        let settings = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "didPressSettings:")
        self.navigationItem.rightBarButtonItem = settings
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
        }
        
        var question1 = Question(question: "10 + 20", answer: "30", answers: ["1", "20", "30" , "4"])
        var question2 = Question(question: "20 - 5", answer: "15", answers: ["15", "10", "11" ,"5"])
        var question3 = Question(question: "15 * 2", answer: "30", answers: ["15", "30", "10", "1"])
        var question4 = Question(question: "100 / 2", answer: "50", answers: ["50", "5", "20", "15"])
            
        let quizMath = Quiz(title: "Math", description: "Come learn some math tricks!", questions: [question1, question2, question3, question4])
        
        question1 = Question(question: "What is the first element on the periodic table?", answer: "Hydrogen", answers: ["Oxygen", "Hydrogen", "Mercury" , "Argon"])
        question2 = Question(question: "K is the chemical symbol for which element?", answer: "Potassium", answers: ["Hydrogen", "Nitrogen","Carbon","Potassium"])
        question3 = Question(question: "Two identical cars collide head on. Each car is traveling at 100 km/h. The impact force on each car is the same as hitting a solid wall at:", answer: "100 km/h", answers: ["100 km/h", "200 km/h", "150 km/h", "50 km/h"])
        question4 = Question(question: "Plants receive their nutrients mainly from", answer: "soil", answers: ["chlorophyll", "light", "soil", "atmosphere"])
        
        let quizScience = Quiz(title: "Science", description: "Learn cool facts about chemistry, physics and biology!", questions: [question1, question2, question3, question4])
        
        question1 = Question(question: "Which super hero team does Johnny Storm belong to?", answer: "The Fantastic 4", answers: ["Ultimate Avengers", "The X-Men", "The Fantastic 4" , "The Justice League"])
        question2 = Question(question: "Which of the following hero is from marvel?", answer: "Spider-man", answers: ["The Flash", "Hancock","Sider-man","Superman"])
        question3 = Question(question: "What is Anothony Stark's super hero name?", answer: "Iron Man", answers: ["Spider Man", "Iron Man", "Deadpool", "Pheonix"])
        question4 = Question(question: "", answer: "", answers: [""])
        
        let quizMarvelSuperHeroes = Quiz(title: "Marvel Super Heroes", description: "How well do you know your favorite marvel super heroes?", questions: [question1, question2, question3, question4])
        
        
        self.quizzes = [quizMath, quizScience, quizMarvelSuperHeroes]
        
    }
    
    func didPressSettings(sender: AnyObject) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let quiz = quizzes[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.quiz = quiz
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = quiz.title
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(tableViewIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableViewIdentifier)
        }
        let quiz = quizzes[indexPath.row]
        cell!.textLabel!.text = quiz.title
        cell!.detailTextLabel!.text = quiz.description
        return cell!
        
    }
}

