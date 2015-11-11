//
//  FinalViewController.swift
//  iQuizPart1
//
//  Created by Megan Hodge on 11/10/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var totalQuestions: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        self.totalLabel.text = "\(score)/\(totalQuestions)"
        self.messageLabel.text = "bleh"
    }
    
}