//
//  ProfileViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 07/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftValidator
import MBProgressHUD


class ProfileViewController: UIViewController, UITextFieldDelegate {

    var view_title = UIView()
    var lbl_title = UILabel()
    var validator = Validator()
    let mbUtils = MBUtils()
    var pswd = NSString()
    var genderChecked = NSNumber()
    var dob_str = NSString()
    
    var user_dataDict = NSMutableDictionary()
    var userData = NSMutableDictionary()
    
    var view_profileBgView = UIView()
    var lbl_profile = UILabel()
    
    var txt_userName = UITextField()
    
    var line_gender = UILabel()
    var lbl_gender = UILabel()
    var btn_male = UIButton()
    var btn_female = UIButton()
    
    var line_skin = UILabel()
    var lbl_skinColor = UILabel()
    var btn_dusky = UIButton()
    var btn_medium = UIButton()
    var btn_fair = UIButton()
    
    var line_dateOfBirth = UILabel()
    var lbl_dobTitle = UILabel()
    var txt_dateOfBirth = UITextField()
    
    var btn_updateProfile = UIButton()
    
    var view_changePwdBgView = UIView()
    var btn_changePswd = UIButton()
    
    var lbl_chpswdTitle = UILabel()
    var txt_oldPassword = UITextField()
    var line_oldPwd = UILabel()
    var txt_newPassword = UITextField()
    var line_newPwd = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue:239.0/255.0, alpha: 1.0)
        
        view_title.frame = CGRect(x: 0, y: 64 * HEIGHTTHEME, width: SCREENWIDTH, height: 60 * HEIGHTTHEME)
        view_title.backgroundColor = PurpleBtnColor
        
        let rect1 = CGRect(x: 10, y: 20 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 40) // CGFloat, Double, Int
        lbl_title.frame = rect1
        lbl_title.textColor = UIColor.white
        lbl_title.textAlignment = NSTextAlignment.center
        lbl_title.text = "Hello Prasanna kumar"
        lbl_title.font = UIFont(name: "Avenir-Bold", size: (14  * WIDTHTHEME))
        lbl_title.backgroundColor = UIColor.clear
        view_title.addSubview(lbl_title)
        self.view.addSubview(view_title)
        
        view_profileBgView.frame = CGRect(x: 10, y: 170 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 180 * HEIGHTTHEME)
        view_profileBgView.backgroundColor = UIColor.white
        
        lbl_profile.frame = CGRect(x: 5 * WIDTHTHEME, y: 0, width: 100 * WIDTHTHEME, height: 30 * HEIGHTTHEME)
        lbl_profile.textColor = UIColor.black
        lbl_profile.textAlignment = NSTextAlignment.left
        lbl_profile.text = "My Profile"
        lbl_profile.font = UIFont(name: "Avenir", size: (14  * HEIGHTTHEME))
        lbl_profile.backgroundColor = UIColor.clear
        view_profileBgView.addSubview(lbl_profile)
        
        txt_userName.attributedPlaceholder = NSAttributedString(string:"Name", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_userName.delegate = self
        txt_userName.frame = CGRect(x: 5 * WIDTHTHEME, y: 20 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_userName.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_userName.autocorrectionType = .no
        view_profileBgView.addSubview(txt_userName)
        
        line_gender.frame = CGRect(x: 5, y: 65 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 1 * HEIGHTTHEME)
        line_gender.backgroundColor = UIColor.lightGray
        view_profileBgView.addSubview(line_gender)
        
        lbl_gender.frame = CGRect(x: 5 * WIDTHTHEME, y: 68 * HEIGHTTHEME, width: 100 * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        lbl_gender.backgroundColor = UIColor.clear
        lbl_gender.textColor = UIColor.black
        lbl_gender.text = "Gender"
        lbl_gender.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        view_profileBgView.addSubview(lbl_gender)
        
        let image = UIImage(named: "male_img")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0.5
        
        let image1 = UIImage(named: "female_img")
        let imageView1 = UIImageView(image: image1)
        imageView1.alpha = 0.5
        
        btn_male.frame = CGRect(x: 120 * WIDTHTHEME, y: 75 * HEIGHTTHEME, width: (30 * WIDTHTHEME), height: 30 * HEIGHTTHEME)
        btn_male.backgroundColor = PinkBtnColor
        //btnMaleGender.setTitle("Cancel", for: UIControlState.normal)
        btn_male.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_male.tag = 1
        btn_male.layer.cornerRadius = 4
        btn_male.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
        btn_male.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btn_male.tintColor = UIColor.red
        view_profileBgView.addSubview(btn_male)
        
        btn_female.frame = CGRect(x: 220 * WIDTHTHEME, y: 75 * HEIGHTTHEME, width: (30 * WIDTHTHEME), height: 30 * HEIGHTTHEME)
        btn_female.backgroundColor = PinkBtnColor
        //btnFemaleGender.setTitle("Cancel", for: UIControlState.normal)
        btn_female.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_female.tag = 2
        btn_female.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)
        btn_female.layer.cornerRadius = 4
        view_profileBgView.addSubview(btn_female)
        
        
        line_skin.frame = CGRect(x: 5, y: 115 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 1 * HEIGHTTHEME)
        line_skin.backgroundColor = UIColor.lightGray
        //view_profileBgView.addSubview(line_skin)
        
        lbl_skinColor.frame = CGRect(x: 5 * WIDTHTHEME, y: 117 * HEIGHTTHEME, width: 100 * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        lbl_skinColor.backgroundColor = UIColor.clear
        lbl_skinColor.textColor = UIColor.black
        lbl_skinColor.text = "Skin color"
        lbl_skinColor.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        //view_profileBgView.addSubview(lbl_skinColor)
        
        let image2 = UIImage(named: "male_img")
        let imageView2 = UIImageView(image: image2)
        imageView2.alpha = 1.0
        
        let image3 = UIImage(named: "female_img")
        let imageView3 = UIImageView(image: image3)
        imageView3.alpha = 1.0
        
        btn_dusky.frame = CGRect(x: 120 * WIDTHTHEME, y: 117 * HEIGHTTHEME, width: (40 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        btn_dusky.backgroundColor = PinkBtnColor
        //btnMaleGender.setTitle("Cancel", for: UIControlState.normal)
        btn_dusky.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        //btnMaleGender.tag = 1
        btn_dusky.layer.cornerRadius = 4
        //btn_dusky.setBackgroundImage(image, for: UIControlState.normal)
        btn_dusky.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btn_dusky.tintColor = UIColor.red
        //view_profileBgView.addSubview(btn_dusky)
        
        btn_medium.frame = CGRect(x: 180 * WIDTHTHEME, y: 117 * HEIGHTTHEME, width: (40 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        btn_medium.backgroundColor = PinkBtnColor
        //btnFemaleGender.setTitle("Cancel", for: UIControlState.normal)
        btn_medium.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        //btnFemaleGender.tag = 1
        btn_medium.setBackgroundImage(image1, for: UIControlState.normal)
        btn_medium.layer.cornerRadius = 4
        //view_profileBgView.addSubview(btn_medium)
        
        
        btn_fair.frame = CGRect(x: 240 * WIDTHTHEME, y: 117 * HEIGHTTHEME, width: (40 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        btn_fair.backgroundColor = PinkBtnColor
        //btnMaleGender.setTitle("Cancel", for: UIControlState.normal)
        btn_fair.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        //btnMaleGender.tag = 1
        btn_fair.layer.cornerRadius = 4
        //btn_dusky.setBackgroundImage(image, for: UIControlState.normal)
        btn_fair.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btn_fair.tintColor = UIColor.red
        //view_profileBgView.addSubview(btn_fair)
        
        
        line_dateOfBirth.frame = CGRect(x: 5, y: 120 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 1 * HEIGHTTHEME)
        line_dateOfBirth.backgroundColor = UIColor.lightGray
        view_profileBgView.addSubview(line_dateOfBirth)
        
//        lbl_dobTitle.frame = CGRect(x: 5, y: 122 * HEIGHTTHEME, width: view_profileBgView.frame.size.width  - (10 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
//        lbl_dobTitle.text = "DOB"
//        lbl_dobTitle.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
//        lbl_dobTitle.textColor = UIColor.black
//        lbl_dobTitle.backgroundColor = UIColor.clear
//        view_profileBgView.addSubview(lbl_dobTitle)
        
        
//        btn_dateOfBirth.frame = CGRect(x: 80 * WIDTHTHEME, y: 132 * HEIGHTTHEME, width: (250 * WIDTHTHEME), height: 20 * HEIGHTTHEME)
//        btn_dateOfBirth.backgroundColor = UIColor.clear
//        btn_dateOfBirth.setTitle("Select DOB", for: UIControlState.normal)
//        btn_dateOfBirth.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
//        //btnMaleGender.tag = 1
//        btn_dateOfBirth.titleLabel?.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
//        btn_dateOfBirth.titleLabel?.textColor = UIColor.gray
//        btn_dateOfBirth.layer.cornerRadius = 4
//        //btn_dateOfBirth.setBackgroundImage(image, for: UIControlState.normal)
//        btn_dateOfBirth.imageView?.image?.withRenderingMode(.alwaysTemplate)
//        btn_dateOfBirth.tintColor = UIColor.red
//        view_profileBgView.addSubview(btn_dateOfBirth)
        
        
        txt_dateOfBirth.attributedPlaceholder = NSAttributedString(string:"Date Of Birth (2016-01-20)", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_dateOfBirth.delegate = self
        txt_dateOfBirth.frame = CGRect(x: 5 * WIDTHTHEME, y: 132 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_dateOfBirth.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_dateOfBirth.autocorrectionType = UITextAutocorrectionType.no
        view_profileBgView.addSubview(txt_dateOfBirth)
        
        
        view.addSubview(view_profileBgView)
        
        
        btn_updateProfile.frame = CGRect(x: 10 * WIDTHTHEME, y: 370 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        btn_updateProfile.backgroundColor = PinkBtnColor
        btn_updateProfile.setTitle("Update Profile", for: UIControlState.normal)
        btn_updateProfile.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_updateProfile.tag = 3
        btn_updateProfile.titleLabel?.font = UIFont(name: "Avenir-Regular", size: 14 * HEIGHTTHEME)
        btn_updateProfile.titleLabel?.textColor = UIColor.white
        btn_updateProfile.layer.cornerRadius = 4
        //btn_dateOfBirth.setBackgroundImage(image, for: UIControlState.normal)
        btn_updateProfile.imageView?.image?.withRenderingMode(.alwaysTemplate)
        view.addSubview(btn_updateProfile)
        
        
        view_changePwdBgView.frame = CGRect(x: 10, y: 430 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 120 * HEIGHTTHEME)
        view_changePwdBgView.backgroundColor = UIColor.white
        
        //////
        
        lbl_chpswdTitle.frame = CGRect(x: 5 * WIDTHTHEME, y: 0, width: 250 * WIDTHTHEME, height: 30 * HEIGHTTHEME)
        lbl_chpswdTitle.textColor = UIColor.black
        lbl_chpswdTitle.textAlignment = NSTextAlignment.left
        lbl_chpswdTitle.text = "Change Password"
        lbl_chpswdTitle.font = UIFont(name: "Avenir", size: (14  * HEIGHTTHEME))
        lbl_chpswdTitle.backgroundColor = UIColor.clear
        view_changePwdBgView.addSubview(lbl_chpswdTitle)
        
        txt_oldPassword.attributedPlaceholder = NSAttributedString(string:"Enter your current password", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_oldPassword.delegate = self
        txt_oldPassword.frame = CGRect(x: 5 * WIDTHTHEME, y: 25 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_oldPassword.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_oldPassword.isSecureTextEntry = true
        txt_oldPassword.autocapitalizationType = .none
        txt_oldPassword.autocorrectionType = UITextAutocorrectionType.no
        
        view_changePwdBgView.addSubview(txt_oldPassword)
        
        line_oldPwd.frame = CGRect(x: 5, y: 70 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 1 * HEIGHTTHEME)
        line_oldPwd.backgroundColor = UIColor.lightGray
        view_changePwdBgView.addSubview(line_oldPwd)
        
        
        txt_newPassword.attributedPlaceholder = NSAttributedString(string:"Enter your new password", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_newPassword.delegate = self
        txt_newPassword.frame = CGRect(x: 5 * WIDTHTHEME, y: 72 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_newPassword.isSecureTextEntry = true
        txt_newPassword.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        view_changePwdBgView.addSubview(txt_newPassword)
        
        
        line_newPwd.frame = CGRect(x: 5, y: 115 * HEIGHTTHEME, width: view_profileBgView.frame.size.width - (10 * WIDTHTHEME), height: 1 * HEIGHTTHEME)
        line_newPwd.backgroundColor = UIColor.lightGray
        view_changePwdBgView.addSubview(line_newPwd)
        
        btn_changePswd.frame = CGRect(x: 10 * WIDTHTHEME, y: 570 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        btn_changePswd.backgroundColor = PinkBtnColor
        btn_changePswd.setTitle("Change password", for: UIControlState.normal)
        btn_changePswd.addTarget(self, action: #selector(ProfileViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_changePswd.tag = 4
        btn_changePswd.titleLabel?.font = UIFont(name: "Avenir-Regular", size: 14 * HEIGHTTHEME)
        btn_changePswd.titleLabel?.textColor = UIColor.white
        btn_changePswd.layer.cornerRadius = 4
        //btn_dateOfBirth.setBackgroundImage(image, for: UIControlState.normal)
        btn_changePswd.imageView?.image?.withRenderingMode(.alwaysTemplate)
        view.addSubview(btn_changePswd)
        
        //////
        
        self.view.addSubview(view_changePwdBgView)
        
        let result = UserDefaults.standard.value(forKey: "user_data")
        print(result!)
        
        self.user_dataDict = result as! NSMutableDictionary
        userData = self.user_dataDict.value(forKey: "data") as! NSMutableDictionary
        var name_str : String = userData.value(forKey: "customer_name") as! String
        
        
        self.lbl_title.text = "Hello \(name_str)"
        
    }
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            //let accountVC = AccountViewController(nibName:nil, bundle: nil)
            //self.navigationController?.popViewController(animated: true)
            
            
            btn_male.setBackgroundImage(UIImage(named: "male_img"), for: UIControlState.normal)
            btn_female.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)
        
            genderChecked = 0
            
            
        } else if sender.tag == 2 {
            //let loginVC = LoginViewController(nibName:nil, bundle: nil)
            //self.navigationController?.pushViewController(loginVC, animated: true)
            
            
            btn_male.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
            btn_female.setBackgroundImage(UIImage(named: "female_img"), for: UIControlState.normal)
            
            
            genderChecked = 1
            
            
            
        } else if sender.tag == 3 {
            //Update profile.
            
            validateProfile()
            
        } else if sender.tag == 4 {
            
            //Change Password.
            validateChangePassword()
        }
        
        
    }
    
    
    func validateProfile() {
        
        if txt_userName.text?.length == 0 {
            mbUtils.alertView(titleText: "Name", messageText: "Please enter name.", viewcontoller: self)
            return
        }
        
        if genderChecked == 0 {
            
        } else if genderChecked == 1 {
            
        } else {
            mbUtils.alertView(titleText: "Gender", messageText: "Please select gender.", viewcontoller: self)
            return
        }
        
        if txt_dateOfBirth.text?.length == 0 {
            mbUtils.alertView(titleText: "Date of birth", messageText: "Please Enter date of birth.", viewcontoller: self)
            return
        } else {
            //let myDateString = txt_dateOfBirth.text! as String
            let RFC3339DateFormatter = DateFormatter()
            RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
            RFC3339DateFormatter.dateFormat = "yyyy-MM-dd"
            RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            let datestring = txt_dateOfBirth.text
            let date = RFC3339DateFormatter.date(from: datestring!)
            let strdate = RFC3339DateFormatter.string(from: date!)
            dob_str = strdate as NSString
        }
        
        updateProfileApiRequest()
    }
    
    
    func updateProfileApiRequest() {
        
        
//        getupdateprofile(@Field("customer_key") String mCustomerKey, @Field("customer_name") String mCustomerName,
//        @Field("customer_dob") String mCustomerDob, @Field("customer_gender") int mCustomerGender,
//        @Field("customer_skin_tone") int mCustomerSkinTone, @Field("customer_email") String mCustomerEmail,
//        Callback<RFUpdateProfile> mlogin);
        
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "Loading"
        
        let params: Parameters = ["customer_key": userData.value(forKey: "customer_key") as! String ,"customer_name": txt_userName.text! as String, "customer_email": userData.value(forKey: "customer_email") as! String, "customer_dob": dob_str, "customer_gender": genderChecked, "customer_skin_tone": "2"]
        
        Alamofire.request(BASEAPI + PROFILE_API_POST, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
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
                        
                        self.mbUtils.alertView(titleText: "Profile", messageText: res_dict.value(forKey: "message") as! String, viewcontoller: self)
                        
                        self.txt_userName.text = nil
                        self.txt_dateOfBirth.text = nil
                        self.btn_male.setBackgroundImage(UIImage(named: "male_gray"), for: UIControlState.normal)
                        self.btn_female.setBackgroundImage(UIImage(named: "female-avatar.jpg"), for: UIControlState.normal)
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
    
    
    
    func validateChangePassword() {
        
        if self.txt_oldPassword.text?.length == 0 {
            //alert.alertView(titleText: "Password", messageText: "Password cannot be blank.")
            mbUtils.alertView(titleText: "Password", messageText: "Password cannot be blank.", viewcontoller: self)
            return
        } else {
            if (self.txt_oldPassword.text?.length)! > 5 {
                pswd = self.txt_oldPassword.text! as NSString
            } else {
                mbUtils.alertView(titleText: "Old Password", messageText: "Please Enter at least 6 characters password.", viewcontoller: self)
                return
            }
        }
        
        if self.txt_oldPassword.text?.length == 0 {
            
            //alert.alertView(titleText: "Password", messageText: "Password cannot be blank.")
            mbUtils.alertView(titleText: "Password", messageText: "Password cannot be blank.", viewcontoller: self)
            return
        } else {
            if (self.txt_oldPassword.text?.length)! > 5 {
                pswd = self.txt_oldPassword.text! as NSString
            } else {
                mbUtils.alertView(titleText: "Old Password", messageText: "Please Enter at least 6 characters password.", viewcontoller: self)
                return
            }
        }
        
        
        
        updatePasswordServiceRequest()
        
    }
    
    
    func updatePasswordServiceRequest() {
        
        var key_str : String = userData.value(forKey: "customer_key") as! String
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "Loading"
        
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        NSLog("Device Id = %@", Identifier! as String)
        
        let params: Parameters = ["customer_key": key_str,"customer_password": txt_oldPassword.text! as String, "new_password": txt_newPassword.text! as String]
        
        Alamofire.request(BASEAPI + CHANGEPASSWORD_API_POST, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
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
                        
                        self.mbUtils.alertView(titleText: "Change Password", messageText: res_dict.value(forKey: "message") as! String, viewcontoller: self)
                        
                        self.txt_oldPassword.text = nil
                        self.txt_newPassword.text = nil
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
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem()
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
