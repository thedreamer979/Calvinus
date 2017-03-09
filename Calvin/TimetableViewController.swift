//
//  TimetableViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 04.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

var timetable = [String]()

class TimetableViewController : BasicViewController, UITableViewDataSource {
    
    var dayId = 0
    
    let translations : [String: String] = ["PO": "Philo", "GE": "Géo", "LA": "Latin", "MA": "Maths", "EP": "Sport", "AL": "Allemand", "IN": "Info", "GR": "Grec", "FR": "Français", "BI":"Bio", "PY": "Physique", "HI": "Histoire", "AN": "Anglais", "EC": "Eco", "DR": "Droit"]
    
    @IBOutlet weak var table: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.layer.cornerRadius = 10.0
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at:0)
        
        timetable.removeAll()
        
        let elements = UserDefaults.standard.stringArray(forKey: "offline-user-data")?[0].components(separatedBy: "/")
        
        var hid = 1
        
        for element in elements! {
            let input = element.components(separatedBy: "|")
            
            if input.count == 3 {
                var cours = input[1]
                
                let start = cours.index(cours.startIndex, offsetBy: 1)
                let end = cours.index(cours.startIndex, offsetBy: 2)
                cours = cours[start...end]
                
                if let translated = self.translations[cours] {
                    cours = translated;
                }
                
                var prof = input[0].components(separatedBy: " ")
                
                if prof.count > 0 {
                    prof.removeLast()
                }
                
                timetable.append("H\(hid)   \(cours): \(input[2]) (\(prof.joined(separator: " ").capitalized))")
            } else if element == "Vide" {
                timetable.append("H\(hid)")
            } else {
                hid -= 1
            }
            
            hid += 1
            
            if hid > 10 {
                hid = 1
            }
        }
        
        self.table.reloadData()
    }
    
    @IBAction func dayChanged(_ sender: UISegmentedControl) {
        self.dayId = sender.selectedSegmentIndex
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hour")!
        
        cell.textLabel?.text = timetable[self.dayId * 10 + indexPath.item]
        cell.textLabel?.textColor = .white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(10, timetable.count)
    }
}
