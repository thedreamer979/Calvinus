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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at:0)
    }
    
    @IBAction func dayChanged(_ sender: UISegmentedControl) {
        self.dayId = sender.selectedSegmentIndex
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hour")!
        
        cell.textLabel?.text = self.timetable[self.dayId * 5 + indexPath.item]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
