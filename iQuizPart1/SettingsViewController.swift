//
//  SettingsViewController.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/17/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBAction func loadQuizzesButton(sender: AnyObject) {
        // hides keyboard so the user can click the button to load the data
        self.urlTextField.resignFirstResponder()
        let view = MasterViewController()
        view.retrieveData(urlTextField.text!)
    }
    
}
