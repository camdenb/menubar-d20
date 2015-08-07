//
//  DiceRollerViewController.swift
//  Menubar D20
//
//  Created by Camden Bickel on 8/6/15.
//  Copyright © 2015 Camden Bickel. All rights reserved.
//

import Cocoa

class DiceRollerViewController: NSViewController {
    
    var result: Int = 0
    var resultsArray: [Int] = []

    
    var currentNumberOfSides = 20
    var currentNumberOfTimes = 1
    var currentModifier = 0
    
    @IBOutlet weak var buttonD4: NSButton!
    @IBOutlet weak var buttonD6: NSButton!
    @IBOutlet weak var buttonD8: NSButton!
    @IBOutlet weak var buttonD10: NSButton!
    @IBOutlet weak var buttonD12: NSButton!
    @IBOutlet weak var buttonD20: NSButton!
    @IBOutlet weak var buttonD100: NSButton!
    
    var sideButtons = [NSButton]()
    
    @IBOutlet weak var rollButton: NSButton!
    
    @IBOutlet weak var timesTextField: NSTextField!
    @IBOutlet weak var modifierTextField: NSTextField!
    
    var resultsPopover: NSPopover?
    
    var resultsViewController: DiceResultsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        sideButtons = [buttonD4, buttonD6, buttonD8, buttonD10, buttonD12, buttonD20, buttonD100]
        resultsPopover = NSPopover()
        resultsViewController = DiceResultsViewController()
        resultsPopover!.contentViewController = resultsViewController
        
    }
    
    @IBAction func showMenu(sender: NSButton?) {
        let menu = NSMenu()
        menu.addItemWithTitle("Reset", action: Selector("resetControls:"), keyEquivalent: "")
        menu.addItemWithTitle("Quit Menubar d20", action: Selector("quitApp:"), keyEquivalent: "")
        NSMenu.popUpContextMenu(menu, withEvent: NSApp.currentEvent!, forView: sender!)
    }
    
    func resetControls(sender: AnyObject?) {
        setSidesButtonByString("d20")
        currentModifier = 0
        modifierTextField.integerValue = 0
        timesTextField.integerValue = 1
        willChangeValueForKey("result")
        result = 0
        didChangeValueForKey("result")
        closeResultsPopover(nil)
    }
    
    func quitApp(sender: AnyObject?) {
        NSApp.terminate(self)
    }
    
    func setSidesButtonByString(name: String) {
        for btn in sideButtons {
            if btn.title == name {
                btn.state = 1
            } else {
                btn.state = 0
            }
        }
    }
    
    @IBAction func sidesButtonSelected(sender: NSButton) {
        setSidesButtonByString(sender.title)
    }
    
    func validateAndUpdateFields(){
        if timesTextField.integerValue > 0 {
            currentNumberOfTimes = timesTextField.integerValue
        } else {
            currentNumberOfTimes = 1
            timesTextField.integerValue = 1
        }
        
        if Int(modifierTextField.stringValue) != nil {
            currentModifier = modifierTextField.integerValue
        } else {
            currentModifier = 0
            modifierTextField.integerValue = 0
        }
    }
    
    @IBAction func doneEditingTimes(sender: NSTextField) {
        validateAndUpdateFields()
    }
    
    func setSidesBasedOnButton(button: NSButton) {
        switch button.title {
            case "d4":
                currentNumberOfSides = 4
            case "d6":
                currentNumberOfSides = 6
            case "d8":
                currentNumberOfSides = 8
            case "d10":
                currentNumberOfSides = 10
            case "d10":
                currentNumberOfSides = 12
            case "d20":
                currentNumberOfSides = 20
            case "d100":
                currentNumberOfSides = 100
            default:
                currentNumberOfSides = 20
        }
    }
    
    @IBAction func rollDice(sender: NSButton) {
        validateAndUpdateFields()
        willChangeValueForKey("result")
        let results = DiceRoller.rollDice(numberOfRolls: currentNumberOfTimes, numberOfSides: currentNumberOfSides, modifier: currentModifier)
        result = results.total
        didChangeValueForKey("result")
        resultsArray = results.array
        resultsViewController?.initWithData(resultsArray)
    }
    
    @IBAction func viewResultsInPopover(sender: NSButton?) {
        toggleResultsPopover(sender)
    }
    
    func showResultsPopover(sender: NSButton?) {
        if let button = sender {
            resultsPopover!.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closeResultsPopover(sender: NSButton?) {
        resultsPopover!.performClose(sender)
    }
    
    func toggleResultsPopover(sender: NSButton?) {
        if resultsPopover!.shown {
            closeResultsPopover(sender)
        } else {
            showResultsPopover(sender)
        }
    }
    
}
