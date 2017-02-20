//
//  ForgotPswdViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 22/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPswdViewController: UIViewController, UITextFieldDelegate {

    let mbUtils = MBUtils()
    
    var backgroundImgView = UIImageView()
    var loginView : UIView! = UIView()
    
    var txt_email = UITextField()
    var btnSubmit : UIButton = UIButton()
    
    var btnCancel : UIButton = UIButton()
    
    var lbl_forGotName = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backgroundImgView.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        self.backgroundImgView.image = UIImage.init(named: "Background_Image.png")
        self.view.addSubview(self.backgroundImgView)
        
        lbl_forGotName.frame = CGRect(x: (10 * WIDTHTHEME), y: 275 * HEIGHTTHEME, width: (160 * WIDTHTHEME), height: 25 * HEIGHTTHEME)
        lbl_forGotName.textColor = UIColor.white
        lbl_forGotName.backgroundColor = UIColor.clear
        lbl_forGotName.text = "Forgot password"
        lbl_forGotName.font = UIFont(name: "Avenir-Book", size: (14 * HEIGHTTHEME))
        view.addSubview(lbl_forGotName)
        
        
        loginView.frame = CGRect(x: 10 * WIDTHTHEME, y: 300 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        loginView.layer.borderWidth = 1
        loginView.layer.borderColor = UIColor.lightGray.cgColor
        loginView.backgroundColor = UIColor.white
        
        txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        txt_email.delegate = self
        txt_email.frame = CGRect(x: (10 * WIDTHTHEME), y: 0 * HEIGHTTHEME, width: loginView.frame.size.width - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        txt_email.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        txt_email.autocapitalizationType = .none
        //txt_email.layer.borderWidth = 1
        //txt_email.layer.borderColor = UIColor.lightGray.cgColor
        loginView.addSubview(txt_email)
        view.addSubview(loginView)
        
        
        btnCancel.frame = CGRect(x: 10 * WIDTHTHEME, y: 355 * HEIGHTTHEME, width: (170 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btnCancel.backgroundColor = PinkBtnColor
        btnCancel.setTitle("Cancel", for: UIControlState.normal)
        btnCancel.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btnCancel.tag = 1
        btnCancel.titleLabel!.font =  UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        btnCancel.layer.cornerRadius = 4
        view.addSubview(btnCancel)
        
        btnSubmit.frame = CGRect(x: 195 * WIDTHTHEME, y: 355 * HEIGHTTHEME, width: (170 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btnSubmit.backgroundColor = PurpleBtnColor
        btnSubmit.setTitle("Submit", for: UIControlState.normal)
        btnSubmit.titleLabel!.font =  UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        btnSubmit.layer.cornerRadius = 4
        btnSubmit.tag = 2
        btnSubmit.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(btnSubmit)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            self.navigationController?.popViewController(animated: true)
        } else if sender.tag == 2 {
            
            txt_email.resignFirstResponder()
            ApiRequestForForgotPassword()
            
            //self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        txt_email.resignFirstResponder()
        return true
    }

    func ApiRequestForForgotPassword() {
        var email = NSString()
        
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

        
        let params: Parameters = ["customer_email": email]
        
        Alamofire.request(BASEAPI + FORGOTPASSWORD_API_POST, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    
                    let res_dict : NSDictionary = response.result.value as! NSDictionary
                    
                    let str_Status = res_dict.value(forKey: "status") as! String
                    
                    if (str_Status == "failure") {
                        self.mbUtils.alertView(titleText: "Problem", messageText: "Not registred email.", viewcontoller: self)
                        return
                    } else {
                        self.mbUtils.alertView(titleText: "Problem", messageText: res_dict.value(forKey: "message") as! String, viewcontoller: self)
                        self.navigationController?.popViewController(animated: true)
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
