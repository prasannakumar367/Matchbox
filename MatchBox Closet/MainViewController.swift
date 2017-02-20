//
//  ViewController.swift
//  MatchBox Closet
//
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit
//import CheckboxButton


class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, WDImagePickerDelegate, MyProtocol, UIGestureRecognizerDelegate {
    
    var addLoadView = Bool()
    
    var valueSentFromSecondViewControlvar = String()
    var valueSentFromDisplay = NSString()
    
    
    fileprivate var imagePicker: WDImagePicker!
    var popoverController: UIPopoverController!
    fileprivate var imagePickerController: UIImagePickerController!
    
    fileprivate var imageView: UIImageView!
    fileprivate var resizableButton: UIButton!
    
    var selectedRows = NSMutableDictionary()
    var sectionZero = [String]()
    var sectionOne = [String]()
    
    
    let cellReuseIdentifier: String = "yourCellReuseIdentifier"
    
    var arry_wordbrode = NSMutableArray()
    
    var view_filter = UIButton()
    var tableView_filter = UITableView()
    var selectedPicture = UIImage()
    var lbl_filterTitle = UILabel()
    
    //var styles : NSArray = ["Styles", "Colors"]
    //var style_elements : NSMutableArray = ["All" , "Casuals", "Formals", "Sporty", "Traditional", "Party"]
    //var color_elements : NSMutableArray = ["All" , "Red", "Pink", "Orange", "Yellow", "Light green", "Green", "Light blue", "Black", "White", "Grey"]
    
    //let data = [["All" , "Casuals", "Formals", "Sporty", "Traditional", "Party"], ["All" , "Red", "Pink", "Orange", "Yellow", "Light green", "Green", "Light blue", "Black", "White", "Grey"]]
    
    //var sections = Section
    
    var checked = [Bool]() // Have an array equal to the number of cells in your table
    
    var lbl_wardrobe = UILabel()
    
    var cView1 = UIView()
    var accessories_collectionView: UICollectionView?
    let cellIdentifier1 = "CellIdentifier1"
    
    var cView2 = UIView()
    var tops_collectionView: UICollectionView?
    let cellIdentifier2 = "CellIdentifier2"
    
    var cView3 = UIView()
    var bottoms_collectionView: UICollectionView?
    let cellIdentifier3 = "CellIdentifier3"
    
    var cView4 = UIView()
    var footwears_collectionView: UICollectionView?
    let cellIdentifier4 = "CellIdentifier4"
    
    var accessrios_imgs = NSMutableArray()
    
    var tops_imgs = NSMutableArray()
    var bottoms_imgs = NSMutableArray()
    var footwears_imgs = NSMutableArray()

    let colorStyles : [UIColor] = [PurpleBtnColor, redColor, lightPinkColor, orangeColor, yellowColor, lightGreenColor, greenColor, lightBlueColor, blackColor, whiteColor, grayColor]
    
    //let imagePicker = UIImagePickerController()
    var sections = [Section]()
    
    var access_gesture = UILongPressGestureRecognizer()
    var tops_gesture = UILongPressGestureRecognizer()
    var bottoms_gesture = UILongPressGestureRecognizer()
    var footwares_gesture = UILongPressGestureRecognizer()
    var options_gesture = UITapGestureRecognizer()
    
    var options_bg = UIView()
    var options_bg_mini = UIView()
    var edit_btn = UIButton()
    var delete_btn = UIButton()
    
    
    struct Section {
        
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sections = [
            Section(name: "Styles", items: ["Casuals", "Formals", "Party", "Others"]),
            Section(name: "Colors", items: ["Red", "Pink", "Orange", "Yellow", "Light green", "Green", "Light blue", "Blue", "Purple", "Brown", "Grey", "White", "Black", "Maron"])
        ]
        
        
        view.backgroundColor = LightColor
        
        addLoadView = true
        
        
        let titleBgView = UIView()
        
