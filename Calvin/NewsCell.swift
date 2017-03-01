//
//  NewsCell.swift
//  Calvin
//
//  Created by Arion Zimmermann on 27.02.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class NewsCell : UICollectionViewCell {
    @IBOutlet weak var text: UILabel!
    
    func update() {
        self.layer.cornerRadius = 10.0
        self.sizeToFit()
        self.layoutIfNeeded()
    }
}
