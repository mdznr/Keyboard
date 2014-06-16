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
	
	let nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
	
	let row1Letters = ["Q","W","E","R","T","Y","U","I","O","P"]
	let row2Letters = ["A","S","D","F","G","H","J","K","L"]
	let row3Letters = ["Z","X","C","V","B","N","M"]
	
	var row1Labels = Dictionary<String, KeyboardKey>()
	var row2Labels = Dictionary<String, KeyboardKey>()
	var row3Labels = Dictionary<String, KeyboardKey>()
	
	let row1 = KeyboardViewController.createRow()
	let row2 = KeyboardViewController.createRow()
	let row3 = KeyboardViewController.createRow()
	let row4 = KeyboardViewController.createRow()
	
	class func createRow() -> UIView {
		let view = UIView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		let divider = UIView()
		divider.setTranslatesAutoresizingMaskIntoConstraints(false)
		divider.backgroundColor = KeyboardViewController.dividerColorForAppearance(UIKeyboardAppearance.Default)
		view.addSubview(divider)
		
		let views = ["divider": divider]
		view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[divider]|", options: nil, metrics: nil, views: views))
		view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[divider(0.5)]|", options: nil, metrics: nil, views: views))
		
		return view
	}

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Rows
		let rows = [
			"row1": row1,
			"row2": row2,
			"row3": row3,
			"row4": row4
		]
		for (rowName, row) in rows {
			self.inputView.addSubview(row)
		}
		let row1Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row1]|", options: nil, metrics: nil, views: rows)
		self.inputView.addConstraints(row1Constraints)
		let row2Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row2]|", options: nil, metrics: nil, views: rows)
		self.inputView.addConstraints(row2Constraints)
		let row3Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row3]|", options: nil, metrics: nil, views: rows)
		self.inputView.addConstraints(row3Constraints)
		let row4Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row4]|", options: nil, metrics: nil, views: rows)
		self.inputView.addConstraints(row4Constraints)
		let rowConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[row1(59)][row2(55)][row3(54)][row4(48)]|", options: nil, metrics: nil, views: rows)
		self.inputView.addConstraints(rowConstraints)
		
		// Row 1
		for letter in row1Letters {
			let label = KeyboardKey(letter: letter)
			row1Labels.updateValue(label, forKey: letter)
			row1.addSubview(label)
			row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label(height)]-|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		
		let row1HorizontalMetrics = [
			"width": 22, // * 10
			"outer": 5,  // *  2
			"inter": 10  // *  9
		]
		row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[Q(width)]-(inter)-[W(width)]-(inter)-[E(width)]-(inter)-[R(width)]-(inter)-[T(width)]-(inter)-[Y(width)]-(inter)-[U(width)]-(inter)-[I(width)]-(inter)-[O(width)]-(inter)-[P(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row1HorizontalMetrics, views: row1Labels))
		
		// Row 2
		for letter in row2Letters {
			let label = KeyboardKey(letter: letter)
			row2Labels.updateValue(label, forKey: letter)
			row2.addSubview(label)
			row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label(height)]-|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row2HorizontalMetrics = [
			"width": 22, // * 9
			"outer": 13, // * 2
			"inter": 12  // * 8
		]
		row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[A(width)]-(inter)-[S(width)]-(inter)-[D(width)]-(inter)-[F(width)]-(inter)-[G(width)]-(inter)-[H(width)]-(inter)-[J(width)]-(inter)-[K(width)]-(inter)-[L(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row2HorizontalMetrics, views: row2Labels))
		
		// Row 3
		for letter in row3Letters {
			let label = KeyboardKey(letter: letter)
			row3Labels.updateValue(label, forKey: letter)
			row3.addSubview(label)
			row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label(height)]-|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row3HorizontalMetrics = [
			"width": 22, // * 7
			"outer": 44, // * 2
			"inter": 13  // * 6
		]
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[Z(width)]-(inter)-[X(width)]-(inter)-[C(width)]-(inter)-[V(width)]-(inter)-[B(width)]-(inter)-[N(width)]-(inter)-[M(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row3HorizontalMetrics, views: row3Labels))
		
		// Next keyboard button
		nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
		nextKeyboardButton.setImage(UIImage(named: "Globe"), forState: .Normal)
		nextKeyboardButton.sizeToFit()
		row4.addSubview(nextKeyboardButton)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
		
		// Auto layout
		let views = [
			"nextKeyboardButton": nextKeyboardButton
		]
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(54)-[nextKeyboardButton]", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[nextKeyboardButton]-(13)-|", options: nil, metrics: nil, views: views))
		
		// Gestures
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeLeft:")
		swipeLeft.direction = .Left
		self.inputView.addGestureRecognizer(swipeLeft)
    }
	
	override func viewDidAppear(animated: Bool) {
		/*
		// Set background color.
		UIView.animateWithDuration(APPEAR_ANIMATION_DURATION,
			delay: 0,
			options: .BeginFromCurrentState | .CurveEaseInOut | .AllowAnimatedContent | .AllowUserInteraction,
			animations: {
				self.inputView.backgroundColor = KeyboardViewController.keyboardBackgroundColorForAppearance(self.keyboardAppearance())
			},
			completion: nil)
		*/
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
		
		// Change visual appearance.
		self.inputView.backgroundColor = KeyboardViewController.keyboardBackgroundColorForAppearance(self.keyboardAppearance())
		KeyboardKey.appearance().textColor = KeyboardViewController.primaryButtonColorForAppearance(self.keyboardAppearance())
    }
	
	// MARK: Gestures
	
	/// TODO: Fix this once `documentContextBeforeInput` stops always returning nil.
	/// Did a left swipe gesture. Delete until previous chunk of whitespace.
	func didSwipeLeft(sender: UIGestureRecognizer) {
		let proxy = self.textDocumentProxy as UITextDocumentProxy
		if let precedingContext = proxy.documentContextBeforeInput {
			let numTimesToDelete = precedingContext.numberOfElementsToDeleteToDeleteLastWord()
			for i in 0...numTimesToDelete {
				proxy.deleteBackward()
			}
		}
	}
}