        if SCREENHEIGHT > 800 {
            titleBgView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)! * HEIGHTTHEME, width: SCREENWIDTH, height: 50 * HEIGHTTHEME)
        } else {
            titleBgView.frame = CGRect(x: 0, y: 66 * HEIGHTTHEME, width: SCREENWIDTH, height: 50 * HEIGHTTHEME)
        }
        
        titleBgView.backgroundColor = PurpleBtnColor
        
        lbl_wardrobe.frame = CGRect(x: 20 * WIDTHTHEME , y:0, width: 120 * WIDTHTHEME, height: 50 * HEIGHTTHEME)
        lbl_wardrobe.backgroundColor = UIColor.clear
        lbl_wardrobe.text = "Wardrobe"
        lbl_wardrobe.textColor = UIColor.white
        lbl_wardrobe.font = UIFont(name: "Avenir-Bold", size: 18 * HEIGHTTHEME)
        lbl_wardrobe.textAlignment = NSTextAlignment.right
        titleBgView.addSubview(lbl_wardrobe)
        
        let btnGallery = UIButton()
        btnGallery.frame = CGRect(x: 200 * WIDTHTHEME, y: 7 * HEIGHTTHEME, width:35 * HEIGHTTHEME, height: 35 * HEIGHTTHEME)
        btnGallery.backgroundColor = UIColor.clear
        btnGallery.setImage(UIImage(named:"gallery_new"), for: UIControlState.normal)
        btnGallery.tag = 6
        btnGallery.layer.cornerRadius = 3
        btnGallery.addTarget(self, action: #selector(MainViewController.showResizablePicker(_:)), for: .touchUpInside)
        titleBgView.addSubview(btnGallery)
        
        let btnCamera = UIButton()
        btnCamera.frame = CGRect(x: 260 * WIDTHTHEME, y: 7 * HEIGHTTHEME, width: 35 * HEIGHTTHEME, height: 35 * HEIGHTTHEME)
        btnCamera.backgroundColor = UIColor.clear
        btnCamera.setImage(UIImage(named:"camera_new"), for: UIControlState.normal)
        btnCamera.tag = 5
        btnCamera.layer.cornerRadius = 3
        btnCamera.addTarget(self, action: #selector(MainViewController.showResizablePicker(_:)), for: .touchUpInside)
        titleBgView.addSubview(btnCamera)
        
        let updateFilterBtn = UIButton()
        updateFilterBtn.frame = CGRect(x: 320 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: 30 * WIDTHTHEME, height: 30 * WIDTHTHEME)
        updateFilterBtn.backgroundColor = UIColor.clear
        updateFilterBtn.setImage(UIImage(named:"filter_icon"), for: UIControlState.normal)
        updateFilterBtn.tag = 10
        updateFilterBtn.layer.cornerRadius = 3
        updateFilterBtn.addTarget(self, action: #selector(MainViewController.buttonAction(sender:)), for: .touchUpInside)
        titleBgView.addSubview(updateFilterBtn)
        
        self.view.addSubview(titleBgView)
        self.configureCollectionView1()
        self.configureCollectionView2()
        self.configureCollectionView3()
        self.configureCollectionView4()
        
        view_filter.frame = CGRect(x: 0, y: titleBgView.frame.size.height + titleBgView.frame.origin.y, width: SCREENWIDTH, height: SCREENHEIGHT - 70)
        view_filter.backgroundColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue:224.0/255.0, alpha: 0.4)
        view_filter.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        view_filter.tag = 7
        view.addSubview(view_filter)
        
        
        lbl_filterTitle.frame = CGRect(x: SCREENWIDTH / 2, y:0, width: 120 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        lbl_filterTitle.backgroundColor = UIColor.white
        lbl_filterTitle.textColor = PinkBtnColor
        lbl_filterTitle.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        lbl_filterTitle.textAlignment = NSTextAlignment.left
        lbl_filterTitle.text = "   Filter"
        view_filter.addSubview(lbl_filterTitle)
        
        
        
        if SCREENHEIGHT > 800 {
            tableView_filter.frame = CGRect(x: SCREENWIDTH / 2, y: 40 * HEIGHTTHEME, width: SCREENWIDTH / 2, height: (485 * HEIGHTTHEME));
        } else {
            tableView_filter.frame = CGRect(x: SCREENWIDTH / 2, y: 40 * HEIGHTTHEME, width: SCREENWIDTH / 2, height: (460 * HEIGHTTHEME));
        }

        
        
        tableView_filter.backgroundColor = UIColor.white
        tableView_filter.delegate = self
        tableView_filter.dataSource = self
        view_filter.addSubview(tableView_filter)
        
        let btnFilter = UIButton()
        btnFilter.frame = CGRect(x: SCREENWIDTH / 2, y: tableView_filter.frame.origin.y + tableView_filter.frame.size.height, width: SCREENWIDTH / 2, height: 40 * HEIGHTTHEME)
        btnFilter.backgroundColor = PinkBtnColor
        btnFilter.setTitle("Apply Filter", for: UIControlState.normal)
        btnFilter.tag = 8
        btnFilter.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        view_filter.addSubview(btnFilter)
        
        
        let btnClear = UIButton()
        btnClear.frame = CGRect(x: lbl_filterTitle.frame.origin.x + lbl_filterTitle.frame.size.width, y: 0, width: 80 * WIDTHTHEME, height: 40 * HEIGHTTHEME)
        btnClear.backgroundColor = whiteColor
        btnClear.titleLabel?.font = UIFont(name: "Avenir", size: 14 * HEIGHTTHEME)
        btnClear.setTitle("Reset   ", for: UIControlState.normal)
        btnClear.tag = 9
        btnClear.titleLabel?.textAlignment = .left
        btnClear.setTitleColor(PinkBtnColor, for: UIControlState.normal)
        btnClear.addTarget(self, action: #selector(AccountViewController.buttonAction(sender:)), for: .touchUpInside)
        view_filter.addSubview(btnClear)
        
        
        
        
        view_filter.isHidden = true
        
        
        //self.title = "Apple Products"
        
        // Initialize the sections array
        // Here we have three sections: Mac, iPad, iPhone
//        sections = [
//            Section(name: "Styles", items: ["All" , "Casuals", "Formals", "Sporty", "Traditional", "Party"]),
//            Section(name: "Colors", items: ["All" , "Red", "Pink", "Orange", "Yellow", "Light green", "Green", "Light blue", "Black", "White", "Grey"]),
//        ]
        
        
        
//        self.resizableButton = UIButton()
//        self.resizableButton.setTitleColor(self.view.tintColor, for: UIControlState())
//        self.resizableButton.setTitle("Resizable Custom Crop", for: UIControlState())
//        self.resizableButton.addTarget(self, action: #selector(MainViewController.showResizablePicker(_:)), for: .touchUpInside)
//        
//        self.view.addSubview(self.resizableButton)
        
        self.imageView = UIImageView(frame: CGRect.zero)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = UIColor.gray
        self.view.addSubview(self.imageView)
        
        for i in 1...4 {
            setResultOfBusinessLogic(valueSent: String(i))
        }
        
        
        access_gesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.accessries_LongPress(_:)))
        access_gesture.minimumPressDuration = 0.3
        access_gesture.delaysTouchesBegan = true
        access_gesture.delegate = self
        accessories_collectionView?.addGestureRecognizer(access_gesture)
        
        tops_gesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.tops_LongPress(_:)))
        tops_gesture.minimumPressDuration = 0.3
        tops_gesture.delaysTouchesBegan = true
        tops_gesture.delegate = self
        tops_collectionView?.addGestureRecognizer(tops_gesture)
        
        bottoms_gesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.bottoms_LongPress(_:)))
        bottoms_gesture.minimumPressDuration = 0.3
        bottoms_gesture.delaysTouchesBegan = true
        bottoms_gesture.delegate = self
        bottoms_collectionView?.addGestureRecognizer(bottoms_gesture)
        
        footwares_gesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.footwares_LongPress(_:)))
        footwares_gesture.minimumPressDuration = 0.3
        footwares_gesture.delaysTouchesBegan = true
        footwares_gesture.delegate = self
        footwears_collectionView?.addGestureRecognizer(footwares_gesture)
        
        options_gesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.options_Press(_:)))
        options_gesture.delegate = self
        options_bg.addGestureRecognizer(options_gesture)
        
        loadCellOptions()
        options_bg.isHidden = true
        
        
        if (self.accessrios_imgs.count == 0 && self.tops_imgs.count == 0 && self.bottoms_imgs.count == 0 && self.footwears_imgs.count == 0) {
            let alertVC = UIAlertController(title: "MatchBox", message: "Add your apparel pictures by clicking on camera or gallery button.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    func showResizablePicker(_ button: UIButton) {
        
        if button.tag == 5 {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker = WDImagePicker.init(withSourceType: .camera)
            } else {
                noCamera()
            }
            
        } else {
            self.imagePicker = WDImagePicker.init(withSourceType: .photoLibrary)
        }
        
        self.imagePicker.cropSize = CGSize(width: 320, height: 300)
        self.imagePicker.delegate = self
        self.imagePicker.resizableCropArea = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.popoverController = UIPopoverController(contentViewController: self.imagePicker.imagePickerController)
            self.popoverController.present(from: button.frame, in: self.view, permittedArrowDirections: .any, animated: true)
        } else {
            self.present(self.imagePicker.imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePicker(_ imagePicker: WDImagePicker, pickedImage: UIImage) {
        self.imageView.image = pickedImage
        self.hideImagePicker()
        
        addLoadView = false
        
        let pic_info : PictureInfoVC = PictureInfoVC()
        pic_info.popDelegate = self
        pic_info.btn_title_text = "Submit"
        pic_info.selected_imageVC.image = pickedImage;
        self.navigationController?.pushViewController(pic_info, animated: true)
    }
    
    func hideImagePicker() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.popoverController.dismiss(animated: true)
        } else {
            self.imagePicker.imagePickerController.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.imageView.image = image
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.popoverController.dismiss(animated: true)
        } else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem()
        
        
        //getImagesData(valueString: "1")
        
//        var appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        if ((appDelegate.dict_data) != nil) {
//            accessrios_imgs.add(appDelegate.dict_data?.value(forKey: "selectedImage"))
//            accessories_collectionView?.reloadData()
//        }
        
        
        
        
    }
    
    //4. Implement MyProtocol's function to make FirstViewContoller conform to MyProtocol
    // MARK: MyProtocol functions
    func setValueFromDisplay(valueSent: String)
    {
        self.valueSentFromDisplay = valueSent as NSString
    }
    
    
    
    func setResultOfBusinessLogic(valueSent: String) {
        
        print("set result of business logic = \(valueSent)")
        
        if valueSent == "1" {
            getImagesData(valueString: valueSent)
        } else if valueSent == "2" {
            getImagesData(valueString: valueSent)
        } else if valueSent == "3" {
            getImagesData(valueString: valueSent)
        } else if valueSent == "4" {
            getImagesData(valueString: valueSent)
        }
        
    }
    
    
    
    func getImagesData(valueString: String) {
        
        var marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllData(valueType: valueString)
        print(marrStudentData)
        
        if valueString == "1" {
            //var imgItem : ImageInfo = marrStudentData.object(at: 0) as! ImageInfo
            
            accessrios_imgs.removeAllObjects()
            
            for imgItem in marrStudentData {
                let im = imgItem as! ImageInfo
                accessrios_imgs.add(im.imageData)
            }
        
            accessories_collectionView?.reloadData()
            
        } else if valueString == "2" {
            
            tops_imgs.removeAllObjects()
            
            for imgItem in marrStudentData {
                let im = imgItem as! ImageInfo
                tops_imgs.add(im.imageData)
            }
            
            tops_collectionView?.reloadData()
            
        } else if valueString == "3" {
            
            bottoms_imgs.removeAllObjects()
            
            for imgItem in marrStudentData {
                let im = imgItem as! ImageInfo
                bottoms_imgs.add(im.imageData)
            }
            
            bottoms_collectionView?.reloadData()
            
        } else if valueString == "4" {
            
            footwears_imgs.removeAllObjects()
            
            for imgItem in marrStudentData {
                let im = imgItem as! ImageInfo
                footwears_imgs.add(im.imageData)
            }
            
            footwears_collectionView?.reloadData()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureCollectionView1()
    {
        // we create the collection view layout with given insets and item size
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 5 * WIDTHTHEME, left: 5 * HEIGHTTHEME, bottom: 5 * WIDTHTHEME, right: 5 * HEIGHTTHEME)
        layout1.itemSize = CGSize(width: 113 * WIDTHTHEME, height: 130 * HEIGHTTHEME)
        layout1.scrollDirection = .horizontal
                
        cView1.frame = CGRect(x:2 * WIDTHTHEME, y:115 * HEIGHTTHEME, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME)
        cView1.layer.borderWidth = 1
        cView1.layer.borderColor = UIColor.lightGray.cgColor
        
        // we create the collection view object
        accessories_collectionView = UICollectionView(frame: CGRect(x:2 * WIDTHTHEME, y:0, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME), collectionViewLayout: layout1)
            
        accessories_collectionView!.dataSource = self
        accessories_collectionView!.delegate = self
        accessories_collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier1)
        accessories_collectionView!.backgroundColor = UIColor(red: 235.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1.0)
        accessories_collectionView?.showsHorizontalScrollIndicator = false
        accessories_collectionView?.showsVerticalScrollIndicator = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        cView1.addSubview(accessories_collectionView!)
        self.view.addSubview(cView1)
    }
    
    
    
    func configureCollectionView2()
    {
        // we create the collection view layout with given insets and item size
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 5 * WIDTHTHEME, left: 5 * HEIGHTTHEME, bottom: 5 * WIDTHTHEME, right: 5 * HEIGHTTHEME)
        layout2.itemSize = CGSize(width: 113 * WIDTHTHEME, height: 130 * HEIGHTTHEME)
        layout2.scrollDirection = .horizontal
        
        cView2.frame = CGRect(x:2 * WIDTHTHEME, y:253 * HEIGHTTHEME, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME)
        cView2.layer.borderWidth = 1
        cView2.layer.borderColor = UIColor.lightGray.cgColor
        
        // we create the collection view object
        tops_collectionView = UICollectionView(frame: CGRect(x:2 * WIDTHTHEME, y:0, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME), collectionViewLayout: layout2)
        tops_collectionView!.dataSource = self
        tops_collectionView!.delegate = self
        tops_collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier2)
        tops_collectionView!.backgroundColor = UIColor(red: 235.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1.0)
        tops_collectionView?.showsHorizontalScrollIndicator = false
        tops_collectionView?.showsVerticalScrollIndicator = false
        
        cView2.addSubview(tops_collectionView!)
        self.view.addSubview(cView2)
    }
    
    func configureCollectionView3()
    {
        // we create the collection view layout with given insets and item size
        let layout3: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout3.sectionInset = UIEdgeInsets(top: 5 * WIDTHTHEME, left: 5 * HEIGHTTHEME, bottom: 5 * WIDTHTHEME, right: 5 * HEIGHTTHEME)
        layout3.itemSize = CGSize(width: 113 * WIDTHTHEME, height: 130 * HEIGHTTHEME)
        layout3.scrollDirection = .horizontal
        
        cView3.frame = CGRect(x:2 * WIDTHTHEME, y:391 * HEIGHTTHEME, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME)
        cView3.layer.borderWidth = 1
        cView3.layer.borderColor = UIColor.lightGray.cgColor
        
        // we create the collection view object
        bottoms_collectionView = UICollectionView(frame: CGRect(x:(2 * WIDTHTHEME), y:0, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME), collectionViewLayout: layout3)
        bottoms_collectionView!.dataSource = self
        bottoms_collectionView!.delegate = self
        bottoms_collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier3)
        bottoms_collectionView!.backgroundColor = UIColor(red: 235.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1.0)
        bottoms_collectionView?.showsHorizontalScrollIndicator = false
        bottoms_collectionView?.showsVerticalScrollIndicator = false
        
        cView3.addSubview(bottoms_collectionView!)
        self.view.addSubview(cView3)
    }
    
    func configureCollectionView4()
    {
        // we create the collection view layout with given insets and item size
        let layout4: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout4.sectionInset = UIEdgeInsets(top: 5 * WIDTHTHEME, left: 5 * HEIGHTTHEME, bottom: 5 * WIDTHTHEME, right: 5 * HEIGHTTHEME)
        layout4.itemSize = CGSize(width: 113 * WIDTHTHEME, height: 130 * HEIGHTTHEME)
        layout4.scrollDirection = .horizontal
        
        cView4.frame = CGRect(x:(2 * WIDTHTHEME), y:529 * HEIGHTTHEME, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME)
        cView4.layer.borderWidth = 1
        cView4.layer.borderColor = UIColor.lightGray.cgColor
        
        // we create the collection view object
        footwears_collectionView = UICollectionView(frame: CGRect(x:2 * WIDTHTHEME, y:0, width:SCREENWIDTH - (4 * WIDTHTHEME), height: 133 * HEIGHTTHEME), collectionViewLayout: layout4)
        footwears_collectionView!.dataSource = self
        footwears_collectionView!.delegate = self
        footwears_collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier4)
        footwears_collectionView!.backgroundColor = UIColor(red: 235.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1.0)
        footwears_collectionView?.showsHorizontalScrollIndicator = false
        footwears_collectionView?.showsVerticalScrollIndicator = false
        
        cView4.addSubview(footwears_collectionView!)
        
        self.view.addSubview(cView4)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == accessories_collectionView {
            
            return accessrios_imgs.count
            
        } else if collectionView == tops_collectionView {
            
            return tops_imgs.count
            
        } else if collectionView == bottoms_collectionView {
            
            return bottoms_imgs.count
            
        } else if collectionView == footwears_collectionView {
            
            return footwears_imgs.count
        }
        
        return 15
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = UICollectionViewCell()
        
        
        if collectionView == accessories_collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier1, for: indexPath as IndexPath) as UICollectionViewCell
            
            for v  in cell.contentView.subviews {
                v.removeFromSuperview()
            }
            
            cell.backgroundColor = UIColor.white
            
            let img_view = UIImageView()
            img_view.frame = CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height)
            //img_view.image = UIImage.init(named: "bealt.png")
            
            
            if (self.accessrios_imgs.count > 0) {
                //img_view.image = accessrios_imgs[indexPath.row] as? UIImage
                
                img_view.image =  UIImage(data: accessrios_imgs[indexPath.row] as! Data)
            }
            
            
            cell.addSubview(img_view)
            
            return cell
            
        } else if collectionView == tops_collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier2, for: indexPath as IndexPath) as UICollectionViewCell
            
            for v  in cell.contentView.subviews {
                v.removeFromSuperview()
            }
            
            cell.backgroundColor = UIColor.white
            
            
            let img_view = UIImageView()
            img_view.frame = CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height)
            
            if (self.tops_imgs.count > 0) {
                //img_view.image = tops_imgs[indexPath.row] as? UIImage
                img_view.image =  UIImage(data: tops_imgs[indexPath.row] as! Data)
            }
            
            //img_view.image = UIImage.init(named: "tshirt.png")
            cell.addSubview(img_view)
            
            return cell
            
        } else if collectionView == bottoms_collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier3, for: indexPath as IndexPath) as UICollectionViewCell
            
            for v  in cell.contentView.subviews {
                v.removeFromSuperview()
            }
            
            cell.backgroundColor = UIColor.white
            
            
            let img_view = UIImageView()
            img_view.frame = CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height)
            
            if (self.bottoms_imgs.count > 0) {
                //img_view.image = bottoms_imgs[indexPath.row] as? UIImage
                img_view.image =  UIImage(data: bottoms_imgs[indexPath.row] as! Data)
            }
            
            //img_view.image = UIImage.init(named: "phant")
            cell.addSubview(img_view)
            
            return cell
            
        } else {
         
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier4, for: indexPath as IndexPath) as UICollectionViewCell
            
            for v  in cell.contentView.subviews {
                v.removeFromSuperview()
            }
            
            cell.backgroundColor = UIColor.white
            
            
            let img_view = UIImageView()
            img_view.frame = CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height)
            
            if (self.footwears_imgs.count > 0) {
                //img_view.image = footwears_imgs[indexPath.row] as? UIImage
                img_view.image =  UIImage(data: footwears_imgs[indexPath.row] as! Data)
            }
            
            //img_view.image = UIImage.init(named: "sandles.png")
            cell.addSubview(img_view)
            
            return cell
            
        }
        
