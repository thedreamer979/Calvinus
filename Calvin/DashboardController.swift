//
//  ViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 27.01.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit
import EventKit
import SideMenu

class DashboardController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let eventStore = EKEventStore()
    var news = [NSAttributedString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        
        menuController.leftSide = true
        
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        UITableViewCell.appearance().selectedBackgroundView = selectionView
        
        SideMenuManager.menuLeftNavigationController = menuController
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationBackgroundColor = UIColor(white: 1, alpha: 0.0)
        SideMenuManager.menuBlurEffectStyle = UIBlurEffectStyle.dark
      
        SideMenuManager.menuAddPanGestureToPresent(toView: menuController.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: menuController.view)
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at: 0)
        
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reload()
    }
    
    func reload() {
        // self.updateCalendar()
        self.updateNews()
    }
    
    func updateNews() {
        self.news.removeAll()
        
        if let news = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            for entry in news {
                if entry.hasPrefix("<") {
                    do {
                        let data = "<section style='color: white; text-align: justify; font-size: 1.5em'>" + entry + "</section>"
                        try self.news.append(NSAttributedString(data: data.data(using: .utf16)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil))
                    } catch {}
                }
            }
        }
        
        self.news.reverse()
        
        self.collectionView?.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
    
    func updateCalendar() {
        if let data = UserDefaults.standard.stringArray(forKey: "offline-user-data") {
            let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
            if status == EKAuthorizationStatus.notDetermined {
                eventStore.requestAccess(to: EKEntityType.event, completion: {
                (accessGranted: Bool, error: Error?) in
                
                    if accessGranted {
                        self.addEvents(data: data)
                    }
                })
            } else if status == EKAuthorizationStatus.authorized {
                self.addEvents(data: data)
            }
        }
    }

    func addEvents(data: [String]) {
        var data = data
        
        if data.count > 1 {
            let predicate = self.eventStore.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 60 * 60 * 24 * 7 * 52 * 10), calendars: [self.eventStore.defaultCalendarForNewEvents])
            
            let events = self.eventStore.events(matching: predicate)
            
            for event in events {
                do {
                    try self.eventStore.remove(event, span: .thisEvent, commit: true)
                } catch {
                    print("Failed to delete an event")
                }
            }
            
            data.removeFirst()
            
            for entry in data {
                if entry.characters[entry.startIndex] != "<" && !entry.hasPrefix("repet") && !entry.hasPrefix("liberation") {
                    let event = entry.components(separatedBy: "|")

                    let newEvent = EKEvent(eventStore: eventStore)
                
                    newEvent.title = event[0]
                    newEvent.notes = event[1]
                    
                    newEvent.startDate = Date(timeIntervalSince1970: TimeInterval(event[2])!)
                    newEvent.endDate = Date(timeIntervalSince1970: TimeInterval(event[3])!)
                    newEvent.calendar = self.eventStore.defaultCalendarForNewEvents
                
                    do {
                        try eventStore.save(newEvent, span: .thisEvent, commit: true)
                    } catch let error {
                        print("Failed to create an event")
                        print(error)
                    }
                }
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DashboardCell
        
        cell.text.attributedText = self.news[indexPath.item]
        cell.text.preferredMaxLayoutWidth = collectionView.bounds.width - 40
        
        return cell
    }
}
