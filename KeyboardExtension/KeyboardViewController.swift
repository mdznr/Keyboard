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
	
	let row1 = KeyboardViewController.createRow()
	let row2 = KeyboardViewController.createRow()
	let row3 = KeyboardViewController.createRow()
	let row4 = KeyboardViewController.createRow()
	
	var row1Labels = Dictionary<String, UIView>()
	var row2Labels = Dictionary<String, UIView>()
	var row3Labels = Dictionary<String, UIView>()
	
	let row1Letters = ["Q","W","E","R","T","Y","U","I","O","P"]
	let row2Letters = ["A","S","D","F","G","H","J","K","L"]
	let row3Letters = ["Z","X","C","V","B","N","M"]
	
	let shiftButton : UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Shift Disabled"), forState: .Normal)
		button.setImage(UIImage(named: "Shift Enabled"), forState: .Highlighted)
		button.setImage(UIImage(named: "Caps Lock"), forState: .Selected)
		
		return button
	}()
	let deleteButton : UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Delete"), forState: .Normal)
		
		return button
	}()
	
	let symbolKeyboardButton : UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Symbols"), forState: .Normal)
		
		return button
	}()
	let nextKeyboardButton : UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Globe"), forState: .Normal)
		
		return button
	}()
	let spacebar: UIView = {
		let view = UIView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return view
	}()
	let returnKey: UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.font = UIFont.systemFontOfSize(16)
		button.setTitle("Search", forState: .Normal)
		
		return button
	}()
	
	class func createRow() -> UIView {
		let view = UIView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		let divider = KeyboardDivider()
		view.addSubview(divider)
		
		let views = ["divider": divider]
		view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[divider]|", options: nil, metrics: nil, views: views))
		view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[divider(0.5)]", options: nil, metrics: nil, views: views))
		
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
			row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
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
			row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row2HorizontalMetrics = [
			"width": 22, // * 9
			"outer": 13, // * 2
			"inter": 12  // * 8
		]
		row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[A(width)]-(inter)-[S(width)]-(inter)-[D(width)]-(inter)-[F(width)]-(inter)-[G(width)]-(inter)-[H(width)]-(inter)-[J(width)]-(inter)-[K(width)]-(inter)-[L(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row2HorizontalMetrics, views: row2Labels))
		
		// Row 3
		row3Labels.updateValue(shiftButton, forKey: "shiftButton")
		row3.addSubview(shiftButton)
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[shiftButton(>=height)]|", options: nil, metrics: ["height": 30], views: ["shiftButton": shiftButton]))
		
		row3Labels.updateValue(deleteButton, forKey: "deleteButton")
		row3.addSubview(deleteButton)
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[deleteButton(>=height)]|", options: nil, metrics: ["height": 30], views: ["deleteButton": deleteButton]))
		
		for letter in row3Letters {
			let label = KeyboardKey(letter: letter)
			row3Labels.updateValue(label, forKey: letter)
			row3.addSubview(label)
			row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row3HorizontalMetrics = [
			"outer": 6,        // * 2
			"endKeyWidth": 30, // * 2
			"mainKeyOuter": 8, // * 2
			"width": 22,       // * 7
			"inter": 13        // * 6
		]
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[shiftButton(endKeyWidth)]-(mainKeyOuter)-[Z(width)]-(inter)-[X(width)]-(inter)-[C(width)]-(inter)-[V(width)]-(inter)-[B(width)]-(inter)-[N(width)]-(inter)-[M(width)]-(mainKeyOuter)-[deleteButton(endKeyWidth)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row3HorizontalMetrics, views: row3Labels))
		
		// Row 4
		row4.addSubview(symbolKeyboardButton)
//		symbolKeyboardButton.addTarget(self, action: "switchToSymbolsKeyboard", forControlEvents: .TouchUpInside)
		row4.addSubview(nextKeyboardButton)
		nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
		row4.addSubview(spacebar)
		row4.addSubview(returnKey)
		returnKey.addTarget(self, action: "dismissKeyboard", forControlEvents: .TouchUpInside)
		
		let views = [
			"symbolKeyboardButton": symbolKeyboardButton,
			"nextKeyboardButton": nextKeyboardButton,
			"spacebar": spacebar,
			"returnKey": returnKey
		]
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[symbolKeyboardButton]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nextKeyboardButton]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[spacebar(1)]-(23.5)-|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[returnKey]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(6)-[symbolKeyboardButton(30)]-(8)-[nextKeyboardButton(30)]-(8)-[spacebar]-(8)-[returnKey]-(6)-|", options: nil, metrics: nil, views: views))
		
		// Gestures
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeLeft:")
		swipeLeft.direction = .Left
		self.inputView.addGestureRecognizer(swipeLeft)
		
		let press = UILongPressGestureRecognizer(target: self, action: "didPress:")
		press.minimumPressDuration = 0
//		self.view.addGestureRecognizer(press)
    }
	
	override func viewDidAppear(animated: Bool) {
		/*
		// Set background color.
		UIView.animateWithDuration(APPEAR_ANIMATION_DURATION,
			delay: 0,
			options: .BeginFromCurrentState | .CurveEaseInOut | .AllowAnimatedContent | .AllowUserInteraction,
			animations: {
				self.view.backgroundColor = KeyboardViewController.keyboardBackgroundColorForAppearance(self.keyboardAppearance())
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
		let appearance = self.keyboardAppearance()
		self.inputView.backgroundColor = KeyboardAppearance.keyboardBackgroundColorForAppearance(appearance)
		KeyboardKey.appearance().textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		spacebar.backgroundColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		KeyboardDivider.appearance().backgroundColor = KeyboardAppearance.dividerColorForAppearance(appearance)
		UIButton.appearance().tintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
    }
	
	// MARK: Gestures
	
	func didPress(sender: UIGestureRecognizer) {
		switch sender.state {
			case .Began:
				break
			case .Changed:
				break
			case .Ended:
				break
			case .Cancelled:
				fallthrough
			default:
				break
		}
	}
	
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
