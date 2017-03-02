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

class DashboardController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        self.updateCalendar()
        request(withID: "news", controller: self, callback: self.loadNews)
    }
    
    func updateCalendar() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        if status == EKAuthorizationStatus.notDetermined {
            eventStore.requestAccess(to: EKEntityType.event, completion: {
                (accessGranted: Bool, error: Error?) in
                
                if accessGranted {
                    DispatchQueue.main.async(execute: {
                        request(withID: "calendar", controller: self, callback: self.addEvents)
                    })
                }
            })
        } else if status == EKAuthorizationStatus.authorized {
            request(withID: "calendar", controller: self, callback: addEvents)
        }
    }

    func addEvents(data: String) {
        let splitted = data.components(separatedBy: "\n")
        
        if splitted.count > 0 && splitted[0] != "NaN" {
            let predicate = self.eventStore.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 60 * 60 * 24 * 7 * 52 * 10), calendars: [self.eventStore.defaultCalendarForNewEvents])
            
            let events = self.eventStore.events(matching: predicate)
            
            for event in events {
                do {
                    try self.eventStore.remove(event, span: .thisEvent, commit: true)
                } catch {
                    print("Failed to delete an event")
                }
            }
            
            for entry in splitted {
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
    
    func loadNews(data: String) {
        let splitted = data.components(separatedBy: "\n")
        
        if splitted.count > 0 && splitted[0] != "NaN" {
            
            var id = 0
            
            for entry in splitted {
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let path = dir.appendingPathComponent("news" + String(id) + ".html")
                    
                    do {
                        try entry.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                    } catch {
                        
                    }
                }
                
                id += 1
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! DashboardCell
        
        cell.text.attributedText = self.news[indexPath.item]
        cell.text.preferredMaxLayoutWidth = collectionView.bounds.width - 40
        
        return cell
    }
}

