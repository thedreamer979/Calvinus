//
//  NotesController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 08.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NotesController : BasicController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var cours = [String]()
    var notes = [Double]()
    
    let translations : [String: String] = ["PO": "Philosophie", "GE": "Géographie", "LA": "Latin", "MA": "Mathématiques", "EP": "Education physique", "AL": "Allemand", "IN": "Informatique", "GR": "Grec ancien", "FR": "Français", "BI":"Biologie", "PY": "Physique", "HI": "Histoire", "AN": "Anglais", "EC": "Economie", "DR": "Droit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.layer.cornerRadius = 10.0
        
        if let data = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            let elements = data[0].components(separatedBy: "/")
            
            for element in elements {
                let input = element.components(separatedBy: "|")
                
                if input.count == 3 {
                    var cours = input[1]
                    
                    let start = cours.index(cours.startIndex, offsetBy: 1)
                    let end = cours.index(cours.startIndex, offsetBy: 2)
                    cours = cours[start...end]
                    
                    if let translated = self.translations[cours] {
                        cours = translated;
                    }
                    
                    if !self.cours.contains(cours) {
                        self.cours.append(cours)
                        self.notes.append(-1);
                    }
                }
            }
        }
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
        return
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "cours") as! NoteController
        
        self.showDetailViewController(controller, sender: self)
        
        controller.controllerTitle.text = "Notes en " + self.cours[indexPath.item]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cours")!

        var text = self.cours[indexPath.item]
        
        if self.notes[indexPath.item] >= 0 {
            let note = self.notes[indexPath.item]
            text += "\t\(note)"
            cell.textLabel?.textColor = UIColor(red: CGFloat(1.0 - (note - 2) / 4.0), green: CGFloat((note - 2) / 4.0), blue: 0.0, alpha: 1.0)
        } else {
            cell.textLabel?.textColor = .white
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.tabStops = [NSTextTab(textAlignment: NSTextAlignment.right, location: self.view.bounds.width - 90)]
        
        cell.textLabel?.attributedText = NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName: style])
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cours.count
    }
}
