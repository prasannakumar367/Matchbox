//
//  ImageInfo.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 08/01/17.
//  Copyright © 2017 Prasanna kumar. All rights reserved.
//

import UIKit

class ImageInfo: NSObject {
    
    var categoryName: String = String()
    var categoryType: String = String()
    var imageData: Data = Data()
    var imageColors : String = String()
    var styles : String = String()
    
    //CREATE TABLE "accessories" ("category_name" TEXT, "category_type" INTEGER, "image_data" BLOB, "image_colors" BLOB, "styles" BLOB)
}
