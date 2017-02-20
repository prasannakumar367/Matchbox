//
//  TutorialViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 08/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    var lblLoding = UILabel()
    var wv = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblLoding.frame = CGRect(x: 100 * WIDTHTHEME, y: HEIGHTTHEME / 2, width: SCREENWIDTH - (200  * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        lblLoding.textColor = UIColor.white
        lblLoding.numberOfLines = 2
        lblLoding.font = UIFont(name: "Avenir", size: (16 * HEIGHTTHEME))
        lblLoding.textAlignment = NSTextAlignment.center
        lblLoding.text = "Loading"
        lblLoding.backgroundColor = UIColor.clear
        self.view.addSubview(lblLoding)
        
        wv.frame = CGRect(x: 10 * WIDTHTHEME, y: 150 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 355 * HEIGHTTHEME)
        self.view.addSubview(wv)
        
        // load your you tube video ID
        loadYoutube(videoID: "YLvKVginiWU")
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        wv.scrollView.contentInset = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadYoutube(videoID:String) {
        // create a custom youtubeURL with the video ID
        
        
        let youtubeURL = NSURL(string: "https://www.youtube.com/embed/\(videoID)")
        wv.loadRequest( NSURLRequest(url: youtubeURL as! URL) as URLRequest )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem()
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
