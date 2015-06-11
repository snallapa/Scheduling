//
//  ResidentGrouping.swift
//  Scheduling
//
//  Created by Sahith Nallapareddy on 6/2/15.
//  Copyright (c) 2015 Sahith Nallapareddy. All rights reserved.
//

import Foundation


class ResidentGrouping
{
    let letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    let maxButtons = 4
    
    
    func grouping(residentNames: [String]) -> [String] {
        let totalCount = residentNames.count
        if(totalCount == 0) {
            return [""]
        }
        var totalFirstNameLetter = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        for i in 0..<totalCount {
            let firstLetter = residentNames[i].lowercaseString
            totalFirstNameLetter[findLetter(firstLetter)] = totalFirstNameLetter[findLetter(firstLetter)] + 1
        }
        let maxLimit = totalCount/4
        
        
        
        return [""]
    }
    
    private func findLetter(letter: String) -> Int {
        
        for i in 0..<letters.count {
            if (letter == letters[i]) {
                return i
            }
        }
        
        return -1;
    }
    
    
}