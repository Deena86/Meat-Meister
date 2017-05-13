//
//  viewPop.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 12/24/15.
//  Copyright © 2015 Deena. All rights reserved.
//

import UIKit
import MessageUI

class viewPop: UIViewController,MFMailComposeViewControllerDelegate {

 
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var lblCall1: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCall(sender: AnyObject) {
        
        /*let phone = "tel://\(lblCall.text!)";
        print(phone)
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);*/
        if let phone:String = String("tel://\(lblCall.text!)")
        {
            let test = phone.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
          let url:NSURL = NSURL(string:test)!;
          UIApplication.sharedApplication().openURL(url);
        }
        
       // let phone = "tel://011919789989809";
        //let url:NSURL = NSURL(string:phone)!;
        
    }
    

    @IBAction func btnCall1(sender: AnyObject) {
        
        if let phone:String = String("tel://\(lblCall1.text!)")
        {
            let test = phone.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            let url:NSURL = NSURL(string:test)!;
            UIApplication.sharedApplication().openURL(url);
        }
        

    }
    
    @IBAction func btnEmail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([lblEmail.text!])
        mailComposerVC.setCcRecipients(["maddydheena@gmail.com"])
        mailComposerVC.setSubject("Contact Meat Meister")
        
        let strMessage :String = " "
        
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
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
