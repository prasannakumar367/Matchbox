//
//  PageControlViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 17/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit



class PageControlViewController: UIViewController, UIScrollViewDelegate {

    var scrollView : UIScrollView! = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl()
    
    var iVal = NSInteger()
    
    
    var currentPageIndex = CGFloat()
    
//    println(StepsCell().name)
//    println(stepsCell.name)
//    println(cellArray[0].name)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let textBackGroundView = UIView()
        textBackGroundView.backgroundColor = UIColor.white
        textBackGroundView.frame = CGRect(x:0, y:0, width: 1, height: 1)
        self.view.addSubview(textBackGroundView)

        self.view.backgroundColor = UIColor.white
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.frame = CGRect(x: 0, y: 65, width: SCREENWIDTH, height: 602)
        pageControl.frame = CGRect(x: 100, y: 580, width: SCREENWIDTH - 200, height: 50)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        configurePageControl()
        
        iVal = 0;
        
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let subView = UIView(frame: frame)
            
            if index == 3 {
                
                //subView.addSubview(accountBackView)
                
            } else {
                
                subView.backgroundColor = colors[index]
            }
            
            self.scrollView .addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 4, height: scrollView.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(PageControlViewController.changePage(sender:)), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.purple
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y:0), animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
//        
//        if currentPageIndex == 2.0 {
//            let accountVC = AccountViewController(nibName:nil, bundle: nil)
//            //let navController = UINavigationController(rootViewController: accountVC)
//            self.navigationController?.pushViewController(accountVC, animated: true)
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        if pageNumber == 3.0 {
            
//            if iVal == 0 {
//                let accountVC = AccountViewController(nibName:nil, bundle: nil)
//                //let navController = UINavigationController(rootViewController: accountVC)
//                self.navigationController?.pushViewController(accountVC, animated: true)
//                
//                iVal += 1
//            }
            
        }
        
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
//        
//        if pageNumber == 3.0 {
//            let accountVC = AccountViewController(nibName:nil, bundle: nil)
//            //let navController = UINavigationController(rootViewController: accountVC)
//            self.navigationController?.pushViewController(accountVC, animated: true)
//        }
        
        self.currentPageIndex = pageNumber;
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
