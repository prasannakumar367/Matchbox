//
//  AccountViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 15/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class AccountViewController: UIViewController, UIScrollViewDelegate {

    //Splash Page Design
    var scrollBGView:UIView = UIView()
    var backgroundImgView = UIImageView()
    var logoImgView = UIImageView()
    var btnSignUp : UIButton = UIButton()
    var btnLogin : UIButton = UIButton(type: UIButtonType.custom) as UIButton
    
    //Tutorial Pages
    var scrollView : UIScrollView! = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl()
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    //self.tblJSON.reloadData()
                }
            }
        }
        
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(red: 106.0/255.0, green: 27.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        
        //Tutorial Page Design
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollBGView.backgroundColor = UIColor.clear
        scrollBGView.frame = CGRect(x:0, y: 20 * HEIGHTTHEME, width: SCREENWIDTH, height: 510 * HEIGHTTHEME)
        scrollView.frame = CGRect(x:0, y:0, width: SCREENWIDTH, height: 510 * HEIGHTTHEME)
        
        pageControl.frame = CGRect(x: 100 * WIDTHTHEME, y: 530 * HEIGHTTHEME, width: SCREENWIDTH - (200  * WIDTHTHEME), height: 50 * HEIGHTTHEME)
        scrollView.delegate = self
        scrollBGView.addSubview(scrollView)
        //self.view.addSubview(scrollBGView)
        configurePageControl()
  
        
        for index in 0..<3 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = UIColor.white
            //subView.layer.borderWidth = 1;
            //subView.layer.borderColor = UIColor.lightGray.cgColor
            
            if index == 0 {
                //pageZero
                self.scrollView .addSubview(pageZero(subView:subView))
            } else if index == 1 {
                //pageOne
                self.scrollView .addSubview(pageOne(subView:subView))
            } else if index == 2 {
                //Page Two
                self.scrollView.addSubview(pageTwo(subView: subView))
            }
            
            
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 3, height: scrollView.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(PageControlViewController.changePage(sender:)), for: .valueChanged)
        
        //Tutorial Pages end.
        self.backgroundImgView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        //self.backgroundImgView.image = UIImage.init(named: "Background_Image.png")
        self.view.addSubview(self.backgroundImgView)
        self.view.addSubview(scrollBGView)
        
        
        //Splash page design
        //self.logoImgView.frame = CGRect(x: 145 * WIDTHTHEME, y: 30 * HEIGHTTHEME, width: 80 * WIDTHTHEME, height: 70 * HEIGHTTHEME)
        //self.logoImgView.image = UIImage.init(named: "logo.png")
        //self.view.addSubview(self.logoImgView)
        
        let rect = CGRect(x: 10 * WIDTHTHEME, y: 570 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 20 * HEIGHTTHEME) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = PinkBtnColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Discover the new style in your wardrobe."
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        self.view.addSubview(label)
        
        self.btnSignUp.frame = CGRect(x: 20  * WIDTHTHEME, y: 600 * HEIGHTTHEME, width: 160  * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        self.btnSignUp.backgroundColor = PinkBtnColor
        self.btnSignUp.setTitle("Sign up", for: UIControlState.normal)
        self.btnSignUp.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        self.btnSignUp.tag = 1
        self.btnSignUp.layer.cornerRadius = (5 * WIDTHTHEME)
        self.view.addSubview(btnSignUp)
        
        self.btnLogin.frame = CGRect(x: 195 * WIDTHTHEME, y: 600 * HEIGHTTHEME, width: 160 * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        self.btnLogin.backgroundColor = PurpleBtnColor
        self.btnLogin.setTitle("Login", for: UIControlState.normal)
        self.btnLogin.tag = 2
        self.btnLogin.layer.cornerRadius = (5 * WIDTHTHEME)
        self.btnLogin.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(btnLogin)
        //Splash Page End.
        
    }
    
    //Page One Design
    func pageZero(subView: UIView) -> (UIView) {
        
        let textBackGroundView = UIView()
        textBackGroundView.backgroundColor = PurpleBtnColor
        textBackGroundView.frame = CGRect(x:0, y:0, width: subView.frame.size.width, height: (80 * HEIGHTTHEME))
        subView.addSubview(textBackGroundView)
        
        let rect = CGRect(x: 40 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: subView.frame.size.width - (80  * WIDTHTHEME), height: 60 * HEIGHTTHEME) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir", size: (16 * HEIGHTTHEME))
        label.textAlignment = NSTextAlignment.center
        label.text = "An easy way to organise your clothes, accessories & footwear"
        label.backgroundColor = UIColor.clear
        subView.addSubview(label)
        
        
        let imgView_PageZero = UIImageView()
        imgView_PageZero.frame = CGRect(x: 50 * WIDTHTHEME, y: (100  * HEIGHTTHEME), width: subView.frame.size.width - (100 * WIDTHTHEME), height: 400 * HEIGHTTHEME)
        imgView_PageZero.image = UIImage.init(named: "tour_1_screen_Image.png")
        subView.addSubview(imgView_PageZero)
    
        
        return subView
    }
    
    
    func pageOne(subView: UIView) -> (UIView) {
        
        let textBackGroundView = UIView()
        textBackGroundView.backgroundColor = PurpleBtnColor
        textBackGroundView.frame = CGRect(x:0, y:0, width: subView.frame.size.width, height: (80  * HEIGHTTHEME))
        subView.addSubview(textBackGroundView)
        
        let rect = CGRect(x: 60 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: subView.frame.size.width - (120  * WIDTHTHEME), height: 60 * HEIGHTTHEME) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir", size: (16  * WIDTHTHEME))
        label.textAlignment = NSTextAlignment.center
        label.text = "Click or share pictures from other Apps into MatchBox"
        label.backgroundColor = UIColor.clear
        textBackGroundView.addSubview(label)
        
        let imgView_PageOne = UIImageView()
        imgView_PageOne.frame = CGRect(x: 50 * WIDTHTHEME, y: 100 * HEIGHTTHEME, width: subView.frame.size.width - (100 * WIDTHTHEME), height: 400 * HEIGHTTHEME)
        imgView_PageOne.image = UIImage.init(named: "tour_2_screen_Image.png")
        subView.addSubview(imgView_PageOne)
        
        return subView
    }
    
    func pageTwo(subView: UIView) -> (UIView) {
        
        let textBackGroundView = UIView()
        textBackGroundView.backgroundColor = PurpleBtnColor
        textBackGroundView.frame = CGRect(x:0, y:0, width: subView.frame.size.width, height: 80 * HEIGHTTHEME)
        subView.addSubview(textBackGroundView)
        
        let rect = CGRect(x: 100 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: subView.frame.size.width - (200 * WIDTHTHEME), height: 60 * HEIGHTTHEME) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        label.textAlignment = NSTextAlignment.center
        label.text = "Crop & save to your wardrobe"
        label.backgroundColor = UIColor.clear
        textBackGroundView.addSubview(label)
        
        let imgView_PageTwo = UIImageView()
        imgView_PageTwo.frame = CGRect(x: 50 * WIDTHTHEME, y: 100 * HEIGHTTHEME, width: subView.frame.size.width - (100 * WIDTHTHEME), height: 400 * HEIGHTTHEME)
        imgView_PageTwo.image = UIImage.init(named: "tour_3_screen_Image.png")
        subView.addSubview(imgView_PageTwo)
        
        return subView
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
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = PinkBtnColor
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y:0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
    }
    
    
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            
            let signupVC = SignUpViewController(nibName:nil, bundle: nil)
            self.navigationController?.pushViewController(signupVC, animated: true)
            
        } else {
            
            let loginVC = LoginViewController(nibName:nil, bundle: nil)
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        
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
