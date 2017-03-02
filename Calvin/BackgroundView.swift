//
//  BackgroundView.swift
//  Calvin
//
//  Created by Arion Zimmermann on 26.02.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class BackgroundView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.realInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.realInit()
    }
    
    func realInit() {
        let imageView = UIImageView(image: UIImage(named: "calvin.jpg"))
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.95
        blurEffectView.frame = imageView.bounds
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = imageView.bounds
        
        self.addSubview(imageView)
        self.addSubview(blurEffectView)
        self.addSubview(vibrancyEffectView)
    }
}
