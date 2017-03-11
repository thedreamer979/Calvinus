//
//  BasicViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 03.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class BasicController : UIViewController {
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at:0)
    }
}
