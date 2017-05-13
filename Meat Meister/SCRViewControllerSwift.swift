//
//  SCRViewControllerSwift.swift
//  
//
//  Created by Deenadayal Loganathan on 3/6/16.
//
//

import UIKit

class SCRViewControllerSwift: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var topconst: NSLayoutConstraint!
    @IBOutlet weak var btmConst: NSLayoutConstraint!
     @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    weak var activeField: UITextField?
    
    @IBOutlet weak var txtspecial: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        txtspecial.delegate = self
         //self.topconst.active = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
        print(textField)
    }
    
    func keyboardDidShow(notification: NSNotification) {
       
      //self.topconst.active = false
       
        if let activeField = self.activeField, keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
                print(activeField.frame)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
}


