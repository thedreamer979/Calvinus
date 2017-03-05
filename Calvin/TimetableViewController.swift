//
//  TimetableViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 04.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class TimetableViewController : BasicViewController, UITableViewDataSource {
    
    var timetable = [String]()
    var dayId = 0
    
    let translations : [String: String] = ["PO": "Philo", "GE": "Géo", "LA": "Latin", "MA": "Maths", "EP": "Sport", "AL": "Allemand", "IN": "Info", "GR": "Grec", "FR": "Français", "BI":"Bio", "PY": "Physique", "HI": "Histoire", "AN": "Anglais"]
    
    @IBOutlet weak var table: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.layer.cornerRadius = 10.0
        
        request(withID: "timetable&hash=94e4edb69ab77fcf0ba83eeb2dcd2d92a8c52668dfd19813e8911048df0dbd49", controller: self, callback: loadTimetable)
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at:0)
    }
    
    func loadTimetable(data : String) {
        
        self.timetable.removeAll()
        
        let elements = data.components(separatedBy: "/")
        
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
                
                let prof = input[0]
                let range = prof.range(of: " ", options: .backwards)
                
                timetable.append(cours + " en " + input[2] + " avec " + prof[prof.startIndex...(range?.lowerBound)!].capitalized)
            } else if element == "Vide" {
                timetable.append("Pause")
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.table.reloadData()
        })
    }
    
    @IBAction func dayChanged(_ sender: UISegmentedControl) {
        self.dayId = sender.selectedSegmentIndex
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hour")!
        
        cell.textLabel?.text = self.timetable[self.dayId * 10 + indexPath.item]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(10, self.timetable.count)
    }
}
