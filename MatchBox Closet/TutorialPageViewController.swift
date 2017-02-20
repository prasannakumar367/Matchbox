//
//  TutorialPageViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 15/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        delegate = self
        
        // this sets the background color of the built-in paging dots
        view.backgroundColor = UIColor.white
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = PinkBtnColor
        
        
        // This is the starting point.  Start with step zero.
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
        
    }

    func getStepZero() -> PageZero {
        
        let pageZero = PageZero(nibName:nil, bundle: nil)
        
        return pageZero
    }
    
    func getStepOne() -> PageOne {
        
        let pageOne = PageOne(nibName:nil, bundle: nil)
        
        return pageOne
    }
    
    func getStepTwo() -> PageTwo {
        
        let pageTwo = PageTwo(nibName:nil, bundle: nil)
        
        return pageTwo
    }
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        //let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        //let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        
        let mainViewController = MainViewController(nibName:nil, bundle: nil)
        let leftViewController = LeftViewController(nibName:nil, bundle: nil)
        let rightViewController = RightViewController(nibName:nil, bundle: nil)
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        //self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        //self.window?.rootViewController = slideMenuController
        //self.window?.makeKeyAndVisible()
    }
    
    func getAccountVc() {
        
        let accountVC = AccountViewController(nibName:nil, bundle: nil)
        
        //self.present(accountVC, animated:true, completion:nil)
        
        let navController = UINavigationController(rootViewController: accountVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
    
        self.navigationController?.pushViewController(navController, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - UIPageViewControllerDataSource methods

extension TutorialPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: PageTwo.self) {
            // 2 -> 1
            return getStepOne()
        } else if viewController.isKind(of: PageOne.self) {
            // 1 -> 0
            return getStepZero()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: PageZero.self) {
            // 0 -> 1
            return getStepOne()
        } else if viewController.isKind(of: PageOne.self) {
            // 1 -> 2
            return getStepTwo()
        } else if viewController.isKind(of: PageTwo.self){
            // 2 -> end of the road
            //return
            self.getAccountVc()
            return nil;
        } else {
            
            return nil;
        }
        
    }
    
    // Enables pagination dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


// MARK: - UIPageViewControllerDelegate methods

extension TutorialPageViewController : UIPageViewControllerDelegate {
    
}
