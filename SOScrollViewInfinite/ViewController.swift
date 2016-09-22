//
//  ViewController.swift
//  SOScrollViewInfinite
//
//  Created by Hitesh on 9/22/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit

let kImageWidth: CGFloat = 128.0
let kImageHeight: CGFloat = 128.0
let kPadding: CGFloat = 10.0
let kNumImages : CGFloat = 3

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrInfinite: UIScrollView!
    let slideImages : NSArray = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg"]
    var intCountArray : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrInfinite.delegate! = self
        
        intCountArray = CGFloat(slideImages.count)
        self.setInfiniteScrollView()
    }
    
    //MARK: Set Infinite ScrollView
    func setInfiniteScrollView() {
        for i in 0..<slideImages.count {
            self.addImage(withName: slideImages[i] as! String, atPosition: i)
        }
        for i in 0..<slideImages.count {
            self.addImage(withName: slideImages[i] as! String, atPosition: i + slideImages.count)
        }
        for i in 0..<slideImages.count {
            self.addImage(withName: slideImages[i] as! String, atPosition: i + 2 * slideImages.count)
        }
        scrInfinite.contentSize = CGSize(width: kNumImages * CGFloat(slideImages.count) * kImageWidth, height: kImageHeight)
        scrInfinite.scrollRectToVisible(CGRect(x: kImageWidth, y: 0, width: kImageWidth, height: kImageHeight), animated: false)
    }
    
    
    func addImage(withName imageString: String, atPosition position: Int) {
        let image = UIImage(named: imageString)!
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: CGFloat(position) * (kImageWidth + kPadding), y: 0, width: kImageWidth, height: kImageHeight)
        scrInfinite.addSubview(imageView)
    }

    
    //MARK: UIScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= (intCountArray - 1) * kImageWidth {
            scrInfinite.contentOffset = CGPoint(x: (intCountArray + (intCountArray - 1)) * kImageWidth, y: 0)
        }
        else if scrollView.contentOffset.x >= (2 * (intCountArray)) * kImageWidth {
            scrInfinite.contentOffset = CGPoint(x: (intCountArray) * kImageWidth, y: 0)
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= (intCountArray - 1) * kImageWidth {
            scrInfinite.contentOffset = CGPoint(x: (intCountArray + (intCountArray - 1)) * kImageWidth, y: 0)
        }
        else if scrollView.contentOffset.x >= (2 * (intCountArray)) * kImageWidth {
            scrInfinite.contentOffset = CGPoint(x: (intCountArray) * kImageWidth, y: 0)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

