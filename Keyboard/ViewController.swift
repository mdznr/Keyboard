//
//  ViewController.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var textField : UITextField
	
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
	
	init(coder aDecoder: NSCoder!)  {
		super.init(coder: aDecoder)
		// Custom initialization
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func didDismissKeyboard(sender : AnyObject) {
		textField.resignFirstResponder()
	}
	
	@IBAction func didChangeKeyboardAppearance(sender : UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 2: // .Dark
			textField.keyboardAppearance = .Dark
		case 1: // .Light
			textField.keyboardAppearance = .Light
		case 0: // .Default
			textField.keyboardAppearance = .Default
		default:
			textField.keyboardAppearance = .Default
		}
	}
}
