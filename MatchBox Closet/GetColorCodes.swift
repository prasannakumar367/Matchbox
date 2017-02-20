//
//  ViewController.swift
//  top3color
//
//  Created by Vijay on 06/12/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit
import CoreGraphics

class GetColorCodes: UIViewController {
//MARK:- VARIABLE DECLARATION
    var topcolor:NSArray?
    var red:String?
    var redc:Int?
    var yellow:String?
    var yellowc:Int?
    var green:String?
    var greenc:Int?
    var teal:String?
    var tealc:Int?
    var blue:String?
    var bluec:Int?
    var purple:String?
    var purplec:Int?
    var pink:String?
    var pinkc:Int?
    var brown:String?
    var brownc:Int?
    var grey:String?
    var greyc:Int?
    var white:String?
    var whitec:Int?
    var black:String?
    var blackc:Int?
    
    
    var gre:CGFloat?
    var blu:CGFloat?
    var re : CGFloat?
    var hu:CGFloat?
    var saturatio :CGFloat?
    var brightnes :CGFloat?
    var minRGB :CGFloat?
    var maxRGB :CGFloat?
    var d:CGFloat?
    var h:CGFloat?
    var totalpixel:Int?
    @IBOutlet weak var image: UIImageView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       redc=0
//    greenc=0
//        yellowc=0
//        tealc = 0
//        bluec = 0
//        purplec = 0
//        pinkc = 0
//        brownc = 0
//        greyc = 0
//        whitec = 0
//        blackc = 0
//        totalpixel = 0
//        var hue: CGFloat = 0.0
//        var saturation: CGFloat = 0.0
//        var brightness: CGFloat = 0.0
//        var alpha: CGFloat = 0.0
////         var f = Import["http://thwartedglamour.files.wordpress.com/2010/06/my-coffee-table-1-sa.jpg"]
////        f = ImageResize[image.image, ImageDimensions[f][[1]]/4]
////         var g = MedianFilter[ColorConvert[f, "Grayscale"], 2]
////         var h = DeleteSmallComponents[Thinning[Binarize[ImageSubtract[Dilation[g, 1], Erosion[g, 1]]]]]
////        convexvert = ComponentMeasurements[SelectComponents[
////            h, {"ConvexArea", "BoundingBoxArea"}, #1 / #2 > 0.7 &],
////            "ConvexVertices"][[All, 2]]
////        (* To visualize the blue polygons above: *)
////        Show[f, Graphics[{EdgeForm[{Blue, Thick}], RGBColor[0, 0, 1, 0.5],
////        Polygon @@ convexvert}]]
//
//    }
    
    

