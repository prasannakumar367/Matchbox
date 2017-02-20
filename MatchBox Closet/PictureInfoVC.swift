//
//  PictureInfoVC.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 22/11/16.
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
import DLRadioButton

//import CheckboxButton

protocol MyProtocol {
    func setResultOfBusinessLogic(valueSent: String)
}

class PictureInfoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let mbUtils = MBUtils()
    var colors = NSMutableArray()
    
    
    var image_info = ImageInfo()
    var btn_title_text = String()
    var selected_index = String()
    
    var image_BgView = UIView()
    var color_BgView = UIView()
    var category_BgView = UIView()
    var style_BgView = UIView()
    
    let array_styles = NSMutableArray()
    
    var checkedIndexPath  = NSMutableArray()  //= NSMutableSet()
    
    var color_label = UILabel()
    var category_label = UILabel()
    var style_label = UILabel()
    
    var btn_submit = UIButton()
    
    var btn_tops = UIButton()
    var btn_footwears = UIButton()
    var btn_bottoms = UIButton()
    var btn_accessories = UIButton()
    
    var selected_btn_index = NSString()
    
    
    var formal_btn = DLRadioButton()
    var casual_btn = DLRadioButton()
    var sporty_btn = DLRadioButton()
    var others_btn = DLRadioButton()
    
    var dict_profileVC = NSMutableDictionary()
    
    var selected_imageVC = UIImageView()
    
    var color_colectionview: UICollectionView?
    let cellIdentifier1 = "CellIdentifier1"
    
    let colorStyles : [UIColor] = [redColor, lightPinkColor, orangeColor, yellowColor, lightGreenColor, greenColor, lightBlueColor, blueColor, purpleColor, brownColor, grayColor, whiteColor, blackColor, fullBrownColor]
    
    //let color_indexs = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    
    //var selectedColors = NSMutableArray()
    
    var popDelegate:MyProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let array_colors = GetColorCodes()
        //selectedColors = array_colors.calculatetop3(img: selected_imageVC.image!)
        
        colors = ["Red", "Pink", "Orange", "Yellow", "Light green", "Green", "Light blue", "Blue", "Purple", "Brown", "Grey", "White", "Black", "Maron"]
        
        selected_btn_index = "0"
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue:239.0/255.0, alpha: 1.0)
        
        self.loadPictureInfoView()
        self.dlRadioButtonLoad()
        self.configureCollectionView1()
        
        
        
        self.loadImageData()
        
    }
    
    func loadImageData() {
        
        
        let arry_styles = image_info.styles.components(separatedBy: ",") as NSArray
        
        for item in arry_styles {
            
            let cate_string = item as! String
        
            if cate_string == "Formals" {
                formal_btn.isSelected = true
            } else if cate_string == "Casuals" {
                casual_btn.isSelected = true
            }  else if cate_string == "Party" {
                sporty_btn.isSelected = true
            } else if cate_string == "Others" {
                others_btn.isSelected = true
            }
        }
        
        let styl_string = image_info.categoryName
        
        if styl_string == "accessories" {
            buttonAction(sender : btn_accessories)
        } else if styl_string == "tops" {
            buttonAction(sender : btn_tops)
        }  else if styl_string == "bottoms" {
            buttonAction(sender : btn_bottoms)
        } else if styl_string == "footwares" {
            buttonAction(sender : btn_footwears)
        }
        
        if image_info.imageColors.characters.count > 0 {
            let arr_colors = image_info.imageColors.components(separatedBy: ",")
            let componentsMutableArray = NSMutableArray(array: arr_colors)   //["library", "bool", "science"]
            self.checkedIndexPath.removeAllObjects()
            
            for color_item in componentsMutableArray {
                self.checkedIndexPath.add(colors.index(of: color_item))
                
            }
            
            //self.checkedIndexPath = componentsMutableArray
        }
        
        color_colectionview?.reloadData()
    }
    

    func loadPictureInfoView() {
        
        image_BgView.frame = CGRect(x: 10 * WIDTHTHEME, y: 30 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 180 * HEIGHTTHEME)
        image_BgView.backgroundColor = UIColor.white
        
        selected_imageVC.frame = CGRect(x: 100 * (image_BgView.frame.size.width / 375), y: 10 * HEIGHTTHEME, width: 180  * (image_BgView.frame.size.width / 375), height: 160 * HEIGHTTHEME)
        
        image_BgView.addSubview(selected_imageVC)
        
        color_label.frame = CGRect(x: 10 * WIDTHTHEME, y: 220 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 22 * HEIGHTTHEME)
        color_label.textColor = UIColor.black
        color_label.textAlignment = NSTextAlignment.center
        color_label.text = "Select a color"
        color_label.backgroundColor = UIColor.clear
        color_label.font = UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        
        
        color_BgView.frame = CGRect(x: 10 * WIDTHTHEME, y: 250 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 80 * HEIGHTTHEME)
        color_BgView.backgroundColor = UIColor.white
        
        category_label.frame = CGRect(x: 10 * WIDTHTHEME, y: 330 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 22 * HEIGHTTHEME)
        category_label.textColor = UIColor.black
        category_label.textAlignment = NSTextAlignment.center
        category_label.text = "Select a category"
        category_label.backgroundColor = UIColor.clear
        category_label.font = UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        
        category_BgView.frame = CGRect(x: 10 * WIDTHTHEME, y: 360 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 125 * HEIGHTTHEME)
        category_BgView.backgroundColor = UIColor.white
        
        btn_tops.frame = CGRect(x: 180 * WIDTHTHEME, y: 15 * HEIGHTTHEME, width: 165  * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        btn_tops.backgroundColor = UIColor.black
        btn_tops.setTitle("Tops", for: UIControlState.normal)
        btn_tops.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btn_tops.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_tops.tag = 2
        btn_tops.titleLabel?.textColor = UIColor.white
        
        btn_footwears.frame = CGRect(x: 180 * WIDTHTHEME, y: 70 * HEIGHTTHEME, width: 165  * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        btn_footwears.backgroundColor = UIColor.black
        btn_footwears.backgroundColor = UIColor.black
        btn_footwears.setTitle("Footwears", for: UIControlState.normal)
        btn_footwears.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btn_footwears.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_footwears.tag = 4
        btn_footwears.titleLabel?.textColor = UIColor.white
        
        btn_bottoms.frame = CGRect(x: 5 * WIDTHTHEME, y: 70 * HEIGHTTHEME, width: 165  * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        btn_bottoms.backgroundColor = UIColor.black
        btn_bottoms.backgroundColor = UIColor.black
        btn_bottoms.setTitle("Bottoms", for: UIControlState.normal)
        btn_bottoms.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btn_bottoms.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_bottoms.tag = 3
        btn_bottoms.titleLabel?.textColor = UIColor.white
        
        btn_accessories.frame = CGRect(x: 5 * WIDTHTHEME, y: 15 * HEIGHTTHEME, width: 165  * WIDTHTHEME, height: 45 * HEIGHTTHEME)
        btn_accessories.backgroundColor = UIColor.black
        btn_accessories.setTitle("Accessories", for: UIControlState.normal)
        btn_accessories.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        btn_accessories.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        btn_accessories.tag = 1
        btn_accessories.titleLabel?.textColor = UIColor.white
        
        
        
        self.category_BgView.addSubview(btn_tops)
        self.category_BgView.addSubview(btn_footwears)
        self.category_BgView.addSubview(btn_bottoms)
        self.category_BgView.addSubview(btn_accessories)
        
        style_label.frame = CGRect(x: 10 * WIDTHTHEME, y: 500 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 22 * HEIGHTTHEME)
        style_label.textColor = UIColor.black
        style_label.textAlignment = NSTextAlignment.center
        style_label.text = "Style"
        style_label.backgroundColor = UIColor.clear
        style_label.font = UIFont(name: "Avenir", size: 16 * HEIGHTTHEME)
        
        style_BgView.frame = CGRect(x: 10 * WIDTHTHEME, y: 527 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 55 * HEIGHTTHEME)
        style_BgView.backgroundColor = UIColor.white
        
        // enable multiple selection for formals, casuals, sporty and other buttons.
        formal_btn.isMultipleSelectionEnabled = true;
        
        formal_btn.setTitle("Formals", for: UIControlState.normal)
        formal_btn.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        formal_btn.addTarget(self, action: #selector(self.logSelectedButton(_:)), for: .touchUpInside)
        //waterButton.tag = 1
        formal_btn.isIconSquare = true
        formal_btn.iconColor = PurpleBtnColor
        formal_btn.indicatorColor = PurpleBtnColor
        formal_btn.setTitleColor(PurpleBtnColor, for: UIControlState.normal)
        
        
        casual_btn.setTitle("Casuals", for: UIControlState.normal)
        casual_btn.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        casual_btn.addTarget(self, action: #selector(self.logSelectedButton(_:)), for: .touchUpInside)
        //waterButton.tag = 1
        casual_btn.titleLabel?.textColor = PurpleBtnColor
        casual_btn.isIconSquare = true
        casual_btn.iconColor = PurpleBtnColor
        casual_btn.indicatorColor = PurpleBtnColor
        casual_btn.setTitleColor(PurpleBtnColor, for: UIControlState.normal)
        
        
        
        sporty_btn.setTitle("Party", for: UIControlState.normal)
        sporty_btn.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        sporty_btn.addTarget(self, action: #selector(self.logSelectedButton(_:)), for: .touchUpInside)
        //waterButton.tag = 1
        sporty_btn.titleLabel?.textColor = PurpleBtnColor
        sporty_btn.isIconSquare = true
        sporty_btn.iconColor = PurpleBtnColor
        sporty_btn.indicatorColor = PurpleBtnColor
        sporty_btn.setTitleColor(PurpleBtnColor, for: UIControlState.normal)
        
        
        others_btn.setTitle("Others", for: UIControlState.normal)
        others_btn.titleLabel!.font =  UIFont(name: "Avenir", size: (14 * HEIGHTTHEME))
        others_btn.addTarget(self, action: #selector(self.logSelectedButton(_:)), for: .touchUpInside)
        //waterButton.tag = 1
        others_btn.titleLabel?.textColor = PurpleBtnColor
        others_btn.isIconSquare = true
        others_btn.iconColor = PurpleBtnColor
        others_btn.indicatorColor = PurpleBtnColor
        others_btn.setTitleColor(PurpleBtnColor, for: UIControlState.normal)
        
        
        var otherButtons : [DLRadioButton] = [];
        otherButtons.append(casual_btn)
        otherButtons.append(sporty_btn)
        otherButtons.append(others_btn)
        formal_btn.otherButtons = otherButtons;
        
        formal_btn.frame = CGRect(x: 10 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 75 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        casual_btn.frame = CGRect(x: 85 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 75 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        sporty_btn.frame = CGRect(x: 165 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 70 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        others_btn.frame = CGRect(x: 245 * WIDTHTHEME, y: 5 * HEIGHTTHEME, width: 70 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        
        
        style_BgView.addSubview(formal_btn)
        style_BgView.addSubview(casual_btn)
        style_BgView.addSubview(sporty_btn)
        style_BgView.addSubview(others_btn)
        
        
        btn_submit.frame = CGRect(x: 10 * WIDTHTHEME, y: 603 * HEIGHTTHEME, width: SCREENWIDTH - (20  * WIDTHTHEME), height: 45 * HEIGHTTHEME)
        btn_submit.backgroundColor = PinkBtnColor
        btn_submit.setTitle(btn_title_text, for: UIControlState.normal)
        btn_submit.titleLabel!.font =  UIFont(name: "Avenir-Bold", size: (14 * HEIGHTTHEME))
        btn_submit.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        btn_submit.tag = 15
        btn_submit.titleLabel?.textColor = UIColor.white
        
        
        self.view.addSubview(image_BgView)
        self.view.addSubview(color_BgView)
        self.view.addSubview(category_BgView)
        self.view.addSubview(style_BgView)
        
        self.view.addSubview(style_label)
        self.view.addSubview(color_label)
        self.view.addSubview(category_label)
        
        self.view.addSubview(btn_submit)
    }
    
    func configureCollectionView1()
    {
        // we create the collection view layout with given insets and item size
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 10 * WIDTHTHEME, left: 10 * HEIGHTTHEME, bottom: 10 * WIDTHTHEME, right: 5 * HEIGHTTHEME)
        layout1.itemSize = CGSize(width: 25 * WIDTHTHEME, height: 25 * HEIGHTTHEME)
        layout1.scrollDirection = .vertical
        layout1.minimumInteritemSpacing = 20
        layout1.minimumLineSpacing = 10 * WIDTHTHEME
                
        //cView1.frame = CGRect(x:2 * WIDTHTHEME, y:115 * HEIGHTTHEME, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME)
        //cView1.layer.borderWidth = 1
        //cView1.layer.borderColor = UIColor.lightGray.cgColor
        
        // we create the collection view object
        color_colectionview = UICollectionView(frame: CGRect(x:5 * WIDTHTHEME, y:0, width: color_BgView.frame.size.width - (10 * WIDTHTHEME), height: 80 * HEIGHTTHEME), collectionViewLayout: layout1)
        
        color_colectionview!.dataSource = self
        color_colectionview!.delegate = self
        color_colectionview!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier1)
        color_colectionview!.backgroundColor = UIColor.white
        color_colectionview?.showsHorizontalScrollIndicator = false
        color_colectionview?.showsVerticalScrollIndicator = false
        color_colectionview?.allowsMultipleSelection = true

        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        color_BgView.addSubview(color_colectionview!)
    }
    
    
    
    
    
    func dlRadioButtonLoad(){
        // enable multiple selection for water, beer and wine buttons.
        formal_btn.isMultipleSelectionEnabled = true;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colorStyles.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier1, for: indexPath as IndexPath) as UICollectionViewCell
        
        for v  in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        
        cell.backgroundColor = colorStyles[indexPath.row]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        let checkBox : CheckboxButton = CheckboxButton()
        checkBox.backgroundColor = UIColor.clear
        checkBox.checkColor = UIColor(hex: "009688")
        checkBox.containerColor = UIColor.clear
        checkBox.frame = cell.contentView.frame
        checkBox.tag = indexPath.row
        
        checkBox.on = self.checkedIndexPath.contains(indexPath.row)
        
        checkBox.addTarget(self, action: #selector(didToggleCheckboxButton), for: UIControlEvents.touchUpInside)
        
        //checkBox.addTarget(self, action: #selector(PictureInfoVC.didToggleCheckboxButton(sender:)), for: .valueChanged)
        cell.contentView.addSubview(checkBox)
        
        
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        if let indexPath = getIndexPathForSelectedCell() {
//            highlightCell(indexPath, flag: false)
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    // MARK:- Selected Cell IndexPath
    
    func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if (color_colectionview?.indexPathsForSelectedItems!.count)! > 0 {
            indexPath = color_colectionview?.indexPathsForSelectedItems![0]
        }
        
        return indexPath
    }
    
    
    // MARK:- Highlight
    
//    func highlightCell(_ indexPath : IndexPath, flag: Bool) {
//        
//        let cell = color_colectionview?.cellForItem(at: indexPath)
//        
//        if flag {
//            cell?.contentView.backgroundColor = UIColor.magenta
//        } else {
//            cell?.contentView.backgroundColor = nil
//        }
//    }
    
    // MARK:- Editing
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        color_colectionview?.allowsMultipleSelection = editing
//    }
//    
    
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        highlightCell(indexPath, flag: false)
//    }
    
    
    
    func didToggleCheckboxButton(_ sender: CheckboxButton) {
        let state = sender.on ? "ON" : "OFF"
        
        
        if self.checkedIndexPath.contains(sender.tag) {
            self.checkedIndexPath.remove(sender.tag)
            //cell.isChecked = false
            
        } else {
            self.checkedIndexPath.add(sender.tag)
            //cell.isChecked = true
        }
        
        print("CheckboxButton: did turn \(state)")
    }

    func logSelectedButton(_ radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }

   
    func prepareColors(indexpaths: NSMutableArray) -> NSMutableArray {
        
        var color_names = NSMutableArray()
        
        for index_color in indexpaths {
            
            
            if color_names.contains(colors[index_color as! Int] as! [String]) {
                
            } else {
                color_names.add(colors[index_color as! Int] as! [String])
            }
            
            
        }
        
        return color_names
    }
    
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 15 {
            //Submit btn
            
            dict_profileVC.setValue(self.selected_imageVC.image! as UIImage, forKey: "selectedImage")
            dict_profileVC.setObject(self.checkedIndexPath, forKey: "imagecolorcodes" as NSCopying)
            
            dict_profileVC.setValue(selected_btn_index, forKey: "selected_category")
            
            //dict_profileVC.setObject(array_styles, forKey: "styles" as NSCopying)
            
            
            //formal_btn.selected(), casual_btn.selected(), sporty_btn.selected(), others_btn.selected()
            
            array_styles.removeAllObjects()
            
            if (formal_btn.isSelected) {
                array_styles.add("Formals")
            }
            
            if (casual_btn.isSelected){
                array_styles.add("Casuals")
            }
            
            if (sporty_btn.isSelected){
                array_styles.add("Party")
            }
            
            if (others_btn.isSelected){
                array_styles.add("Others")
            }
            
            //let mainVc = MainViewController()
            //mainVc.selectedPicture = self.selected_imageVC.image!
            
            //let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //appDelegate.dict_data = dict_profileVC
            
            //self.navigationController?.popToViewController(mainVc, animated: true)
            
            var catName = String()
            
            if selected_btn_index == "1" {
                catName = "accessories"
            } else if selected_btn_index == "2" {
                catName = "tops"
            } else if selected_btn_index == "3" {
                catName = "bottoms"
            } else if selected_btn_index == "4" {
                catName = "footwares"
            }
            
            
            image_info.categoryName = catName
            image_info.categoryType = selected_btn_index as String
            //imgInfo.imageData = self.selected_imageVC.image!
            
            
            let data1 = UIImagePNGRepresentation(self.selected_imageVC.image!) as NSData?
            
            image_info.imageData = data1 as! Data
            
            //let imagePt = UIImage(data: data1 as! Data)
            
            //UIImage(data: ,scale:1.0)
            
            
            //imgInfo.styles = array_styles
            
            
            
            if checkedIndexPath.count == 0 {
                self.mbUtils.alertView(titleText: "Problem", messageText: "Select picture colors." , viewcontoller: self)
                return
            }
            
            if catName.characters.count == 0 {
                self.mbUtils.alertView(titleText: "Problem", messageText: "Select picture category." , viewcontoller: self)
                return
            }
            
            
            if array_styles.count == 0 {
                self.mbUtils.alertView(titleText: "Problem", messageText: "Select picture style." , viewcontoller: self)
                return
            }
            
            
            var strings = NSMutableArray()
            
            for it in self.checkedIndexPath {
                strings.add(colors[it as! Int] as! String)
            }
            
            let colors_str = strings.componentsJoined(by: ",")
            let styles_str = array_styles.componentsJoined(by: ",")
            
            image_info.styles = styles_str as String
            image_info.imageColors = colors_str as String
            
            var  isInserted = Bool()
            
            if self.btn_submit.titleLabel?.text == "Submit" {
                isInserted = ModelManager.getInstance().addImageData(image_info, valueString: selected_btn_index as String)
            } else {
                
                isInserted = ModelManager.getInstance().updateImageData(image_info, valueString: image_info.categoryType, selected: selected_index)
                
                if isInserted {
                    popDelegate?.setResultOfBusinessLogic(valueSent: selected_index as String)
                }
                
            }
            
            if isInserted {
                //Utilities.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                NSLog("Record Inserted successfully.")
            } else {
                
                NSLog("Error in inserting record.")
                //Utilities.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
            }
            
            popDelegate?.setResultOfBusinessLogic(valueSent: selected_btn_index as String)
            
            self.navigationController?.popViewController(animated: true)
            
        } else if sender.tag == 1 {
            
            btn_accessories.backgroundColor = PurpleBtnColor
            btn_tops.backgroundColor = UIColor.black
            btn_footwears.backgroundColor = UIColor.black
            btn_bottoms.backgroundColor = UIColor.black
            
            selected_btn_index = "1"
            
        } else if sender.tag == 2 {
            
            btn_accessories.backgroundColor = UIColor.black
            btn_tops.backgroundColor = PurpleBtnColor
            btn_footwears.backgroundColor = UIColor.black
            btn_bottoms.backgroundColor = UIColor.black
            
            selected_btn_index = "2"
            
        } else if sender.tag == 3 {
            
            btn_accessories.backgroundColor = UIColor.black
            btn_tops.backgroundColor = UIColor.black
            btn_footwears.backgroundColor = UIColor.black
            btn_bottoms.backgroundColor = PurpleBtnColor
            
            selected_btn_index = "3"
            
        } else if sender.tag == 4 {
            
            btn_accessories.backgroundColor = UIColor.black
            btn_tops.backgroundColor = UIColor.black
            btn_footwears.backgroundColor = PurpleBtnColor
            btn_bottoms.backgroundColor = UIColor.black
            
            selected_btn_index = "4"
            
        }
        
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
