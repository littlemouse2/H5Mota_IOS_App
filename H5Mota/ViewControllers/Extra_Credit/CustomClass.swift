//  EXTRA CREDIT IBDesignable
//
//  DesignViewController.swift
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//  custom class: this file is used to IBDesignable demo / extra credit
//

import Foundation
import UIKit
import QuartzCore

//the custom class is used to lively see changes in the storyboard / xib
@IBDesignable open class CustomClass: UIImageView{
    
    //change properties reflected in the storyboard / xib
    @IBInspectable var cornerRadius: Double {
         get {
             print("a")
           return Double(self.layer.cornerRadius)
         }set {
            print("b")
           self.layer.cornerRadius = CGFloat(newValue)
         }
    }
    @IBInspectable var borderWidth: Double {
          get {
            return Double(self.layer.borderWidth)
          }
          set {
           self.layer.borderWidth = CGFloat(newValue)
          }
    }
    @IBInspectable var borderColor: UIColor? {
         get {
            return UIColor(cgColor: self.layer.borderColor!)
         }
         set {
            self.layer.borderColor = newValue?.cgColor
         }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
           return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
           self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
           return self.layer.shadowOpacity
        }
        set {
           self.layer.shadowOpacity = newValue
       }
    }
}