    func calculatetop3(img: UIImage) -> NSMutableArray {
        
        redc=0
        greenc=0
        yellowc=0
        tealc = 0
        bluec = 0
        purplec = 0
        pinkc = 0
        brownc = 0
        greyc = 0
        whitec = 0
        blackc = 0
        totalpixel = 0
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        applyOnPixels(image: img)
    print(redc!,yellowc!,greenc!,tealc!,bluec!,purplec!,pinkc!,brownc!,greyc!,whitec!,blackc!)
        print("total pixel :\(totalpixel!)")
        
        var redper = Double(Double(redc!*100)/Double(totalpixel!))
        var yellowper = Double(Double(yellowc!*100)/Double(totalpixel!))
        var greenper = Double(Double(greenc!*100)/Double(totalpixel!))
        var tealper = Double(Double(tealc!*100)/Double(totalpixel!))
        var blueper = Double(Double(bluec!*100)/Double(totalpixel!))
        var purpleper = Double(Double(purplec!*100)/Double(totalpixel!))
        var pinkper = Double(Double(pinkc!*100)/Double(totalpixel!))
        var brownper = Double(Double(brownc!*100)/Double(totalpixel!))
        var greyper = Double(Double(greyc!*100)/Double(totalpixel!))
        var whiteper = Double(Double(whitec!*100)/Double(totalpixel!))
        var blackper = Double(Double(blackc!*100)/Double(totalpixel!))
print("red :\(redper),yellowper:\(yellowper),greenper:\(greenper),tealper:\(tealper),blueper:\(blueper),purpleper:\(purpleper),pinkper:\(pinkper),brownper:\(brownper),greyper:\(greyper),whiteper:\(whiteper),tealper:\(blackper)")
        var list:Array = [redper,yellowper,greenper,tealper,blueper,purpleper,pinkper,brownper,greyper,whiteper,blackper]
        list = quicksort(list)
        
        var topColors = NSMutableArray()
        
        /*
         redColor = 1
         lightPinkColor = 2
         orangeColor = 3 ******
         yellowColor= 4
         lightGreenColor = 5 ******
         greenColor= 6
         lightBlueColor = 7
         blueColor = 8
         purpleColor = 9
         brownColor = 10 *****
         grayColor = 11
         whiteColor = 12
         blackColor = 13
         fullBrownColor = 14
         */
        
        print(list)
        for var i in (0...2)
        {
            if list[i] == redper
            {
             print("\(i+1) is red")
                topColors.add("1")
                print(redper)
            }
            if list[i] == yellowper
            {
                print("\(i+1) is yellow")
                topColors.add("4")
                print(yellowper)
            }
            if list[i] == greenper
            {
                print("\(i+1) is green")
                topColors.add("6")
            }
            if list[i] == tealper
            {
                print("\(i+1) is teal")
            }
            if list[i] == blueper
            {
                topColors.add("8")
                print("\(i+1) is blueper")
            }
            if list[i] == purpleper
            {
                print("\(i+1) is purple")
                topColors.add("9")
            }
            if list[i] == pinkper
            {
                print("\(i+1) is pinkper")
                topColors.add("2")
            }
            if list[i] == brownper
            {
                print("\(i+1) is brownper")
                topColors.add("14")
                print(brownper)
            }
            if list[i] == greyper
            {
                print("\(i+1) is greyper")
                topColors.add("11")
            }
            if list[i] == whiteper
            {
                print("\(i+1) is whiteper")
                topColors.add("12")
            }
            if list[i] == blackper
            {
                print("\(i+1) is blackper")
                topColors.add("13")
            }
        }
        
        
       // let gl: CAGradientLayer
        
//        for(itemcolor in topColors) {
//            
//            print("%@", itemcolor)
//            
//        }
        
        
//        for (index, element) in topColors.enumerated() {
//            
//            print(element, index)
//        }
        
        
        return topColors
    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else { return a }
        
        let pivot = a[a.count/2]
        let less = a.filter { $0 < pivot }
        let equal = a.filter { $0 == pivot }
        let greater = a.filter { $0 > pivot }
        
        return quicksort(greater)  + equal + quicksort(less)
    }

    
    //MARK:-COLOUR DETECTION
    func whichColor(color: UIColor){
        
        var (h,s,b,a) : (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
        _ = color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        var colorTitle = ""
        switch (h, s, b) {
            // red
        case (0...0.138, 0.88...1.00, 0.75...1.00):
            redc = redc! + 1
        // yellow
        case (0.139...0.175, 0.30...1.00, 0.30...1.00):
            yellowc = yellowc! + 1
        // green
        case (0.176...0.422, 0.30...1.00, 0.39...1.00):
            greenc = greenc! + 1
        // teal
        case (0.423...0.494, 0.30...1.00, 0.54...1.00):
            tealc = tealc! + 1
        // blue
        case (0.495...0.667, 0.30...1.00, 0.60...1.00):
            bluec = bluec! + 1
        // purple
        case (0.668...0.792, 0.30...1.00, 0.40...1.00):
            purplec = purplec! + 1
        // pink
        case (0.793...0.977, 0.30...1.00, 0.80...1.00):
            pinkc = pinkc! + 1
        // brown
        case (0...0.097, 0.50...1.00, 0.25...0.58):
            brownc = brownc! + 1
        // white
        case (0...1.00, 0...0.05, 0.95...1.00):
            whitec = whitec! + 1
        // grey
        case (0...1.00, 0, 0.25...0.94):
            greyc = greyc! + 1
        // black
        case (0...1.00, 0...1.00, 0...0.07):
            blackc = blackc! + 1
        default: break
//            print("empty def")
//            colorTitle = "Color didn't fit defined ranges..."
        }
        
    }
    //MARK:-MAX MIN FUN
    func MIN  (a: CGFloat, b:   CGFloat) -> CGFloat {
        if a > b {
            return b
        }
        return a
    }
    func MAX (a: CGFloat, b: CGFloat) -> CGFloat
    {
        if a < b {
            return b
        }
        return a

}
 //MARK:-IMAGE PROCESSING
    
    
    func createARGBBitmapContext(inImage: CGImage) -> CGContext {
        var bitmapByteCount = 0
        var bitmapBytesPerRow = 0
        
        let pixelsWide = inImage.width
        let pixelsHigh = inImage.height
        bitmapBytesPerRow = Int(pixelsWide) * 4
        bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        // Make sure and release colorspace before returning
        return context!
    }
    
  func applyOnPixels(image:UIImage)  {
        let inImage = image.cgImage
        let context = self.createARGBBitmapContext(inImage: inImage!)
        let pixelsWide = inImage?.width
        let pixelsHigh = inImage?.height
        let rect = CGRect(x:0, y:0, width:Int(pixelsWide!), height:Int(pixelsHigh!))
        let bitmapBytesPerRow = Int(pixelsWide!) * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh!)
        //Clear the context
        context.clear(rect)
        // Draw the image to the bitmap context. Once we draw, the memory
        // allocated for the context for rendering will then contain the
        // raw image data in the specified color space.
        context.draw(inImage!, in: rect)
        // Now we can get a pointer to the image data associated with the bitmap
        // context.
        var data = context.data
        var dataType = data?.assumingMemoryBound(to: UInt8.self)
        let point = CGPoint(x: 0,y :0) // CGFloat, Double, Int
        
        for x in 0 ..< Int(pixelsWide!)  {
            for y in 0 ..< Int(pixelsHigh!)  {
                let offset = 4*((Int(pixelsWide!) * Int(y)) + Int(x))
                let alpha = (dataType?[offset])!
                 let red = CGFloat((dataType?[offset+1])!)/255
                let green = CGFloat((dataType?[offset+2])!)/255
                let blue = CGFloat((dataType?[offset+3])!)/255
                var testColor = UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
                totalpixel = totalpixel!+1
                whichColor(color: testColor)
                
            }
            
        }
        
    }
    
    
}

