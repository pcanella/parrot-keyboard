//
//  KeyboardViewController.swift
//  parrotboard
//
//  Created by Canella, Patrick on 7/8/16.
//  Copyright © 2016 Canella, Patrick. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    var parrotView: UIView!

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var fastParrotBtn: UIButton!
    @IBOutlet var parrottest: UIImageView!
    
    var allParrots = NSMutableArray();
    
    @IBAction func backspacePressed(btn: UIButton) {
        if btn.tag == 101 {
            (textDocumentProxy as UIKeyInput).deleteBackward()
        }
    }
    
    @IBAction func onButtonClick(sender: AnyObject) {
        let parrotName = allParrots[sender.tag].componentsSeparatedByString(".gif")[0];
        let url: NSURL = NSBundle.mainBundle().URLForResource(parrotName, withExtension: ".gif")!
        let data: NSData = NSData(contentsOfURL: url)!
        UIPasteboard.generalPasteboard().setData(data, forPasteboardType: "com.compuserve.gif")
    }
    
    @IBOutlet var centerView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface();
    }
    
    func iterateOverAllBtns(){
        let a = NSMutableArray();
        // Add all buttons to array
        for case let button as UIButton in self.parrotView.subviews {
            if (button.titleLabel!.text != "Next" && button.titleLabel!.text != "🔙"){
                a.addObject(button);
            }
            
            
        }
        
        for (var i = 0; i < a.count; i++){
           addProperImagesToButtons(a[i] as! UIButton, int: i);
        }
    }
    
    func getJustTheGifs() -> NSMutableArray {
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let items = try! fm.contentsOfDirectoryAtPath(path)
        
        for item in items {
            if item.hasSuffix("gif") {
                self.allParrots.addObject(item);
            }
        }
        return allParrots;
    }
    
    func addProperImagesToButtons(thisBtn: UIButton, int: Int){
        let items = getJustTheGifs();
        let itmName = items[int].componentsSeparatedByString(".gif")[0];
        setButton(thisBtn, title: itmName, idx: int);
    }

    
    func setButton(btn: UIButton, title: String, idx: Int){
            let parrotGif = UIImage.gifWithName(title)
        
            btn.setTitle("", forState: .Normal);
            btn.tag = idx;
            //btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, parrotGif!.size.width, parrotGif!.size.height);
            btn.setImage(parrotGif, forState: UIControlState.Normal)
    }
    
    func loadInterface() {
        // load the nib file
        let parrotNib = UINib(nibName: "parrotkeyboardview", bundle: nil)
        // instantiate the view
        parrotView = parrotNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // add the interface to the main view
        view.addSubview(parrotView)
        
        // copy the background color
        view.backgroundColor = parrotView.backgroundColor
        
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        iterateOverAllBtns()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
    

}
