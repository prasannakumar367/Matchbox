//
//  ModelManager.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 08/01/17.
//  Copyright © 2017 Prasanna kumar. All rights reserved.
//

import UIKit
import FMDB

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    //CREATE TABLE "accessories" ("category_name" TEXT, "category_type" INTEGER, "image_data" BLOB, "image_colors" BLOB, "styles" BLOB)
    
//    var categoryName: String = String()
//    var categoryType: String = String()
//    var imageData: NSData = NSData()
//    var imageColors : NSMutableArray = NSMutableArray()
//    var styles : NSMutableArray = NSMutableArray()
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Utilities.getPath(fileName: "MatchBox_closet.sqlite"))
        }
        return sharedInstance
    }
    
    //let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO student_info (Name, Marks) VALUES (?, ?)", withArgumentsIn: [studentInfo.Name, studentInfo.Marks])
    
    func addImageData(_ imgInfo: ImageInfo, valueString: String) -> Bool {
        sharedInstance.database!.open()
        
        var isInserted = Bool()
        
        if valueString == "1" {
            //catName = "accessories"
            
            isInserted = sharedInstance.database!.executeUpdate("INSERT INTO accessories_master (category_name, category_type, image_colors, styles, image_data) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [imgInfo.categoryName, imgInfo.categoryType, imgInfo.imageColors, imgInfo.styles, imgInfo.imageData])
            
        } else if valueString == "2" {
            //catName = "tops"
            
            isInserted = sharedInstance.database!.executeUpdate("INSERT INTO tops_master (category_name, category_type, image_colors, styles, image_data) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [imgInfo.categoryName, imgInfo.categoryType, imgInfo.imageColors, imgInfo.styles, imgInfo.imageData])
            
        } else if valueString == "3" {
            //catName = "bottoms"
            
            isInserted = sharedInstance.database!.executeUpdate("INSERT INTO bottoms_master (category_name, category_type, image_colors, styles, image_data) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [imgInfo.categoryName, imgInfo.categoryType, imgInfo.imageColors, imgInfo.styles, imgInfo.imageData])
            
        } else if valueString == "4" {
            //catName = "footwares"
            
            isInserted = sharedInstance.database!.executeUpdate("INSERT INTO footwares_master (category_name, category_type, image_colors, styles, image_data) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [imgInfo.categoryName, imgInfo.categoryType, imgInfo.imageColors, imgInfo.styles, imgInfo.imageData])
            
        }
        
        sharedInstance.database!.close()
        return isInserted
    }
    
    
//    func updateStudentData(_ imgInfo: ImageInfo) -> Bool {
//        sharedInstance.database!.open()
//        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE student_info SET categoryName=?, Marks=? WHERE RollNo=?", withArgumentsIn: [studentInfo.Name, studentInfo.Marks, studentInfo.RollNo])
//        sharedInstance.database!.close()
//        return isUpdated
//    }
//    
//    func deleteStudentData(_ imgInfo: ImageInfo) -> Bool {
//        sharedInstance.database!.open()
//        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM student_info WHERE categoryName=?", withArgumentsIn: [studentInfo.RollNo])
//        sharedInstance.database!.close()
//        return isDeleted
//    }
    
    
    func getAllData(valueType : String) -> NSMutableArray {
        
        sharedInstance.database!.open()
        
        var resultSet : FMResultSet!
        
        
        
        if valueType == "1" {
            
            resultSet = sharedInstance.database!.executeQuery("SELECT * FROM accessories_master ", withArgumentsIn: nil)
            
            
            //let resultSet!: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM student_info", withArgumentsIn: nil)
            
            
        } else if valueType == "2" {
            
            resultSet = sharedInstance.database!.executeQuery("SELECT * FROM tops_master ", withArgumentsIn: nil)

        } else if valueType == "3" {
            
            resultSet = sharedInstance.database!.executeQuery("SELECT * FROM bottoms_master ", withArgumentsIn: nil)

        } else if valueType == "4" {
            
            resultSet = sharedInstance.database!.executeQuery("SELECT * FROM footwares_master ", withArgumentsIn: nil)
            
        }
        
        let marrImgInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let imgInfo : ImageInfo = ImageInfo()
                imgInfo.categoryName = resultSet.string(forColumn: "category_name")
                imgInfo.categoryType = resultSet.string(forColumn: "category_type")
                
                //let imagePt = UIImage(data: resultSet.data(forColumn: "image_data") as Data)
                
                
                
                //let data1 = UIImagePNGRepresentation(self.selected_imageVC.image!) as NSData?
                
                //imgInfo.imageData = data1 as! Data
                
                //let imagePt = UIImage(data: resultSet.data(forColumn: "image_data") as Data)
                
                //UIImage(data: ,scale:1.0)
                
                
                
                imgInfo.imageData = resultSet.data(forColumn: "image_data") as Data
                imgInfo.imageColors = resultSet.string(forColumn: "image_colors")
                imgInfo.styles = resultSet.string(forColumn: "styles")
                
                marrImgInfo.add(imgInfo)
            }
        }
        sharedInstance.database!.close()
        return marrImgInfo
    }
    
    
    func deleteImageData(_ imgInfo: ImageInfo, valueType : String) -> Bool {
        sharedInstance.database!.open()
        
        var isDeleted = Bool()
        
        if valueType == "1" {
            
            //resultSet = sharedInstance.database!.executeQuery("SELECT * FROM accessories_master ", withArgumentsIn: nil
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM accessories_master WHERE image_data=?", withArgumentsIn: [imgInfo.imageData])
            
        } else if valueType == "2" {
            
            //resultSet = sharedInstance.database!.executeQuery("SELECT * FROM tops_master ", withArgumentsIn: nil)
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM tops_master WHERE image_data=?", withArgumentsIn: [imgInfo.imageData])
            
        } else if valueType == "3" {
            
            //resultSet = sharedInstance.database!.executeQuery("SELECT * FROM bottoms_master ", withArgumentsIn: nil)
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM bottoms_master WHERE image_data=?", withArgumentsIn: [imgInfo.imageData])
            
        } else if valueType == "4" {
            
            //resultSet = sharedInstance.database!.executeQuery("SELECT * FROM footwares_master ", withArgumentsIn: nil)
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM footwares_master WHERE image_data=?", withArgumentsIn: [imgInfo.imageData])
            
        }
        
        sharedInstance.database!.close()
        return isDeleted
    }
    
    
    func updateImageData(_ imgInfo: ImageInfo, valueString : String, selected: String) -> Bool {
        sharedInstance.database!.open()
        
        var isUpdated = Bool()
        
        //isUpdated = addImageData(imgInfo, valueString: valueString)
        
        if (selected == valueString) {
            
            if valueString == "1" {
                isUpdated = sharedInstance.database!.executeUpdate("UPDATE accessories_master SET image_colors=?, styles=? , category_type=?, category_name=? WHERE image_data=?", withArgumentsIn: [imgInfo.imageColors, imgInfo.styles, imgInfo.categoryType, imgInfo.categoryName, imgInfo.imageData])
            } else if valueString == "2" {
                isUpdated = sharedInstance.database!.executeUpdate("UPDATE tops_master SET image_colors=?, styles=? , category_type=?, category_name=? WHERE image_data=?", withArgumentsIn: [imgInfo.imageColors, imgInfo.styles, imgInfo.categoryType, imgInfo.categoryName, imgInfo.imageData])
            } else if valueString == "3" {
                isUpdated = sharedInstance.database!.executeUpdate("UPDATE bottoms_master SET image_colors=?, styles=? , category_type=?, category_name=? WHERE image_data=?", withArgumentsIn: [imgInfo.imageColors, imgInfo.styles, imgInfo.categoryType, imgInfo.categoryName, imgInfo.imageData])
            } else if valueString == "4" {
                isUpdated = sharedInstance.database!.executeUpdate("UPDATE footwares_master SET image_colors=?, styles=? , category_type=?, category_name=? WHERE image_data=?", withArgumentsIn: [imgInfo.imageColors, imgInfo.styles, imgInfo.categoryType, imgInfo.categoryName, imgInfo.imageData])
            }
            
            if isUpdated {
                NSLog("Updated in update")
            } else {
                NSLog("error in update delete")
            }
            
        } else {
            
            
            isUpdated = addImageData(imgInfo, valueString: valueString)
            
            if isUpdated {
                NSLog("image data updated")
            } else {
                NSLog("error in image data updating")
            }
            
            
            isUpdated = deleteImageData(imgInfo, valueType: selected)
            
            if isUpdated {
                NSLog("Deleted in update")
            } else {
                NSLog("error in edit delete")
            }
        }

        sharedInstance.database!.close()
        
        return isUpdated
    }
    
    
//    func updateImageData(imgInfo : ImageInfo) -> Bool {
//        sharedInstance.database!.open()
//        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE accessories_master SET image_colors=?, styles=? , category_type=?, category_name=? WHERE image_data=?", withArgumentsIn: [imgInfo.imageColors, imgInfo.styles, imgInfo.categoryName, imgInfo.categoryType, imgInfo.imageData])
//        sharedInstance.database!.close()
//        return isUpdated
//    }
    

}
