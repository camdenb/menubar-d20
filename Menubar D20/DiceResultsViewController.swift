//
//  DiceResultsViewController.swift
//  Menubar D20
//
//  Created by Camden Bickel on 8/6/15.
//  Copyright © 2015 Camden Bickel. All rights reserved.
//

import Cocoa

class DiceResultsViewController: NSViewController {
    
    dynamic var resultsArray: [Int] = []
    
    @IBOutlet weak var maxValueField: NSTextField?
    @IBOutlet weak var minValueField: NSTextField?
    
    func initWithData(resultsArray: [Int]) {
        self.resultsArray = resultsArray
        maxValueField?.integerValue = resultsArray.maxElement()!
        minValueField?.integerValue = self.resultsArray.minElement()!
    }

    override var nibName: String? {
        return "DiceResultsViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
