//
//  viewPrice.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 2/9/16.
//  Copyright © 2016 Deena. All rights reserved.
//

import UIKit

class viewPrice: UIViewController {

    @IBOutlet weak var lblMuttonNm: UILabel!
    @IBOutlet weak var lblMuttonPrice: UILabel!
    @IBOutlet weak var lblChk2Price: UILabel!
    @IBOutlet weak var lblChk2Nm: UILabel!
    @IBOutlet weak var lblChk1Price: UILabel!
    @IBOutlet weak var lblChk1Nm: UILabel!
    var intMuttonPrice:CGFloat = 0.0
    var intChickenskinPrice:CGFloat = 0.0
    var intChickenskinlessPrice:CGFloat = 0.0
    let url:String="http://ec2-52-91-103-107.compute-1.amazonaws.com/api/"
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
        lblMuttonPrice.text = "₹ " + String(intMuttonPrice) + "*"
        lblChk1Price.text =  "₹ " + String(intChickenskinPrice)  + "*"
        lblChk2Price.text = "₹ " + String(intChickenskinlessPrice) + "*"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        

        
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
