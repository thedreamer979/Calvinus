//
//  NotesController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 08.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NotesController : BasicController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var moyenneGeneral: UILabel!
    @IBOutlet weak var general: UIView!
    @IBOutlet weak var table: UITableView!
    
    var cours = [String]()
    var moyennes = [Double]()
    
    let translations : [String: String] = ["PO": "Philosophie", "GE": "Géographie", "LA": "Latin", "MA": "Mathématiques", "EP": "Education physique", "AL": "Allemand", "IN": "Informatique", "GR": "Grec ancien", "FR": "Français", "BI":"Biologie", "PY": "Physique", "HI": "Histoire", "AN": "Anglais", "EC": "Economie", "DR": "Droit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.layer.cornerRadius = 10.0
        self.general.layer.cornerRadius = 10.0
        
        readNotes()
        
        self.reload()
    }
    
    func reload() {
        self.cours.removeAll()
        self.moyennes.removeAll()
        
        if let data = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            let elements = data[0].components(separatedBy: "/")
            
            for element in elements {
                let input = element.components(separatedBy: "|")
                
                if input.count == 3 {
                    let cours = input[1]
                    
                    if !self.cours.contains(cours) {
                        self.cours.append(cours)
                        self.moyennes.append(moyenne(of: cours))
                    }
                }
            }
        }
        
        var noteMoyenne = 0.0
        var total = 0.0
    
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        for note in self.moyennes {
            if note >= 0 {
                noteMoyenne += note
                total += 1.0
            }
        }
        
        noteMoyenne /= total
        
        self.moyenneGeneral.text = "Moyenne générale: " + String(format: "%.1f", noteMoyenne)
        self.moyenneGeneral.textColor = colorAlgorithm(withNote: noteMoyenne)
    }
    
    @IBAction func backToMenu(segue: UIStoryboardSegue) {
        self.reload()
        self.table.reloadData()
    }
    
    @IBAction func onReset(_ sender: UIButton) {
        notes = [:]
        writeNotes()
        reload()
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "cours") as! NoteController
    
        controller.coursId = self.cours[indexPath.item]
        
        self.showDetailViewController(controller, sender: self)
        
        var title = self.cours[indexPath.item]
        
        let start = title.index(title.startIndex, offsetBy: 1)
        let end = title.index(title.startIndex, offsetBy: 2)
        title = title[start...end]
        
        if let translated = self.translations[title] {
            title = translated;
        }
        
        controller.navbarTitle.title = title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cours")!

        var text = self.cours[indexPath.item]
        
        let start = text.index(text.startIndex, offsetBy: 1)
        let end = text.index(text.startIndex, offsetBy: 2)
        text = text[start...end]
        
        if let translated = self.translations[text] {
            text = translated;
        }
        
        if self.moyennes[indexPath.item] >= 0 {
            let note = self.moyennes[indexPath.item]
            text += "\t" + String(format: "%.1f", note)
            cell.textLabel?.textColor = colorAlgorithm(withNote: note)
        } else {
            cell.textLabel?.textColor = .white
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.tabStops = [NSTextTab(textAlignment: NSTextAlignment.right, location: self.view.bounds.width - 100)]
        
        cell.textLabel?.attributedText = NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName: style])
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cours.count
    }
}
