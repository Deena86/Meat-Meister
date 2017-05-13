//
//  viewOrder.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 12/23/15.
//  Copyright © 2015 Deena. All rights reserved.
//

import UIKit
import MessageUI

class viewOrder: UIViewController,MFMailComposeViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate,ValidationDelegate {
    var arryQtydecimql = ["0","1/4","1/2","3/4"]
  
    var arryChicketCatg = ["With Skin","Skinless"]
    var arryQtydecimalprice = [0,0.25,0.5,0.75]
    var arryQty = [0,1,2,3,4,5,6,7,8,9,10]
    var strSelection:String = "No Selection"
    var kbHeight: CGFloat!
  
    var intMuttonPrice:CGFloat = 0.0
    var intPrice:CGFloat = 0.0
    var strChickenspecial:String = ""
    @IBOutlet weak var lblError: UILabel!
    var intChickenPriceSkin:CGFloat = 0.0
   
    var intChickenPriceNoSkin:CGFloat = 0.0
    var intQTY:CGFloat = 0.0
    let url:String="http://ec2-52-91-103-107.compute-1.amazonaws.com/api/"
    let validator = Validator()
    var activeField: UITextField?
    
    @IBOutlet weak var consBottom: NSLayoutConstraint!
    @IBOutlet weak var stckBody: UIStackView!
    @IBOutlet weak var pkrChkCat: UIPickerView!
    
    
   
    @IBOutlet weak var txtSpecialInstructions: UITextField!
    
    @IBOutlet weak var txtLandmark: UITextField!
    