//        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = PurpleBtnColor.cgColor
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    
    
    func accessries_LongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: accessories_collectionView)
        let indexPath = accessories_collectionView?.indexPathForItem(at: p)
        
        if let index = indexPath {
            options_bg.tag = 1
            options_bg.isHidden = false
            
            var cell = accessories_collectionView?.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    
    
    func tops_LongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: tops_collectionView)
        let indexPath = tops_collectionView?.indexPathForItem(at: p)
        
        if let index = indexPath {
            options_bg.tag = 2
            options_bg.isHidden = false
            
            var cell = tops_collectionView?.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    
    
    func bottoms_LongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: bottoms_collectionView)
        let indexPath = bottoms_collectionView?.indexPathForItem(at: p)
        
        if let index = indexPath {
            options_bg.tag = 3
            options_bg.isHidden = false
            
            var cell = bottoms_collectionView?.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    
    
    func footwares_LongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: footwears_collectionView)
        let indexPath = footwears_collectionView?.indexPathForItem(at: p)
        
        if let index = indexPath {
            
            options_bg.tag = 4
            options_bg.isHidden = false
            
            var cell = footwears_collectionView?.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    
    func options_Press(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        options_bg.isHidden = true
    }
    
    
    
    
    
    
    
    
    
    
    func updateFilterData(resetAll:Bool, fetchData:AnyObject) {
        
        //tableView_filter.reloadData()
        
        if sectionZero.count > 0 {
            
            for i in 1...4 {
                getImagesData(valueString: String(i))
            }
            
            updateFilter()
        }
        
    }
    
    
    func fetchTriggerAction() -> (NSMutableArray){
        
        let nsmuta = NSMutableArray()
        
        
        return nsmuta
    }
    
    
    func buttonAction(sender: UIButton!) {
        
        if sender.tag == 1 {
            
            view_filter.isHidden = false
            updateFilterData(resetAll: true, fetchData: fetchTriggerAction())
            
            
        } else if sender.tag == 5 {
            
            //Camera
            
            
            
        } else if sender.tag == 6 {
            //Gallery

        } else if sender.tag == 7 {
            //Outside of filter clicked.
            view_filter.isHidden = true
            
        } else if sender.tag == 8 {
            //Filter button
            
            
            //let indexPaths = tableView_filter.indexPathForSelectedRow
            //var sectionNumber = indexPath?.section
            
            
            //let indexPaths = tableView_filter.indexPathsForSelectedRows
            
            if (sectionZero.count > 0 || sectionOne.count > 0) {
            
                for i in 1...4 {
                    getSelectedIndexes(valueString: String(i))
                }
                
                view_filter.isHidden = true
                
            } else {
                let alertVC = UIAlertController(title: "Problem", message: "Please select filter options.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
                alertVC.addAction(okAction)
                present(alertVC, animated: true, completion: nil)
            }
            
            NSLog("filter button clicked")
            
        }  else if sender.tag == 9 {
            
            NSLog("clear button clicked")
            ResetFilter()
        } else if sender.tag == 10 {
            view_filter.isHidden = false
        }
    }
    
    
    func updateFilter() {
        
        tableView_filter.reloadData()
        if sectionZero.count > 0 {
            for el in sectionZero {
                let indexp = tableView_filter.index(ofAccessibilityElement: el)
                let cell = tableView_filter.cellForRow(at: IndexPath(item: indexp, section: 0))
                
                cell?.accessoryType = .checkmark
            }
        }
    }
    
    func ResetFilter() {
        
        tableView_filter.reloadData()
        sectionZero.removeAll()
        sectionOne.removeAll()
        for i in 1...4 {
            getImagesData(valueString: String(i))
        }
        
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
//    //MARK: - Delegates
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        var img = UIImage()
//        
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            img = pickedImage;
//        }
//        
//        dismiss(animated: true, completion: nil)
//        
//        let imgVC = ImagePickerViewController(nibName:nil, bundle: nil)
//        imgVC.imageView.image = img;
//        self.navigationController?.present(imgVC, animated: true, completion: nil)
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].items.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as UITableViewCell

        //var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellReuseIdentifier)
        }
        
        
//        for v  in (cell.contentView.subviews) {
//            v.removeFromSuperview()
//        }
        
        
        if indexPath.section == 0 {
            
            if sectionZero.count > 0
            {
                if sectionZero.contains(sections[indexPath.section].items[indexPath.row] as String)
                {
                    cell.accessoryType = .checkmark
                }else{
                    cell.accessoryType = .none
                }
            }else{
                cell.accessoryType = .none
            }
            
        } else {
            
            if sectionOne.count > 0
            {
                if sectionOne.contains(sections[indexPath.section].items[indexPath.row] as String)
                {
                    cell.accessoryType = .checkmark
                }else{
                    cell.accessoryType = .none
                }
            }else{
                cell.accessoryType = .none
            }
        }
        
        
        
        
        
        //cell.selectionStyle = .none
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.backgroundColor = UIColor(hex: "E0E0E0")
        cell.tintColor = PurpleBtnColor
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].collapsed! ? 0 : 40.0
    }
    
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if cell.accessoryType == .checkmark {
            
            cell.accessoryType = .none
            //sectionOne.remove(sections[indexPath.section].items[indexPath.row])
            
            let str_selected = sections[indexPath.section].items[indexPath.row]
            
            if indexPath.section == 0 {
                for element in sectionZero {
                    let str_ele = element
                    
                    if str_ele == str_selected {
                        let indexToDelete = sectionZero.index(of: (element))
                        sectionZero.remove(at: indexToDelete!)
                        
                    }
                }
            } else {
                
                for element in sectionOne {
                    let str_ele = element
                    
                    if str_ele == str_selected {
                        let indexToDelete = sectionOne.index(of: (element))
                        sectionOne.remove(at: indexToDelete!)
                        
                    }
                }
                
            }
            

        } else {
            cell.accessoryType = .checkmark
            //sectionOne.add( sections[indexPath.section].items[indexPath.row])
            
            let str_selected = sections[indexPath.section].items[indexPath.row]
            
            if indexPath.section == 0 {
                sectionZero.append(str_selected)
            } else {
                sectionOne.append(str_selected)
            }
            
        }
        
        
        
