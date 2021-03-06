//
//  LiberationsController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 25.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class LiberationsController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var rawData = [String]()
    var data = [NSAttributedString]()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at: 0)
        
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AZEntrepriseServer.login(controller: nil, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: AZEntrepriseServer.dummyOnResponse)
    }
    
    func load() {
        data.removeAll()
        rawData.removeAll()
        
        if let news = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            for entry in news {
                if entry.hasPrefix("liber") {
                    do {
                        self.rawData.append(entry)
                        
                        let splitted = entry.components(separatedBy: "|")
                        
                        let data = splitted[1].replacingOccurrences(of: "<", with: "(").replacingOccurrences(of: ">", with: ")")
                        
                        let text = "<section style='color: white; text-align: justify; font-size: 1.5em'>\(data)</section>"
                        
                        try self.data.append(NSAttributedString(data: text.data(using: .utf16)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil))
                    } catch {}
                }
            }
        }
    }
    
    func reload() {
        self.load()
        self.collectionView?.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liberation", for: indexPath) as! DashboardCell
        
        cell.text.attributedText = self.data[indexPath.item]
        cell.text.preferredMaxLayoutWidth = collectionView.bounds.width - 40
        cell.layer.cornerRadius = 10.0
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AZEntrepriseServer.requestDeletion(controller: self, data: self.rawData[indexPath.item])

    }
}