    @IBOutlet weak var txtPhoneno: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtStreetNm: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var lblselection: UILabel!
    @IBOutlet weak var pkrQtyDecimal: UIPickerView!
    @IBOutlet weak var pkrQty: UIPickerView!
    let Fields =  ["Email", "Phone"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pkrQty.delegate = self
        pkrQtyDecimal.delegate = self
        pkrQty.dataSource = self
        pkrQtyDecimal.dataSource = self
        lblselection.text = "\(strSelection) has been selected"
        //  txtCity.delegate = self
        txtEmail.delegate = self
        
        
        txtLandmark.delegate = self
        
        txtAddress.delegate = self
        
        txtName.delegate = self
        txtPhoneno.delegate = self
        
        // txtState.delegate = self
        txtStreetNm.delegate = self
        txtSpecialInstructions.delegate = self
        
        //txtZipCd.delegate = self
        pkrChkCat.delegate = self
        //registerForKeyboardNotifications()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewOrder.dismissKeyboard))
        view.addGestureRecognizer(tap)
       // registerForKeyboardNotifications()
        if strSelection == "Chicken"
        {
            pkrChkCat.hidden = false
            
        }
        else
        {
            pkrChkCat.hidden = true
        }
      //  self.scrollView.contentOffset = CGPoint(x: 1000, y: 0)
       // print("test\(self.scrollView.contentOffset)")
       // self.scrollView.directionalLockEnabled = true
        
       
        
        self.txtLandmark.delegate = self
        
        lblError.hidden = true
        
        validator.registerField(txtName,errorLabel:lblError, rules: [RequiredRule()])
        validator.registerField(txtEmail,errorLabel:lblError, rules: [RequiredRule(),EmailRule()])
        validator.registerField(txtPhoneno,errorLabel:lblError, rules: [RequiredRule(),PhoneNumberRule()])
        
        
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("here")
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            validationRule.textField.layer.borderColor = UIColor.greenColor().CGColor
            validationRule.textField.layer.borderWidth = 0.5
            
            }, error:{ (validationError) -> Void in
                print("error")
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.textField.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField.layer.borderWidth = 1.0
        })
     
      
        lblPrice.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        dispatch_async(dispatch_get_main_queue()){
            Data.getData (self.url+"Price", success:{(iTunesData) -> Void in
                let json = JSON(data: iTunesData)
                
                
                
                // let json = JSON(data: dataFromNetworking)
                for (index, object) in json {
                    // self.clubname.append(object["ClubName"].stringValue)
                    // self.clubname[object["ClubName"].stringValue] = Int(object["ClubID"].stringValue)
                    
                    print(object)
                    if object["MeatName"].stringValue == "Mutton"
                    {
                        
                        self.intMuttonPrice = CGFloat(Double(object["Amount"].stringValue)!)
                    }
                    else if object["MeatName"].stringValue == "Chicken - With Skin"
                    {
                        self.intChickenPriceSkin = CGFloat(Double(object["Amount"].stringValue)!)
                    }
                        
                    else if object["MeatName"].stringValue == "Chicken - Skinless"
                    {
                        self.intChickenPriceNoSkin = CGFloat(Double(object["Amount"].stringValue)!)
                    }
                    
                }
                
                
                
                /* self.intQTY = (CGFloat(self.arryQty[self.pkrQty.selectedRowInComponent(0)]) + CGFloat(self.arryQtydecimalprice[self.pkrQtyDecimal.selectedRowInComponent(0)]))
                
                if self.strSelection == "Chicken"
                {
                // intPrice = intChickenPrice
                self.intPrice = ((self.intQTY) * self.intChickenPrice)
                }
                else if self.strSelection == "Mutton"
                {
                //intPrice = intChickenPrice
                self.intPrice = ((self.intQTY) * self.intMuttonPrice)
                }
                
                
                
                
                self.lblPrice.text = "₹ " + String(self.intPrice)*/
                
                
                
                
                // More soon...
            })
            
        }
        
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
       
       validator.validate(self)
        

    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["meatmeister666@gmail.com"])
        mailComposerVC.setCcRecipients(["maddydheena@gmail.com"])
        mailComposerVC.setSubject("Request for \(strSelection)")
        
        /*  if strSelection == "Chicken"
        {
        intPrice = intChickenPrice
        }
        else if strSelection == "Mutton"
        {
        intPrice = intChickenPrice
        }*/
        print("mail \(intPrice)")
        var strMessage:String = " "
        if strSelection == "Chicken"
        {
             strMessage  = "<h4>New order for Meat from: </h4>" +
                "<b>Name: </b> \(String(txtName.text!)) <br><br>" +
                "<b>Meat: </b> \(String(strChickenspecial)) <br><br>" +
                "<b>QTY: </b> \(String(intQTY)) <br><br>" +
                "<b>Address: </b> \(String(txtStreetNm.text!)) <br>" +
                "<b>Address: </b> \(String(txtAddress.text!)) <br>" +
                "<b>Landmark: </b> \(txtLandmark.text!)<br><br>" +
            "<b>Phone: </b>\(txtPhoneno.text!)<br><br>"
            "<b>Phone: </b>\(txtSpecialInstructions.text!)<br><br>"
        }
        else
        {
             strMessage  = "<h4>New order for Meat from: </h4>" +
                "<b>Name: </b> \(String(txtName.text!)) <br><br>" +
                "<b>Meat: </b> \(String(strSelection)) <br><br>" +
                "<b>QTY: </b> \(String(intQTY)) <br><br>" +
                "<b>Address: </b> \(String(txtStreetNm.text!)) <br>" +
                "<b>Address: </b> \(String(txtAddress.text!)) <br>" +
                "<b>Landmark: </b> \(txtLandmark.text!)<br><br>" +
            "<b>Phone: </b>\(txtPhoneno.text!)<br><br>"
            "<b>Phone: </b>\(txtSpecialInstructions.text!)<br><br>"
        }
       
        
        mailComposerVC.setMessageBody(strMessage, isHTML: true)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        let alert = UIAlertController(title: "Thank You!", message:"Order has been Placed", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            // Put here any code that you would like to execute when
            // the user taps that OK button (may be empty in your case if that's just
            // an informative alert)
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 10)
        {
            
            return self.arryQty.count
        }
        else if (pickerView.tag == 20)
        {
            return self.arryQtydecimql.count
        }
            
        else if (pickerView.tag == 30)
        {
            return self.arryChicketCatg.count
        }
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 10)
        {
           print(String(arryQty[row]))
            return String(arryQty[row])
        }
        else if (pickerView.tag == 20)
        {
            return String(arryQtydecimql[row])
        }
            
        else if (pickerView.tag == 30)
        {
            return String(arryChicketCatg[row])
        }
        
        return "Select a Value"
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        
        let pickerLabel = UILabel()
        if (pickerView.tag == 10)
        {
            print(arryQty)
            print(arryQty[row])
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.text = String(arryQty[row])
            // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 10) // In this use your custom font
            pickerLabel.textAlignment = NSTextAlignment.Center
            return pickerLabel
            
        }
        else if (pickerView.tag == 20)
        {
            
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.text = String(arryQtydecimql[row])
            // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 10) // In this use your custom font
            pickerLabel.textAlignment = NSTextAlignment.Center
            return pickerLabel
            
        }
            
        else if (pickerView.tag == 30)
        {
            
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.text = String(arryChicketCatg[row])
            // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 10) // In this use your custom font
            pickerLabel.textAlignment = NSTextAlignment.Center
            return pickerLabel
            
        }
        
        return pickerLabel
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // myLabel.text = pickerData[row]
        //  Noofcourts = Int(court[row])!
        
        var price:CGFloat = 0.0
        print("price3 \(self.intMuttonPrice)")
        // print("price4\(self.intChickenPrice)")
        self.intQTY = (CGFloat(arryQty[pkrQty.selectedRowInComponent(0)]) + CGFloat(arryQtydecimalprice[pkrQtyDecimal.selectedRowInComponent(0)]))
        
        
        if strSelection == "Chicken"
        {
            
            // intPrice = intChickenPrice
            if arryChicketCatg[pkrChkCat.selectedRowInComponent(0)] == "With Skin"
            {
                strChickenspecial = "Chicken With Skin"
                
                self.intPrice = ((self.intQTY) * self.intChickenPriceSkin)
                price = ((self.intQTY) * self.intChickenPriceSkin)
            }
            else if arryChicketCatg[pkrChkCat.selectedRowInComponent(0)] == "Skinless"
            {
                strChickenspecial = "Chicken Skinless"
                self.intPrice = ((self.intQTY) * self.intChickenPriceNoSkin)
                price = ((self.intQTY) * self.intChickenPriceNoSkin)
            }
            
            
        }
        else if strSelection == "Mutton"
        {
            //intPrice = intChickenPrice
            self.intPrice = ((self.intQTY) * self.intMuttonPrice)
            price = ((self.intQTY) * self.intMuttonPrice)
        }
        
        
        
        print("Total \(price)")
       // lblPrice.text = "₹ " + String(price)
        self.intPrice = price
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segPop1"
        {
            let popoverViewController = segue.destinationViewController as! viewPop
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
        else if segue.identifier == "segPrice"
        {
            let popoverViewController = segue.destinationViewController as! viewPrice
            popoverViewController.intMuttonPrice = self.intMuttonPrice
            popoverViewController.intChickenskinlessPrice = self.intChickenPriceNoSkin
            popoverViewController.intChickenskinPrice = self.intChickenPriceSkin
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    
    /*func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWasShown(notification: NSNotification)
    {
     
        
        if let activeField = self.activeField, keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.Scrollview.contentInset = contentInsets
            self.Scrollview.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {
                self.Scrollview.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
        
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        let contentInsets = UIEdgeInsetsZero
        self.Scrollview.contentInset = contentInsets
        self.Scrollview.scrollIndicatorInsets = contentInsets

    }*/
    
    
    
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
    //    deregisterFromKeyboardNotifications()
        
    }
    
    func validationSuccessful() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func validationFailed(errors:[UITextField:ValidationError]) {
        print("Validation FAILED!")
    }
    
    
    
    
}
