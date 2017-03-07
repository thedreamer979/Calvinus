//
//  BoreController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 06.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class BoreController : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.backgroundView = BackgroundView(frame: self.view.bounds)
    }
}
