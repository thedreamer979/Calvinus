//
//  NoteController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 11.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NoteController : BasicController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var controllerTitle: UILabel!
    @IBOutlet weak var weight: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.layer.cornerRadius = 10.0
    }

    @IBAction func add(_ sender: UIButton) {
        
    }
    
    @IBAction func dismiss(_ sender: UITextField) {
        
    }
}
