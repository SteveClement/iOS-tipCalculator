//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Steve Clement on 24/03/15.
//  Copyright (c) 2015 Steve Clement. All rights reserved.
//

import Foundation

// This will be the projects (M)odel the (V)iew and the (C)ontroller are implemented elsewhere
// Reminder, Model talks to view, view to controller, Model never talks to Controller (MVC principles)
class TipCalculatorModel {
    
    var total: Double
    var taxPct: Double
    // this is a computed property, because the user selects total and tax-% in UI
    // this propert will not store a value but is computed each time it gets accessed
    // NB, you could also provide a setter method e.g set(newSubtotal) { …
    // The setter would update the backing properties total & taxPct but is superflous in this example
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    
    func returnPossibleTips() -> [Int: Double] {
        
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        var retval = [Int: Double]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
        
    }
    
}