//
//  PageOne.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 15/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class PageOne: UIViewController {

    // the tofu
    var imageView: UIImageView! = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(red: 106.0/255.0, green: 27.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
        
        let textBackGroundView = UIView()
        textBackGroundView.backgroundColor = PurpleBtnColor
        textBackGroundView.frame = CGRect(x:0, y:0, width: SCREENWIDTH, height: 100)
        self.view.addSubview(textBackGroundView)
        
        let rect = CGRect(x: 70, y: 30, width: SCREENWIDTH - 140, height: 60) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir", size: 16)
        label.textAlignment = NSTextAlignment.center
        label.text = "Click or share pictures from other Apps into MatchBox"
        label.backgroundColor = UIColor.clear
        textBackGroundView.addSubview(label)
        
        imageView.frame = CGRect(x: 0, y: 150, width: SCREENWIDTH, height: 450)
        imageView.image = UIImage.init(named: "tour_2_screen_Image.png")
        self.view.addSubview(imageView)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
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
