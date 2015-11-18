//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Sabrina Weschler on 11/17/15.
//  Copyright © 2015 Sabrina Weschler. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var urlInputField: UITextField!
    @IBAction func retrieveDataButton(sender: AnyObject) {
        self.resignFirstResponder()
        let view = MasterViewController()
        view.fetchData(self.urlInputField.text!)
        
        
    }
}
