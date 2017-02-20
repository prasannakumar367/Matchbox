//
//  RightViewController.swift
//  MatchBox Closet
//
//  Copyright © 2016 Prasanna kumar. All rights reserved.
//

import UIKit

class RightViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rect = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height) // CGFloat, Double, Int
        let label = UILabel()
        label.frame = rect
        label.textAlignment = NSTextAlignment.center
        label.text = "Profile viewcontroller"
        label.backgroundColor = UIColor.brown
        self.view.addSubview(label)
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView);
        
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
    //        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController
    //        self.navigationController?.pushViewController(subContentsVC, animated: true)
    //    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainContens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
        cell.textLabel?.text = mainContens[indexPath.row]
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        
    }
    
    
    
}
