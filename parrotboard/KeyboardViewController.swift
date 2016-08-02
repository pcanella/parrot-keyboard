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
    @IBOutlet var keyboardDivView: UIView!
    @IBOutlet var leadingMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var fastParrotBtn: UIButton!
    @IBOutlet var parrottest: UIImageView!
    @IBOutlet var keyboardBtn: UIButton!
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
         //Add all buttons to array
        
        for case let button as UIButton in keyboardDivView.subviews {
            if (button.titleLabel!.text != "Next Keyboard" && button.titleLabel!.text != "🔙"){
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
        btn.setBackgroundImage(parrotGif, forState: UIControlState.Normal)
    }
    
    func loadInterface() {
        // load the nib file
        let parrotNib = UINib(nibName: "parrotkeyboardview", bundle: nil)
        // instantiate the view
        self.parrotView = parrotNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        print(self.parrotView.frame.width);
        // add the interface to the main view
        view.addSubview(self.parrotView)
        
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