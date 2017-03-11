//
//  NoteController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 11.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NoteController : BasicController, UITableViewDataSource, UITableViewDelegate {
    
    var notes = [String]()

    @IBOutlet weak var navbarTitle: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var weight: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.layer.cornerRadius = 10.0
    }

    @IBAction func add(_ sender: UIButton) {
        
    }
    
    @IBAction func dismiss(_ sender: UITextField) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
}
