//
//  NoteManager.swift
//  Calvin
//
//  Created by Arion Zimmermann on 11.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import Foundation

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
        
        for element in array {
            if element.contains(" ") {
                i += Double(element.components(separatedBy: " ")[0])!
            } else if !element.isEmpty {
                i += Double(element.components(separatedBy: "\t")[0])!
            }
        }
    
        return i / Double(array.count)
    } else {
        return -1
    }
}
