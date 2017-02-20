//
//  LeftViewController.swift
//  MatchBox Closet
//
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    
    case home = 0
    case profile
    case tutorial
    case recommendedtheapp
    case logout
    
//    case main = 0
//    case swift
//    case java
//    case go
//    case nonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    var tableView: UITableView = UITableView()
    
    var window: UIWindow?
    
    var menus = ["Home", "Profile", "Tutorial", "Recommend The App", "Logout"]
    var mainViewController: UIViewController!
    var profileViewController : UIViewController!
    var tutorialViewController: UIViewController!
    var rateTheappViewController: UIViewController!
    //var feedBackViewController: UIViewController!
    var contactUsMenuViewController: UIViewController!
    var recommendViewController : UIViewController!
    
    var profileBgView = UIView()
    var profilePic = UIImageView()
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        self.tableView.frame = CGRect(x: 0, y: 160, width: 270, height: self.view.frame.size.height)
        self.tableView.backgroundColor = UIColor(hex: "E0E0E0")
        self.view.addSubview(self.tableView);
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftViewController
//        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
//        
//        let javaViewController = storyboard.instantiateViewController(withIdentifier: "JavaViewController") as! JavaViewController
//        self.javaViewController = UINavigationController(rootViewController: javaViewController)
//        
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
//        self.goViewController = UINavigationController(rootViewController: goViewController)
//        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        
        self.profileViewController = ProfileViewController(nibName: nil, bundle: nil)
        self.tutorialViewController = TutorialViewController(nibName: nil, bundle: nil)
        //self.rateTheappViewController = RateTheAppViewController(nibName: nil, bundle: nil)
        //self.feedBackViewController = FeedBackViewController(nibName: nil, bundle: nil)
        //self.contactUsMenuViewController = ContactUsViewController(nibName: nil, bundle: nil)
        self.recommendViewController = RecommendAppViewController(nibName: nil, bundle: nil)
        
        let navController = UINavigationController(rootViewController: self.profileViewController)
        self.profileViewController = navController
        
        let navController1 = UINavigationController(rootViewController: self.tutorialViewController)
        self.tutorialViewController = navController1
        
        //let navController2 = UINavigationController(rootViewController: self.feedBackViewController)
        //self.feedBackViewController = navController2
        
        let navController3 = UINavigationController(rootViewController: self.recommendViewController)
        self.recommendViewController = navController3
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.isScrollEnabled = false
        self.tableView.separatorColor = UIColor.clear
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        profileBgView.backgroundColor = UIColor(hex: "E0E0E0")
        self.profilePic.clipsToBounds = true
        self.profilePic.layer.borderWidth = 1
        self.profilePic.layer.borderColor = UIColor.white.cgColor
        self.profilePic.frame = CGRect(x: 90, y: 40, width: 100, height: 100)
        self.profilePic.image = UIImage.init(named: "logo.png")
        self.profilePic.layer.cornerRadius = 100 / 2
        self.profileBgView.addSubview(self.profilePic)
        self.view.addSubview(self.profileBgView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profileBgView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
            
        case .home:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .profile:
            self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
        case .tutorial:
            self.slideMenuController()?.changeMainViewController(self.tutorialViewController, close: true)
        case .recommendedtheapp:
            shareTextButton()
        case .logout:
            logout()
            
        default: break
            
        }
    }
    
    //case .feedback:
    //self.slideMenuController()?.changeMainViewController(self.feedBackViewController, close: true)
    
    
    func logout() {
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Logout", message: "Are you sure, You want to Logout?", preferredStyle: .alert)
        // Create the actions
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            // get a reference to the app delegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // call didFinishLaunchWithOptions ... why?
            appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
            
            
            
            
            
//            
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            
//            // Override point for customization after application launch.
//            let vc = AccountViewController(nibName:nil, bundle: nil)
//            let navigationController = UINavigationController(rootViewController: vc)
//            self.window!.rootViewController = navigationController
//            self.window!.makeKeyAndVisible()
//            navigationController.setNavigationBarHidden(true, animated: false)
//            self.window!.backgroundColor = UIColor.white
//            
//            
            
            
        }
        
        UserDefaults.standard.set("false", forKey: "isLogged")
        
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // Add the actions
        alertController.addAction(yesAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func shareTextButton() {
        
        // text to share
        let text = "MatchBox app is a free closet organiser for Men and Women. Mix - match your clothes, accessories and footwear to make best outfit and style yourself. http://matchboxapp.co/"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook,
            UIActivityType.postToTwitter,
            UIActivityType.postToWeibo,
            UIActivityType.message,
            UIActivityType.mail,
            UIActivityType.print,
            UIActivityType.copyToPasteboard,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
}

/*
 case .ratetheapp:
 self.slideMenuController()?.changeMainViewController(self.rateTheappViewController, close: true)
 case .contactus:
 self.slideMenuController()?.changeMainViewController(self.contactUsMenuViewController, close: true)
 
 */



extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .profile, .tutorial, .recommendedtheapp, .logout:
                return 50
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            
            
            for cell in tableView.visibleCells {
                cell.textLabel?.textColor = UIColor.black
            }
            
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = purpleColor
            
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}


extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .profile, .tutorial, .recommendedtheapp, .logout:
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
                cell.textLabel?.text = menus[indexPath.row]
                cell.selectionStyle = .none
                
                
                cell.backgroundColor = UIColor(hex: "E0E0E0")
                
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
