//
//  TutorialViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 26.02.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class TutorialController : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "page1"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "page2"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "page3"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "page4"))!)
        
        self.setViewControllers([self.pages[0]], direction: .forward, animated: true, completion: nil)
    
        UIPageControl.appearance().backgroundColor = .clear
        
        self.view.insertSubview(BackgroundView(frame: self.view.bounds), at:0)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.pages.index(of: viewController)! + 1
        
        if index < self.pages.count {
            return self.pages[index]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.pages.index(of: viewController)!
        
        if index > 0 {
            return self.pages[index - 1]
        } else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
