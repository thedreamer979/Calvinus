//
//  NoteController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 11.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NoteController : BasicController, UITableViewDataSource, UITableViewDelegate {
    
    var coursId : String? = nil
    
    @IBOutlet weak var navbarTitle: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var weight: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.layer.cornerRadius = 10.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismiss(_ sender: UITextField) {
        self.view.endEditing(true)
        
        if let note = sender.text {
            if Double(note) != nil || (note.contains(" ") && Double(note.components(separatedBy: " ")[0]) != nil) {
                notes[self.coursId!]?.append(note + "\t" + self.weight.titleForSegment(at: self.weight.selectedSegmentIndex)!)
                
                print(notes[self.coursId!]!)
                
                sender.text = ""
                
                self.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note")!
        
        let text = notes[self.coursId!]![indexPath.item]
        
        var note : Double? = Double(text.components(separatedBy: "\t")[0])
        
        if note == nil {
            note = Double(text.components(separatedBy: " ")[0])
        }
        
        cell.textLabel?.textColor = UIColor(red: CGFloat(1.0 - (note! - 2) / 4.0), green: CGFloat((note! - 2) / 4.0), blue: 0.0, alpha: 1.0)
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.tabStops = [NSTextTab(textAlignment: NSTextAlignment.right, location: self.view.bounds.width - 70)]
        
        cell.textLabel?.attributedText = NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName: style])
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = notes[self.coursId!] {
            return data.count
        } else {
            notes[self.coursId!] = []
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            notes[self.coursId!]?.remove(at: indexPath.item)
        }
    }
}
