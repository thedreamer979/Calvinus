//
//  NoteManager.swift
//  Calvin
//
//  Created by Arion Zimmermann on 11.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

var notes = [String : [String]]()

func readNotes() {
    if let array = UserDefaults.standard.dictionary(forKey: "notes") {
        for element in array {
            notes[element.key] = (element.value as! String).components(separatedBy: "|")
        }
    } else {
        UserDefaults.standard.set([String : String](), forKey: "notes")
    }
}

func writeNotes() {
    var dictionary = [String : String]()
    
    for key in notes.keys {
        let elements = notes[key]
        
        var buffer = String()
        
        for element in elements! {
            buffer += element.replacingOccurrences(of: "|", with: "-") + "|"
        }
        
        if !buffer.isEmpty {
            dictionary[key] = buffer[buffer.startIndex..<buffer.index(before: buffer.endIndex)]
        }
    }
    
    UserDefaults.standard.set(dictionary, forKey: "notes")
}

func moyenne(of: String) -> Double {
    if let array = notes[of] {
        var i = 0.0
        var count = 0.0
        
        for element in array {
            if !element.isEmpty {
                let tabs = element.components(separatedBy: "\t")
                
                if tabs.count > 1 {
                    let multiplier = Double(tabs[1].replacingOccurrences(of: "x", with: ""))!
                    
                    if let note = Double(element.components(separatedBy: " ")[0]) {
                        i += note * multiplier
                    } else {
                        i += Double(tabs[0])! * multiplier
                    }
                    
                    count += multiplier
                }
            }
        }
    
        return i / count
    } else {
        return -1
    }
}

func colorAlgorithm(withNote: Double) -> UIColor {
    return UIColor(red: CGFloat(1.0 - (withNote - 3) / 3.0), green: CGFloat((withNote - 3) / 3.0), blue: 0.0, alpha: 1.0)
}
