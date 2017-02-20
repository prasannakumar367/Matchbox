//
//  FeedBackViewController.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 08/10/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController , UITextViewDelegate{

    
    
    var bg_view = UIView()
    var feedBack_textview = UITextView()
    var btn_submit = UIButton()
    
    let PLACEHOLDER_TEXT = "Enter your feedback."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Feedback"
        
        bg_view.backgroundColor = UIColor.white
        bg_view.frame = CGRect(x:10, y: 100 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 220 * HEIGHTTHEME)
        
        feedBack_textview.frame = CGRect(x:10, y: 40 * HEIGHTTHEME, width: bg_view.frame.size.width - (20 * WIDTHTHEME), height: 180 * HEIGHTTHEME)
        
        applyPlaceholderStyle(aTextview: feedBack_textview, placeholderText: PLACEHOLDER_TEXT)
        feedBack_textview.delegate = self
        feedBack_textview.increaseFontSize()
        
        self.bg_view.addSubview(feedBack_textview)
        self.view.addSubview(bg_view)
        
        let rect = CGRect(x: 10 * WIDTHTHEME, y: 2 * HEIGHTTHEME, width: bg_view.frame.size.width - (20  * WIDTHTHEME), height: 40 * HEIGHTTHEME) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textColor = PurpleBtnColor
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir-Bold", size: (16  * WIDTHTHEME))
        label.textAlignment = NSTextAlignment.left
        label.text = "Comments"
        label.backgroundColor = UIColor.clear
        bg_view.addSubview(label)
        
        let rect1 = CGRect(x: 10 * WIDTHTHEME, y: 35 * HEIGHTTHEME, width: bg_view.frame.size.width - (20  * WIDTHTHEME), height: 1 * HEIGHTTHEME) // CGFloat, Double, Int
        let label1 = UILabel()
        label1.frame = rect1
        label1.backgroundColor = UIColor.lightGray
        bg_view.addSubview(label1)
        
        let rect2 = CGRect(x: 10 * WIDTHTHEME, y: 235 * HEIGHTTHEME, width: bg_view.frame.size.width - (20  * WIDTHTHEME), height: 1 * HEIGHTTHEME) // CGFloat, Double, Int
        let label2 = UILabel()
        label2.frame = rect2
        label2.backgroundColor = UIColor.lightGray
        bg_view.addSubview(label2)
        
        btn_submit.frame = CGRect(x: 10 * WIDTHTHEME, y: 360 * HEIGHTTHEME, width: SCREENWIDTH - (20 * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btn_submit.backgroundColor = PinkBtnColor
        btn_submit.setTitle("Submit", for: UIControlState.normal)
        btn_submit.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_submit.tag = 1
        btn_submit.layer.cornerRadius = 4
        view.addSubview(btn_submit)
        
    }

    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            NSLog("Submited")
        }
        
    }
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String)
    {
        // make it look (initially) like a placeholder
        aTextview.textColor = UIColor.lightGray
        aTextview.text = placeholderText
    }
    
    func textViewShouldBeginEditing(_ aTextView: UITextView) -> Bool
    {
        if aTextView == feedBack_textview && aTextView.text == PLACEHOLDER_TEXT
        {
            // move cursor to start
            moveCursorToStart(aTextView: aTextView)
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // remove the placeholder text when they start typing
        // first, see if the field is empty
        // if it's not empty, then the text should be black and not italic
        // BUT, we also need to remove the placeholder text if that's the only text
        // if it is empty, then the text should be the placeholder
        let newLength = textView.text.utf16.count + text.utf16.count - range.length
        if newLength > 0 // have text, so don't show the placeholder
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                textView.resignFirstResponder()
                return false
            }
            
            // check if the only text is the placeholder and remove it if needed
            // unless they've hit the delete button with the placeholder displayed
            if textView == feedBack_textview && textView.text == PLACEHOLDER_TEXT
            {
                if text.utf16.count == 0 // they hit the back button
                {
                    return false // ignore it
                }
                applyPlaceholderStyle(aTextview: textView, placeholderText:"")
                textView.text = ""
            }
            return true
        }
        else  // no text, so show the placeholder
        {
            applyPlaceholderStyle(aTextview: textView, placeholderText: PLACEHOLDER_TEXT)
            moveCursorToStart(aTextView: textView)
            return false
        }
    }
    
    func moveCursorToStart(aTextView: UITextView)
    {
        //DispatchQueue.main.asynchronously(execute: {
            aTextView.selectedRange = NSMakeRange(0, 0);
        //})
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UITextView {
    func increaseFontSize () {
        self.font =  UIFont(name: (self.font?.fontName)!, size: 18)!
    }
}
