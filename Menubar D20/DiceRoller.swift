//
//  DiceRoller.swift
//  Menubar D20
//
//  Created by Camden Bickel on 8/6/15.
//  Copyright © 2015 Camden Bickel. All rights reserved.
//

import Foundation

class DiceRoller {
    
    var numberOfRolls = 1
    var numberOfSides = 20
    
    class func rollDice(numberOfRolls rolls: Int, numberOfSides type: Int, modifier: Int) -> (total: Int, array: [Int]) {
        
        var total = 0
        var arr: [Int] = []
        
        for _ in 0..<rolls {
            let num = Int(arc4random_uniform(UInt32(type))) + 1
            total += num + modifier
            arr.append(num + modifier)
        }
        
        return (total, arr)
        
    }
    
}