//        if (cell != nil) {
//            
//            if cell.textLabel?.text == "All" {
//                
//                if cell.accessoryType == .checkmark {
//                    SelectAllIndexes(sec: indexPath.section)
//                } else {
//                    deSelectAllIndexes(sec: indexPath.section)
//                }
//                
//            }
//            
//        }
        
        
     //   tableView.reloadData()
        
    }
    
    
    //Deselected a row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        
        return index;
    }
    
    func getSelectedIndexes(valueString: String) {
        
        
        var dbData = NSMutableArray()
        dbData = ModelManager.getInstance().getAllData(valueType: valueString)
        print(dbData)
        
        if valueString == "1" {
            //var imgItem : ImageInfo = marrStudentData.object(at: 0) as! ImageInfo
            
            accessrios_imgs.removeAllObjects()
            
            let accessFilterItems = filterForFourLayoutsData(section0: sectionZero, section1: sectionOne, dataInfo: dbData)
            
            for imgItem in accessFilterItems {
                let im = imgItem as! ImageInfo
                accessrios_imgs.add(im.imageData)
            }
            
            accessories_collectionView?.reloadData()

            
        } else if valueString == "2" {
            
           tops_imgs.removeAllObjects()
            
            let topsFilterItems = filterForFourLayoutsData(section0: sectionZero, section1: sectionOne, dataInfo: dbData)
            
            for imgItem in topsFilterItems {
                let im = imgItem as! ImageInfo
                tops_imgs.add(im.imageData)
            }
            
            tops_collectionView?.reloadData()
            
        } else if valueString == "3" {
            
            
            bottoms_imgs.removeAllObjects()
            let bottomsFilterItems = filterForFourLayoutsData(section0: sectionZero, section1: sectionOne, dataInfo: dbData)
            
            for imgItem in bottomsFilterItems {
                let im = imgItem as! ImageInfo
                bottoms_imgs.add(im.imageData)
            }
            
            bottoms_collectionView?.reloadData()
            
        } else if valueString == "4" {
            
            footwears_imgs.removeAllObjects()
            let footwaresFilterItems = filterForFourLayoutsData(section0: sectionZero, section1: sectionOne, dataInfo: dbData)
            
            for imgItem in footwaresFilterItems {
                let im = imgItem as! ImageInfo
                footwears_imgs.add(im.imageData)
            }
            
            footwears_collectionView?.reloadData()
        }
        
        
        
    }
    
    
    
    func filterForFourLayoutsData(section0:[String], section1: [String], dataInfo:NSMutableArray) -> NSMutableArray {
        
        
        let filtered_data = NSMutableArray()
        
        //Filter options for styles
        
        for filter_d in section0 {
            
            let str_filter = filter_d
            
            for item in dataInfo {
                
                let info = item as! ImageInfo
                //var arr_style = info.styles.components(separatedBy:",")
            
                let arr_style = info.styles.components(separatedBy:",")
                
                for style in arr_style {
                    
                    let str_img = style
                    
                    if str_filter == str_img {
                        
                        if filtered_data.contains(info) {
                            
                        } else {
                            filtered_data.add(info)
                        }
                    }
                }
            }
        }
        
        
        
        
        for filter_data in section1 {
            
            let str_filter = filter_data
            
            for item in dataInfo {
                
                let info = item as! ImageInfo
                //var arr_style = info.styles.components(separatedBy:",")
                
                let arr_colors = info.imageColors.components(separatedBy:",")
                
                for color in arr_colors {
                    
                    let str_img = color
                    
                    if str_filter == str_img {
                        
                        if filtered_data.contains(info) {
                            
                        } else {
                            filtered_data.add(info)
                        }
                    }
                }
            }
        }
        
        
        
        
        return filtered_data
    }
    
    
    
    func SelectAllIndexes(sec: Int) {
        
        let totalRows = tableView_filter.numberOfRows(inSection: sec)
        
        for row in 0..<totalRows {
            
            //let indexPath = IndexPath(item: row, section: 0)
            
            tableView_filter.selectRow(at: IndexPath(item: row, section: sec), animated: false, scrollPosition: UITableViewScrollPosition.none)
            
            //tableView_filter.reloadRows(at: [indexPath], with: .top)
            
            let cell = tableView_filter.cellForRow(at: IndexPath(item: row, section: sec))
            
            cell?.accessoryType = .checkmark
              
        }
    }
    
    
    func deSelectAllIndexes(sec: Int) {
        
        let totalRows = tableView_filter.numberOfRows(inSection: sec)
        
        for row in 0..<totalRows {
            
            //let indexPath = IndexPath(item: row, section: 0)
            
            tableView_filter.selectRow(at: IndexPath(item: row, section: sec), animated: false, scrollPosition: UITableViewScrollPosition.none)
            
            //tableView_filter.reloadRows(at: [indexPath], with: .top)
            
            let cell = tableView_filter.cellForRow(at: IndexPath(item: row, section: sec))
            
            cell?.accessoryType = .none
            
        }
        
    }
    
    //Edit and Delete UI Design
    func loadCellOptions() {
        
        options_bg.frame = CGRect(x:0, y:0, width:SCREENWIDTH, height: SCREENHEIGHT)
        options_bg.backgroundColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue:224.0/255.0, alpha: 0.7)

        options_bg_mini.frame = CGRect(x:75 * WIDTHTHEME, y:280 * HEIGHTTHEME, width:SCREENWIDTH - (150 * WIDTHTHEME), height: 110 * HEIGHTTHEME)
        options_bg_mini.backgroundColor = UIColor(red: 235.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1.0)
        options_bg_mini.layer.borderWidth = 1.0
        options_bg_mini.layer.borderColor = UIColor.lightGray.cgColor
        options_bg_mini.layer.cornerRadius = 3
        options_bg.addSubview(options_bg_mini)
        
        edit_btn.frame = CGRect(x: 10 * WIDTHTHEME, y: 10 * HEIGHTTHEME, width: options_bg_mini.frame.size.width - (20 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        edit_btn.backgroundColor = UIColor.white
        edit_btn.tag = 1
        edit_btn.setTitle("Edit", for: UIControlState.normal)
        edit_btn.setTitleColor(PinkBtnColor, for: UIControlState.normal)
        edit_btn.layer.borderWidth = 1.0
        edit_btn.layer.borderColor = UIColor.lightGray.cgColor
        edit_btn.layer.cornerRadius = 3
        edit_btn.addTarget(self, action: #selector(MainViewController.optionsBtnAction(sender:)), for: .touchUpInside)
        options_bg_mini.addSubview(edit_btn)
        
        delete_btn.frame = CGRect(x: 10 * WIDTHTHEME, y: 60 * HEIGHTTHEME, width: options_bg_mini.frame.size.width - (20 * WIDTHTHEME), height: 40 * HEIGHTTHEME)
        delete_btn.backgroundColor = UIColor.white
        delete_btn.tag = 2
        delete_btn.setTitle("Delete", for: UIControlState.normal)
        delete_btn.setTitleColor(PinkBtnColor, for: UIControlState.normal)
        delete_btn.layer.borderWidth = 1.0
        delete_btn.layer.borderColor = UIColor.lightGray.cgColor
        delete_btn.layer.cornerRadius = 3
        delete_btn.addTarget(self, action: #selector(MainViewController.optionsBtnAction(sender:)), for: .touchUpInside)
        options_bg_mini.addSubview(delete_btn)
        
        
        self.view.addSubview(options_bg)
    }
    
    
    func optionsBtnAction(sender: UIButton!) {
        
        var ImagesData = NSMutableArray()
        
        print(ImagesData)
        self.options_bg.isHidden = true
        
        var indexPaths = [IndexPath]()
        
        if options_bg.tag == 1 {
            indexPaths = (self.accessories_collectionView?.indexPathsForVisibleItems)!
            ImagesData = ModelManager.getInstance().getAllData(valueType: "1")
        } else if(options_bg.tag == 2) {
            indexPaths = (self.tops_collectionView?.indexPathsForVisibleItems)!
            ImagesData = ModelManager.getInstance().getAllData(valueType: "2")
        } else if(options_bg.tag == 3) {
            indexPaths = (self.bottoms_collectionView?.indexPathsForVisibleItems)!
            ImagesData = ModelManager.getInstance().getAllData(valueType: "3")
        } else if(options_bg.tag == 4) {
            indexPaths = (self.footwears_collectionView?.indexPathsForVisibleItems)!
            ImagesData = ModelManager.getInstance().getAllData(valueType: "4")
        }
        
        let indexP : IndexPath = indexPaths[0] as IndexPath
        let img_info : ImageInfo = ImagesData.object(at: indexP.row) as! ImageInfo
        
        if sender.tag == 1 {
            
            let pic_info : PictureInfoVC = PictureInfoVC()
            pic_info.popDelegate = self
            pic_info.btn_title_text = "Update"
            pic_info.selected_index = String(options_bg.tag)
            
            pic_info.image_info = img_info
            pic_info.selected_imageVC.image = UIImage(data: img_info.imageData)
            self.navigationController?.pushViewController(pic_info, animated: true)
            
            
        } else if sender.tag == 2 {
            
            var isDeleted = Bool()
            
            if options_bg.tag == 1 {
                //indexPaths = (self.accessories_collectionView?.indexPathsForVisibleItems)!
                isDeleted = ModelManager.getInstance().deleteImageData(img_info, valueType: "1")
            } else if(options_bg.tag == 2) {
                //indexPaths = (self.tops_collectionView?.indexPathsForVisibleItems)!
                isDeleted = ModelManager.getInstance().deleteImageData(img_info, valueType: "2")
            } else if(options_bg.tag == 3) {
                //indexPaths = (self.bottoms_collectionView?.indexPathsForVisibleItems)!
                isDeleted = ModelManager.getInstance().deleteImageData(img_info, valueType: "3")
            } else if(options_bg.tag == 4) {
                //indexPaths = (self.footwears_collectionView?.indexPathsForVisibleItems)!
                isDeleted = ModelManager.getInstance().deleteImageData(img_info, valueType: "4")
            }
            
            if isDeleted {
                NSLog("Record deleted successfully.")
                
                if options_bg.tag == 1 {
                    getImagesData(valueString: "\(options_bg.tag)")
                } else if options_bg.tag == 2 {
                    getImagesData(valueString: "\(options_bg.tag)")
                } else if options_bg.tag == 3 {
                    getImagesData(valueString: "\(options_bg.tag)")
                } else if options_bg.tag == 4 {
                    getImagesData(valueString: "\(options_bg.tag)")
                }
                
            } else {
                NSLog("Error in deleting.")
                //Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
            
        }
        
        //deleteImageData
    }
    
    
}



extension MainViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        
        // Adjust the height of the rows inside the section
        tableView_filter.beginUpdates()
        for i in 0 ..< sections[section].items.count {
            
            tableView_filter.reloadRows(at: [NSIndexPath(row: i, section: section) as IndexPath], with: UITableViewRowAnimation.automatic)
        }
        
        tableView_filter.endUpdates()
    }
    
}



extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    //func rightWillOpen() {
        //print("SlideMenuControllerDelegate: rightWillOpen")
    //}
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}



