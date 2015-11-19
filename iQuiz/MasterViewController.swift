//
//  MasterViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 10/30/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var quizzes: [Quiz] = []
    
    
    struct defaultsKeys {
        static let localStorageKey = "LocalStorageKey"
    }
    
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
        
        let defaults = NSUserDefaults.standardUserDefaults() //gives us access to local storage 
        
        if let stringOne = defaults.stringForKey(defaultsKeys.localStorageKey) {
            parseData(stringOne)
            print("LOADING FROM LOCAL STORAGE") //for test use only
        } else {
            print("LOADING DATA FROM ONLINE") // for test use only
            self.fetchData("https://tednewardsandbox.site44.com/questions.json")
        }
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    func fetchData(url: String){
        Alamofire.request(.GET, url).responseString() {response in
            switch response.result {
                //code from SwiftyJSON github page
            case .Success:
                if let value = response.result.value {
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(String(value), forKey: defaultsKeys.localStorageKey) //storing the content
                    defaults.synchronize() //you can store multiple lines at once but then it synchornizes, saving the data
                    self.parseData(value)
                    print("SAVING DATA TO LOCAL STORAGE") //for test use only
                }
                
            case .Failure(let error): //from Alamofire
                print(error)
            }
            
            self.tableView.reloadData()
        }
    }
    
    func parseData(data: AnyObject) {
        if let dataFromString = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString) //cast into SwiftyJSON
            //print("JSON: \(json)")
            let data = json.array
            for quizData in data! {
                let quiz = Quiz()
                quiz.title = quizData["title"].stringValue
                quiz.desc = quizData["desc"].stringValue
                for questionData in quizData["questions"].array! {
                    let question = Question(question: questionData["text"].stringValue, answer: questionData["answer"].stringValue, answers: [])
                    for answerData in questionData["answers"].array! {
                        question.answers.append(answerData.stringValue)
                    }
                    quiz.questions.append(question)
                    
                }
                self.quizzes.append(quiz)
            }
 
        }
    }
    
    func didPressSettings(sender: AnyObject) {
        //segue to settings popover
        self.performSegueWithIdentifier("SettingsSegue", sender: self)
        
        //in case I want to change it back to a alert view
//        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
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
        //print(quizzes.count)
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
        cell!.detailTextLabel!.text = quiz.desc
        return cell!
    }
}

