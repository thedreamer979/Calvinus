//
//  CafeteriaController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 22.04.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class CafeteriaController : UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let objects = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            var index = objects.count - 1
            
            while index > 0 {
                if objects[index].hasPrefix("cafet|") {
                    let object = objects[index].replacingOccurrences(of: "cafet|", with: "")
                    self.label.text = object
                    break
                } else {
                    index -= 1
                }
            }
        }
    }
}
