//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Prasanna kumar on 08/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "LeftMenuICon")!)
        //self.addRightBarButtonWithImage(UIImage(named: "RightMenuIcon")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
