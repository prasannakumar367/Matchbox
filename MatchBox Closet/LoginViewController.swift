//
//  LoginViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 16/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftValidator
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {

    var validator = Validator()
    let mbUtils = MBUtils()
    
    var backgroundImgView = UIImageView()
    var loginView : UIView! = UIView()
    
    var lbl_email = UILabel()
    var txt_email = UITextField()
    
    var lbl_password = UILabel()
    var txt_password = UITextField()
    
    var btnLogin : UIButton = UIButton()
    var btnForGotPswd : UIButton = UIButton()
    var btnSignUp : UIButton = UIButton()
    
    var parameters = [String:Any]()
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.backgroundImgView.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        self.backgroundImgView.image = UIImage.init(named: "Background_Image.png")
        self.view.addSubview(self.backgroundImgView)
        
        loginView.frame = CGRect(x: 10 * WIDTHTHEME, y: 250 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 100 * HEIGHTTHEME)
        loginView.layer.borderWidth = 1
        loginView.layer.borderColor = UIColor.lightGray.cgColor
        loginView.backgroundColor = UIColor.white
        
        
        var view1 = UIView()
        view1.frame = CGRect(x: 20 * WIDTHTHEME, y: 200 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        //view1.backgroundColor = UIColor.blue
        backgroundImgView.addSubview(view1)
        
        lbl_email.frame = CGRect(x: 20 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 30 * HEIGHTTHEME)
        lbl_email.backgroundColor = UIColor.clear
        lbl_email.font = UIFont(name: "Avenir" , size: 14 * WIDTHTHEME);
        lbl_email.isHidden = true
        //lbl_email.text = "Email"
        lbl_email.textColor = UIColor.red
        view1.addSubview(lbl_email)
        txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])

        txt_email.delegate = self
        txt_email.frame = CGRect(x: 10 * WIDTHTHEME, y: 1 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_email.font = UIFont(name: "Avenir" , size: 14 * HEIGHTTHEME);
        txt_email.autocapitalizationType = .none

        //txt_email.layer.borderWidth = 1
        //txt_email.layer.borderColor = UIColor.lightGray.cgColor
        loginView.addSubview(txt_email)
        
        
        lbl_password.frame = CGRect(x: 0, y: 50 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_password.backgroundColor = UIColor.lightGray
        //lbl_password.text = "Password"
        //lbl_password.font = UIFont(name: "Avenir" , size: 14 * WIDTHTHEME);
        //lbl_password.textColor = UIColor.white
        
        txt_password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_password.delegate = self
        txt_password.frame = CGRect(x: 10 * WIDTHTHEME, y: 55 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME) , height: 40 * HEIGHTTHEME)
        txt_password.font = UIFont(name: "Avenir" , size: 14 * HEIGHTTHEME);
        txt_password.isSecureTextEntry = true
        txt_password.autocapitalizationType = .none
        //txt_password.layer.borderWidth = 1
        //txt_password.layer.borderColor = UIColor.lightGray.cgColor
        txt_password.backgroundColor = UIColor.white
        txt_password.textColor = UIColor.black
        loginView.addSubview(lbl_password)
        loginView.addSubview(txt_password)
        view.addSubview(loginView)
        
        btnLogin.frame = CGRect(x: 10 * WIDTHTHEME, y: 360 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btnLogin.backgroundColor = PinkBtnColor
        btnLogin.setTitle("Login", for: UIControlState.normal)
        btnLogin.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnLogin.tag = 1
        btnLogin.layer.cornerRadius = 5
        view.addSubview(btnLogin)
        
        btnSignUp.frame = CGRect(x: 10 * WIDTHTHEME, y: 410 * HEIGHTTHEME, width: (80 * WIDTHTHEME), height: 20 * HEIGHTTHEME)
        btnSignUp.backgroundColor = UIColor.clear
        btnSignUp.setTitle("Sign Up", for: UIControlState.normal)
        btnSignUp.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btnSignUp.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnSignUp.contentHorizontalAlignment = .left
        btnSignUp.tag = 2
        view.addSubview(btnSignUp)
        
        btnForGotPswd.frame = CGRect(x: 215 * WIDTHTHEME, y: 410 * HEIGHTTHEME, width: (150 * WIDTHTHEME), height: 20 * HEIGHTTHEME)
        btnForGotPswd.backgroundColor = UIColor.clear
        btnForGotPswd.contentHorizontalAlignment = .right
        btnForGotPswd.titleLabel?.textAlignment = NSTextAlignment.right
        btnForGotPswd.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btnForGotPswd.setTitle("Forgot Password?", for: UIControlState.normal)
        btnForGotPswd.tag = 3
        btnForGotPswd.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(btnForGotPswd)
        
        
        // You can pass in custom error messages to regex rules (such as ZipCodeRule and EmailRule)
        validator.registerField(txt_email, errorLabel: lbl_email, rules: [RequiredRule(), EmailRule()])
        validator.registerField(txt_password, errorLabel: lbl_email, rules: [RequiredRule(), MinLengthRule(length: 9)])

        
        
        //getImagesData()
        //autoLogin()
    }
    
    
//    func getImagesData()
//    {
//        var marrStudentData = NSMutableArray()
//        marrStudentData = ModelManager.getInstance().getAllData()
//        print(marrStudentData)
//        
//    }
    
    func autoLogin() {
        
        self.txt_email.text = "prasannakumar367@gmail.com"
        self.txt_password.text = "CzGRuJ"
        
        loginRequest()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ValidationDelegate methods
    
    func validationSuccessful() {
        // submit the form
        
        lbl_email.isHidden = true
        
    }
    
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]){
        
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
        
    }
   
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        //let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        //let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        UserDefaults.standard.set("true", forKey: "isLogged")
        UserDefaults.standard.synchronize()
        
        
        let mainViewController = MainViewController(nibName:nil, bundle: nil)
        let leftViewController = LeftViewController(nibName:nil, bundle: nil)
        let rightViewController = RightViewController(nibName:nil, bundle: nil)
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        delegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        delegate.window?.rootViewController = slideMenuController
        delegate.window?.makeKeyAndVisible()
        
        }
    
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            
            loginRequest()
            
        } else if sender.tag == 2 {
            
            let signupVC = SignUpViewController(nibName:nil, bundle: nil)
            self.navigationController?.pushViewController(signupVC, animated: true)
        } else if sender.tag == 3 {
            let forgotVC = ForgotPswdViewController(nibName:nil, bundle: nil)
            self.navigationController?.pushViewController(forgotVC, animated: true)
        }
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        //self.contentSize = CGSize(width: SCREENWIDTH, height: SCREENHEIGHT - 150)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //self.contentSize = CGSize(width: SCREENWIDTH, height: SCREENHEIGHT)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txt_email.resignFirstResponder()
        txt_password.resignFirstResponder()
        return true
    }
    
    func loginRequest() {
        
        
        var email = NSString()
        var pswd = NSString()
        
        
        if self.txt_email.text?.length == 0 {
            
            //alert.alertView(titleText: "Email", messageText: "Email cannot be blank.",)
            mbUtils.alertView(titleText: "Email", messageText: "Email cannot be blank.", viewcontoller: self)
            return
            
        } else {
            
            if  mbUtils.isValidEmail(testStr: self.txt_email.text!) {
                print("Validate EmailID")
                email = self.txt_email.text! as NSString
            } else{
                mbUtils.alertView(titleText: "Email", messageText: "Invalid email.", viewcontoller: self)
                return
            }
            
        }
        
        
        if self.txt_password.text?.length == 0 {
            
            //alert.alertView(titleText: "Password", messageText: "Password cannot be blank.")
            mbUtils.alertView(titleText: "Password", messageText: "Password cannot be blank.", viewcontoller: self)

            return
        } else {
            
            if (self.txt_password.text?.length)! > 5 {
                pswd = self.txt_password.text! as NSString
            } else {
                mbUtils.alertView(titleText: "Password", messageText: "Please Enter at least 6 characters password.", viewcontoller: self)
                return
            }
            
        }
        
        //let params: Parameters = ["device_id":"APA91bGKV95P8jpYPlRCSHSkC1ZYA-Py3TWhYFL4ZGgcIUFlWiI-2yteOwJgi8aySLpaBKsUy-wOkhX8kCQmdOQbB3BKgus0h4xDd9dpxdBqXmyV84De3RrRC70sd7EVdTlK_1-lXI7t","device_type":"1","customer_email":"prasannakumar367@gmail.com","customer_password":"tmltttp367"]
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "Logging in"
        
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        NSLog("Device Id = %@", Identifier! as String)
        
        let params: Parameters = ["device_id":Identifier! as String, "device_type":"1","customer_email": email,"customer_password": pswd]
        
        Alamofire.request(BASEAPI + LOGIN_API_POST, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            
            switch(response.result) {
                
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    
                    
                    let tutorial = TutorialViewController()
                    tutorial.loadYoutube(videoID: "YLvKVginiWU")
                    
                    
                    
                    
                    
                    let res_dict : NSDictionary = response.result.value as! NSDictionary
                    
                    let str_Status = res_dict.value(forKey: "status") as! String
                    
                    if (str_Status == "failure") {
                        self.mbUtils.alertView(titleText: "Problem", messageText: res_dict.value(forKey: "message") as! String, viewcontoller: self)
                        return
                    } else {
                        
                        UserDefaults.standard.set(res_dict, forKey: "user_data")
                        
                        self.createMenuView()
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                self.mbUtils.alertView(titleText: "Problem", messageText: response.description, viewcontoller: self)
                break
                
            }
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








