//
//  ExpandingCollectionViewCell.swift
//  Expanding Collection View Cell
//
//  Created by Tom Bastable on 06/02/2020.
//  Copyright © 2020 Tom Bastable. All rights reserved.
//

import Foundation
import UIKit

class ExpandingCell: UIView {
    
    var vc:UIViewController?
    var origin: CGPoint?
    var isExpanded: Bool = false
    var smallFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    var isUIView: Bool = false
    //original frame sizes of UIView Properties
    var originalImageViewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var originalLabelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    //
    
    ///This is only to be implemented if you're passing in a Cell to copy. If you're using a Storyboard UIVIew, assign the class and assign the property in the VC.
    func initWith(cell:UICollectionViewCell, vc: UIViewController, origin: CGPoint){
        
        self.vc = vc
        self.origin = origin
        self.backgroundColor = .white
        //set frame
        self.frame = cell.frame
        //loop through subviews
        let subviews = cell.contentView.subviews
        //add subviews to expanding view
        for view in subviews {
            if let item = view as? UIImageView{
                let imageView:UIImageView = item.clone()
                imageView.frame = item.frame
                self.addSubview(imageView)
                print("imageView")
            }else if let item = view as? UILabel{
                let label:UILabel = UILabel(frame: item.frame)
                label.text = item.text
                label.font = item.font
                //label.backgroundColor = item.backgroundColor
                label.textColor = item.textColor
                label.textAlignment = item.textAlignment
                self.addSubview(label)
                print("label")
            }
        }
        //get the frame of the cell with the vc context
        self.frame.origin = origin
        smallFrame = self.frame
        vc.view.addSubview(self)
        //expand the view to full screen
        UIView.animate(withDuration: 0.6, animations: {
            self.frame = vc.view.frame
        }, completion: { (finished) in
            self.isExpanded = true
        })
        
    }
    
    ///To be used with a storyboard UIView. This will be an identical copy initially from the collectionviewcell. You can either resize as the view animates, or add constraints so that the contents resize correctly.
    func expandView(origin: CGPoint){
        isUIView = true
        self.frame.origin = origin
        self.isHidden = false
        self.smallFrame = self.frame
        originalImageViewFrame = imageView.frame
        originalLabelFrame = label.frame
        UIView.animate(withDuration: 0.6, animations: {
            self.frame = self.superview!.frame
            self.imageView.frame = CGRect(x: 0, y: self.imageView.frame.origin.y + 44, width: self.superview!.frame.width, height: 200)
            self.label.frame = CGRect(x: 8, y: self.label.frame.origin.y + 44, width: self.label.frame.width, height: self.label.frame.height)
        }, completion: { (finished) in
            self.isExpanded = true
        })
    }
    
    func shrinkCell(){
        
        //expand the view to full screen
        UIView.animate(withDuration: 0.6, animations: {
            self.frame = self.smallFrame
            if self.isUIView{
                self.imageView.frame = self.originalImageViewFrame
                self.label.frame = self.originalLabelFrame
            }
        }, completion: { (finished) in
            self.isExpanded = false
            self.isHidden = true
            if !self.isUIView{
            self.removeFromSuperview()
            }
        })
        
    }
}

extension UIImageView{

    func clone() -> UIImageView{

        let locationOfCloneImageView = CGPoint(x: 0, y: 0)
        //x and y coordinates of where you want your image. (More specifically, the x and y coordinated of where you want the CENTER of your image to be)
        let cloneImageView = UIImageView(image: self.image)
        cloneImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        //same size as old image view
        cloneImageView.alpha = self.alpha
        //same view opacity
        cloneImageView.layer.opacity = self.layer.opacity
        //same layer opacity
        cloneImageView.clipsToBounds = self.clipsToBounds
        //same clipping settings
        cloneImageView.backgroundColor = self.backgroundColor
        //same BG color
        if let aColor = self.tintColor {
            self.tintColor = aColor
        }
        //matches tint color.
        cloneImageView.contentMode = self.contentMode
        //matches up things like aspectFill and stuff.
        cloneImageView.isHighlighted = self.isHighlighted
        //matches whether it's highlighted or not
        cloneImageView.isOpaque = self.isOpaque
        //matches can-be-opaque BOOL
        cloneImageView.isUserInteractionEnabled = self.isUserInteractionEnabled
        //touches are detected or not
        cloneImageView.isMultipleTouchEnabled = self.isMultipleTouchEnabled
        //multi-touches are detected or not
        cloneImageView.autoresizesSubviews = self.autoresizesSubviews
        //matches whether or not subviews resize upon bounds change of image view.
        //cloneImageView.hidden = originalImageView.hidden;//commented out because you probably never need this one haha... But if the first one is hidden, so is this clone (if uncommented)
        cloneImageView.layer.zPosition = self.layer.zPosition + 1
        //places it above other views in the parent view and above the original image. You can also just use `insertSubview: aboveSubview:` in code below to achieve this.
        self.superview?.addSubview(cloneImageView)
        //adds this image view to the same parent view that the other image view is in.
        cloneImageView.center = locationOfCloneImageView
        //set at start of code.

        return cloneImageView
    }


}
