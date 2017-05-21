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
        
        AZEntrepriseServer.login(controller: nil, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: AZEntrepriseServer.dummyOnResponse)
        
        if let objects = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            var index = objects.count - 1
            
            while index > 0 {
                if objects[index].hasPrefix("cafet|") {
                    do {
                        let object = objects[index].replacingOccurrences(of: "cafet|", with: "").replacingOccurrences(of: "<h1>", with: "<br><br><h1>")
                        let data = "<section style='font-family: savoye let; font-size: 25px'>" + object + "</section>"
                        try self.label.attributedText = NSAttributedString(data: data.data(using: .utf16)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                        break
                    } catch {}
                } else {
                    index -= 1
                }
            }
        }
    }
}
