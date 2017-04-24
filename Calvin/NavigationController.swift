//
//  NavigationController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 24.04.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit
import SideMenu

class NavigationController : UINavigationController {
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
    }
}
