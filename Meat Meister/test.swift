//
//  test.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 3/7/16.
//  Copyright © 2016 Deena. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class test: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().enable = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
