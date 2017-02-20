//
//  SignUpViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 15/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SwiftValidator
import CoreLocation
import MBProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var validator = Validator()
    let mbUtils = MBUtils()
    
    
    var latitude = String()
    var longitude = String()
    var email = NSString()
    var pswd = NSString()
    var dob_str = NSString()
    
    
    var scrollView = UIScrollView()
    
    var backgroundImgView = UIImageView()
    var loginView : UIView! = UIView()
    
    var lbl_name = UILabel()
    var txt_name = UITextField()
    
    var txt_email = UITextField()
    
    var lbl_password = UILabel()
    var txt_password = UITextField()
    
    var lbl_dateOfBirth = UILabel()
    var txt_dateOfBirth = UITextField()
    
    var lbl_genderLine = UILabel()
    var lbl_gender = UILabel()
    var btnMaleGender : UIButton = UIButton()
    var btnFemaleGender : UIButton = UIButton()
    
    var lbl_termsLine = UILabel()
    var btn_checkBox = UIButton()
    var lbl_terms = UILabel()
    var btn_conditions : UIButton = UIButton()
    
    
    var btnCancel : UIButton = UIButton()
    var btnSignUp : UIButton = UIButton()
    
    var genderChecked = NSNumber()
    
    
    var checkbox = CheckboxButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        
        IQKeyboardManager.sharedManager().enable = true
        
       
        
        
        self.backgroundImgView.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        self.backgroundImgView.image = UIImage.init(named: "Background_Image.png")
        self.view.addSubview(self.backgroundImgView)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        
        loginView.frame = CGRect(x: 10 * WIDTHTHEME, y: 130 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 320 * HEIGHTTHEME)
        loginView.layer.borderWidth = 1
        loginView.layer.borderColor = UIColor.lightGray.cgColor
        loginView.backgroundColor = UIColor.white
        
        txt_name.attributedPlaceholder = NSAttributedString(string:"Name", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_name.delegate = self
        txt_name.frame = CGRect(x: 10 * WIDTHTHEME, y: 0 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_name.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        loginView.addSubview(txt_name)
        
        lbl_name.frame = CGRect(x: 0, y: 50 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_name.backgroundColor = UIColor.lightGray
        loginView.addSubview(lbl_name)
        
        txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_email.delegate = self
        txt_email.frame = CGRect(x: 10 * WIDTHTHEME, y: 55 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_email.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_email.autocapitalizationType = .none
        txt_email.autocorrectionType = UITextAutocorrectionType.no
        loginView.addSubview(txt_email)
        
        lbl_password.frame = CGRect(x: 0, y: 105 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_password.backgroundColor = UIColor.lightGray
        
        txt_password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_password.delegate = self
        txt_password.frame = CGRect(x: 10 * WIDTHTHEME, y: 110 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME) , height: 45 * HEIGHTTHEME)
        txt_password.isSecureTextEntry = true
        txt_password.backgroundColor = UIColor.white
        txt_password.textColor = UIColor.black
        txt_password.autocapitalizationType = .none
        txt_password.autocorrectionType = UITextAutocorrectionType.no
        txt_password.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        
        
        
        loginView.addSubview(lbl_password)
        loginView.addSubview(txt_password)
        
        
        
        lbl_dateOfBirth.frame = CGRect(x: 0, y: 160 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_dateOfBirth.backgroundColor = UIColor.lightGray
        loginView.addSubview(lbl_dateOfBirth)
        
        txt_dateOfBirth.attributedPlaceholder = NSAttributedString(string:"Date Of Birth (2016-01-20) (Optional)", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_dateOfBirth.delegate = self
        txt_dateOfBirth.frame = CGRect(x: 10 * WIDTHTHEME, y: 165 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_dateOfBirth.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_dateOfBirth.autocorrectionType = UITextAutocorrectionType.no
        loginView.addSubview(txt_dateOfBirth)
        
        lbl_genderLine.frame = CGRect(x: 0, y: 215 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_genderLine.backgroundColor = UIColor.lightGray
        loginView.addSubview(lbl_genderLine)
        
        
        lbl_gender.frame = CGRect(x: 10 * WIDTHTHEME, y: 220 * HEIGHTTHEME, width: 120 * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        lbl_gender.backgroundColor = UIColor.clear
        lbl_gender.textColor = UIColor.lightGray
        lbl_gender.text = "Gender (Optional)"
        lbl_gender.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        loginView.addSubview(lbl_gender)
        
        
        btnMaleGender.frame = CGRect(x: 150 * WIDTHTHEME, y: 225 * HEIGHTTHEME, width: (30 * WIDTHTHEME), height: 30 * HEIGHTTHEME)
        //btnMaleGender.backgroundColor = PinkBtnColor
        //btnMaleGender.setTitle("Cancel", for: UIControlState.normal)
        btnMaleGender.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnMaleGender.tag = 1
        btnMaleGender.layer.cornerRadius = 4
        btnMaleGender.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
        //btnMaleGender.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btnMaleGender.tintColor = UIColor.red
        loginView.addSubview(btnMaleGender)
        
        btnFemaleGender.frame = CGRect(x: 250 * WIDTHTHEME, y: 225 * HEIGHTTHEME, width: (30 * WIDTHTHEME), height: 30 * HEIGHTTHEME)
        //btnFemaleGender.backgroundColor = PinkBtnColor
        //btnFemaleGender.setTitle("Cancel", for: UIControlState.normal)
        btnFemaleGender.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnFemaleGender.tag = 2
        btnFemaleGender.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)
        btnFemaleGender.layer.cornerRadius = 4
        loginView.addSubview(btnFemaleGender)
        
        
//        var lbl_termsLine = UILabel()
//        var btn_checkBox = UIButton()
//        var lbl_terms = UILabel()
//        var btn_conditions = UIButton()
        
        lbl_termsLine.frame = CGRect(x: 0, y: 270 * HEIGHTTHEME, width: loginView.frame.size.width , height: 1 * HEIGHTTHEME)
        lbl_termsLine.backgroundColor = UIColor.lightGray
        loginView.addSubview(lbl_termsLine)
        
        
        checkbox.backgroundColor = UIColor.white
        checkbox.containerLineWidth = 1.0
        checkbox.checkColor = UIColor(hex: "009688")
        //checkBox.containerColor = PinkBtnColor
        checkbox.frame = CGRect(x: 20 * WIDTHTHEME, y: 280 * HEIGHTTHEME, width: (25 * WIDTHTHEME), height: 25 * HEIGHTTHEME)
        loginView.addSubview(checkbox)
        
        
//        btn_checkBox.frame = CGRect(x: 20 * WIDTHTHEME, y: 278 * HEIGHTTHEME, width: (25 * WIDTHTHEME), height: 25 * HEIGHTTHEME)
//        btn_checkBox.backgroundColor = PinkBtnColor
//        //btnFemaleGender.setTitle("Cancel", for: UIControlState.normal)
//        btn_checkBox.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
//        //btnFemaleGender.tag = 1
//        btn_checkBox.setBackgroundImage(image1, for: UIControlState.normal)
//        btn_checkBox.layer.cornerRadius = 4
//        loginView.addSubview(btn_checkBox)
        
        lbl_terms.frame = CGRect(x: (55 * WIDTHTHEME), y: 280 * HEIGHTTHEME, width: 160 * WIDTHTHEME, height: 25 * HEIGHTTHEME)
        lbl_terms.textColor = UIColor.lightGray
        lbl_terms.backgroundColor = UIColor.clear
        lbl_terms.text = "I agree to MatchBox"
        lbl_terms.font = UIFont(name: "Avenir-Book", size: (14 * HEIGHTTHEME))
        loginView.addSubview(lbl_terms)
        
        btn_conditions.frame = CGRect(x: 180 * WIDTHTHEME, y: 280 * HEIGHTTHEME, width: (150 * WIDTHTHEME), height: 25 * HEIGHTTHEME)
        btn_conditions.titleLabel!.font =  UIFont(name: "Avenir-Book", size: (14 * HEIGHTTHEME))
        btn_conditions.titleLabel?.textAlignment = NSTextAlignment.left
        btn_conditions.setTitle("Terms and Conditions.", for: UIControlState.normal)
        btn_conditions.setTitleColor(PinkBtnColor, for: UIControlState.normal)
        btn_conditions.tag = 5
        btn_conditions.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        loginView.addSubview(btn_conditions)
        scrollView.addSubview(loginView)

        
        btnCancel.frame = CGRect(x: 15 * WIDTHTHEME, y: 460 * HEIGHTTHEME, width: (165 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btnCancel.backgroundColor = PinkBtnColor
        btnCancel.setTitle("Cancel", for: UIControlState.normal)
        btnCancel.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnCancel.tag = 3
        btnCancel.titleLabel!.font =  UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        btnCancel.layer.cornerRadius = 4
        scrollView.addSubview(btnCancel)
        
        btnSignUp.frame = CGRect(x: 195 * WIDTHTHEME, y: 460 * HEIGHTTHEME, width: (165 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btnSignUp.backgroundColor = PurpleBtnColor
        btnSignUp.setTitle("Sign Up", for: UIControlState.normal)
        btnSignUp.titleLabel!.font =  UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        btnSignUp.layer.cornerRadius = 4
        btnSignUp.tag = 4
        btnSignUp.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        //btnSignUp.contentHorizontalAlignment = .center
        scrollView.addSubview(btnSignUp)
        
        
        view.addSubview(scrollView)
        
        }
    
    //override func loadView()
    //{
    //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.view = scrollView;
    //}
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
          
            
            btnMaleGender.setBackgroundImage(UIImage(named: "male_img"), for: UIControlState.normal)
            btnFemaleGender.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)

            
            
            genderChecked = 0
            
        } else if sender.tag == 2 {
            
            
            //let image3 = UIImage(named: "male_gray")
            //let image4 = UIImage(named: "female_img")
            
            btnMaleGender.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
            btnFemaleGender.setBackgroundImage(UIImage(named: "female_img"), for: UIControlState.normal)
            
            
            genderChecked = 1
            
        } else if sender.tag == 3 {
            //let accountVC = AccountViewController(nibName:nil, bundle: nil)
            self.navigationController?.popViewController(animated: true)
        } else if sender.tag == 4 {
            
            
            //let loginVC = LoginViewController(nibName:nil, bundle: nil)
            //self.navigationController?.pushViewController(loginVC, animated: true)
            
            //LoginView
            
            validateForm()

        } else if sender.tag == 5 {
            if let url = NSURL(string: "http://matchboxapp.co/privacy-policy.html"){
                UIApplication.shared.openURL(url as URL)
            }
        }
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.scrollView.contentSize = CGSize(width: SCREENWIDTH, height: SCREENHEIGHT - 150)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.scrollView.contentSize = CGSize(width: SCREENWIDTH, height: SCREENHEIGHT)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        txt_name.resignFirstResponder()
        txt_email.resignFirstResponder()
        txt_password.resignFirstResponder()
        txt_dateOfBirth.resignFirstResponder()
        
        return true
    }
    
    func validateForm() {
        
       
        
        
        if txt_name.text?.length == 0 {

            mbUtils.alertView(titleText: "Name", messageText: "Please enter name.", viewcontoller: self)
            return
        }
        
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
        
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        var datestring = txt_dateOfBirth.text
        
        if txt_dateOfBirth.text?.length == 0 {
            datestring = "2017-02-14"
        }
        
        let date = RFC3339DateFormatter.date(from: datestring!)
        let strdate = RFC3339DateFormatter.string(from: date!)
        dob_str = strdate as NSString
        
        
        
        if !(genderChecked == 0) && !(genderChecked == 1){
            genderChecked = 1
        }
        
        if !checkbox.on {
            mbUtils.alertView(titleText: "TC", messageText: "Please accept Terms and Conditions to continue", viewcontoller: self)
            return
        }
        
        
        if (self.latitude.length == 0 || self.longitude.length == 0) {
            
            LocationManager.sharedInstance.getLocation { (location:CLLocation?, error:NSError?) in
                
                if error != nil {
                    
                    //self.mbUtils.alertView(titleText: "Location", messageText: (error?.localizedDescription)!, viewcontoller: self)
                    
                    self.latitude = "37.785834"
                    self.longitude = "-122.406417"
                    self.signUpServiceRequest()
                    return
                }
                
                guard let _ = location else {
                    
                    self.mbUtils.alertView(titleText: "Location", messageText: "Unable to fetch location", viewcontoller: self)
                    return
                }
                
                self.latitude = "\((location?.coordinate.latitude)!)"
                self.longitude = "\((location?.coordinate.longitude)!)"
                
                self.signUpServiceRequest()
            }
        } else {
            self.signUpServiceRequest()
        }
        
        
    }
    
    func signUpServiceRequest() {
        
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "SignUp.."
        
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        NSLog("Device Id = %@", Identifier! as String)
        
        let params: Parameters = ["device_id":Identifier! as String, "device_type":"1","customer_name": txt_name.text, "customer_email": email,"customer_password": pswd, "customer_dob": dob_str, "customer_gender": genderChecked, "latitude": latitude, "longitude": longitude]
        
        Alamofire.request(BASEAPI + SIGNUP_API_POST, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            
            switch(response.result) {
                
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    
                    let res_dict : NSDictionary = response.result.value as! NSDictionary
                    
                    let str_Status = res_dict.value(forKey: "status") as! String
                    
                    if (str_Status == "failure") {
                        self.mbUtils.alertView(titleText: "Problem", messageText: res_dict.value(forKey: "message") as! String, viewcontoller: self)
                        return
                    } else {
                        
                        self.mbUtils.alertView(titleText: "Success", messageText: "You have registered successfully.", viewcontoller: self)
                        
                        self.txt_name.text = nil
                        self.txt_dateOfBirth.text = nil
                        self.btnMaleGender.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
                        self.btnFemaleGender.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)
                        self.txt_password.text = nil
                        self.txt_email.text = nil
                        
                        self.backtoNavigate()
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
    
    
    func backtoNavigate() {
        
        let loginVC = LoginViewController(nibName:nil, bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
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

