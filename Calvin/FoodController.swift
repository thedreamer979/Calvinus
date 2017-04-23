//
//  FoodController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 22.04.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class FoodController : BasicController, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch indexPath.item {
        case 0:
            self.show((self.storyboard?.instantiateViewController(withIdentifier: "cafeteria"))!, sender: self)
        case 1:
            self.show((self.storyboard?.instantiateViewController(withIdentifier: "sandwich"))!, sender: self)
        case 2:
            self.show((self.storyboard?.instantiateViewController(withIdentifier: "blaqk"))!, sender: self)
        case 3:
            self.show((self.storyboard?.instantiateViewController(withIdentifier: "gourmet"))!, sender: self)
        default:
            break
        }
    
        return true
    }
}
