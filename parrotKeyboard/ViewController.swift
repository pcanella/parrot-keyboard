//
//  ViewController.swift
//  parrotKeyboard
//
//  Created by Canella, Patrick on 7/8/16.
//  Copyright © 2016 Canella, Patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
    @IBOutlet var image7: UIImageView!
    @IBOutlet var image8: UIImageView!
    @IBOutlet var image9: UIImageView!
    @IBOutlet var image10: UIImageView!
    @IBOutlet var image11: UIImageView!
    @IBOutlet var image12: UIImageView!

    
    @IBAction func addKeyboardClick(sender: AnyObject) {
        let keyboardPath = "prefs:root=General&path=Keyboard/KEYBOARDS";
        UIApplication.sharedApplication().openURL(NSURL(string: keyboardPath)!)
    }
    
    @IBAction func pcanellaWebLink(sender: AnyObject) {
        if let url = NSURL(string: "https://pcanella.github.io") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func parrotWebLink(sender: AnyObject) {
        if let url = NSURL(string: "http://cultofthepartyparrot.com/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let congaParrot = UIImage.gifWithName("congaparrot");
        image1.image = congaParrot;
        image2.image = congaParrot;
        image3.image = congaParrot;
        image4.image = congaParrot;
        image5.image = congaParrot;
        image6.image = congaParrot;
        
        
        image7.image = UIImage.gifWithName("parrotwave2");
        image8.image = UIImage.gifWithName("parrotwave3");
        image9.image = UIImage.gifWithName("parrotwave4");
        image10.image = UIImage.gifWithName("parrotwave5");
        image11.image = UIImage.gifWithName("parrotwave6");
        image12.image = UIImage.gifWithName("parrotwave6");
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

