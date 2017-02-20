//
//  ImagePickerViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 01/11/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var actionText = NSString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let btnCamera = UIButton()
//        btnCamera.frame = CGRect(x: 320 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 40 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
//        btnCamera.backgroundColor = UIColor.red
//        //btnCamera.setImage(UIImage(named:"camera"), for: UIControlState.normal)
//        btnCamera.tag = 5
//        btnCamera.layer.cornerRadius = 3
//        btnCamera.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
//        view.addSubview(btnCamera)
//        
//        let btnGallery = UIButton()
//        btnGallery.frame = CGRect(x: 270 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 40 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
//        btnGallery.backgroundColor = UIColor.blue
//        //btnGallery.setImage(UIImage(named:"ic_gallery"), for: UIControlState.normal)
//        btnGallery.tag = 6
//        btnGallery.layer.cornerRadius = 3
//        btnGallery.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
//        view.addSubview(btnGallery)
        
        // Do any additional setup after loading the view.
        //imageView.frame = CGRect(x: 100, y: 100, width: SCREENWIDTH - 200, height: 350)
        //self.view.addSubview(imageView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        imageView.frame = CGRect(x: 100, y: 100, width: SCREENWIDTH - 200, height: 350)
        self.view.addSubview(imageView)
    }
    

    //MARK: - Delegates
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ShootPhoto() {
        
        
    }
    
    func GoToLibrary(){
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
        
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
