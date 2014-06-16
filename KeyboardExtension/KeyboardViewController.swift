//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

// Some constants to use.
let APPEAR_ANIMATION_DURATION = 0.3

class KeyboardViewController: UIInputViewController {

	@IBOutlet var nextKeyboardButton: UIButton
	
	@lazy var label : UILabel = {
		let l = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 80)) as UILabel
		l.text = "asdf"
		return l
	}()

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Perform custom UI setup here
		self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
		nextKeyboardButton.setTitle(NSLocalizedString("Next", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
		nextKeyboardButton.sizeToFit()
		nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(nextKeyboardButton)
		
		self.view.addSubview(label)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeLeft:")
		swipeLeft.direction = .Left
		self.view.addGestureRecognizer(swipeLeft)
    }
	
	override func viewDidAppear(animated: Bool) {
		// Set background color.
		UIView.animateWithDuration(APPEAR_ANIMATION_DURATION,
			delay: 0,
			options: .BeginFromCurrentState | .CurveEaseInOut | .AllowAnimatedContent | .AllowUserInteraction,
			animations: {
				self.inputView.backgroundColor = self.keyboardBackgroundColorForAppearance(.Default)
			},
			completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
		
		NSLog("Text Did Change!")
		
//		var textColor: UIColor
//		if self.keyboardAppearance == UIKeyboardAppearance.Dark {
//			textColor = UIColor.whiteColor()
//		} else {
//			textColor = UIColor.blackColor()
//		}
//		self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
	
	// MARK: Gestures
	
	/// TODO: Fix this once `documentContextBeforeInput` stops always returning nil.
	/// Did a left swipe gesture. Delete until previous chunk of whitespace.
	func didSwipeLeft(sender: UIGestureRecognizer) {
		let proxy = self.textDocumentProxy as UITextDocumentProxy
		if let precedingContext = proxy.documentContextBeforeInput {
			label.text = precedingContext
			let numTimesToDelete = precedingContext.numberOfElementsToDeleteToDeleteLastWord()
			for i in 0...numTimesToDelete {
				proxy.deleteBackward()
			}
		}
	}
}
