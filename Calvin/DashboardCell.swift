//
//  NewsCell.swift
//  Calvin
//
//  Created by Arion Zimmermann on 27.02.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class DashboardCell : UICollectionViewCell {
    @IBOutlet weak var text: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10.0
    }
}
