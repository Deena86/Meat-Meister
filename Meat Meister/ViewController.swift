//
//  ViewController.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 12/23/15.
//  Copyright © 2015 Deena. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    let url:String="http://ec2-52-91-103-107.compute-1.amazonaws.com/api/"
    var intChickenPriceNoSkin:CGFloat = 0.0
    var intMuttonPrice:CGFloat = 0.0
    var intChickenPriceSkin:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segMutton")
        {
            let destinationVC = segue.destinationViewController as! viewOrder
            destinationVC.strSelection = "Mutton"
            
          
        }
        else if (segue.identifier == "segChicken")
        {
           let destinationVC = segue.destinationViewController as! viewOrder
           destinationVC.strSelection = "Chicken"
        }
        
       else if segue.identifier == "segPop" {
            let popoverViewController = segue.destinationViewController as! viewPop
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
        
        else if segue.identifier == "segPrice1"
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


}

