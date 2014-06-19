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

class KeyboardViewController: UIInputViewController, TyperDelegate {
	
	// MARK: Typer
	
	let typer = Typer()
	
	var textualContext: UITextDocumentProxy {
		get {
			return self.textDocumentProxy as UITextDocumentProxy
		}
	}
	
	func shouldUpdateShiftState(shiftState: KeyboardShiftState) {
		// TODO: Update the UI to reflect it.
		self.shiftState = shiftState
	}
	
	var shiftState: KeyboardShiftState = .Disabled {
		didSet {
			typer.shiftState = shiftState
			shiftKey.shiftState = shiftState
		}
	}
	
	// MARK: Special Keys
	
	let shiftKey = ShiftKey()
	
	let deleteButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Delete"), forState: .Normal)
		
		return button
	}()
	
	let symbolKeyboardButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Symbols"), forState: .Normal)
		
		return button
	}()
	
	let nextKeyboardButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.setImage(UIImage(named: "Globe"), forState: .Normal)
		
		return button
	}()
	
	let returnKey: UIButton = {
		let button = UIButton.buttonWithType(.System) as UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		button.font = UIFont.systemFontOfSize(16)
		button.setTitle(UIReturnKeyType.Default.simpleDescription(), forState: .Normal)
		
		return button
	}()
	
	let spacebar = Spacebar()
	
	// MARK: Lettered Keys
	
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
	
	// MARK: Initialization

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		typer.delegate = self
    }
	
	// MARK: UIViewController

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
			let label = LetterKey(letter: letter)
			row1Labels.updateValue(label, forKey: letter)
			row1.addSubview(label)
			row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		
		let row1HorizontalMetrics = [
			"width": 32, // * 10
			"outer": 0,  // *  2
			"inter": 0   // *  9
		]
		row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[Q(width)]-(inter)-[W(width)]-(inter)-[E(width)]-(inter)-[R(width)]-(inter)-[T(width)]-(inter)-[Y(width)]-(inter)-[U(width)]-(inter)-[I(width)]-(inter)-[O(width)]-(inter)-[P(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row1HorizontalMetrics, views: row1Labels))
		
		// Row 2
		for letter in row2Letters {
			let label = LetterKey(letter: letter)
			row2Labels.updateValue(label, forKey: letter)
			row2.addSubview(label)
			row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row2HorizontalMetrics = [
			"width": 34, // * 9
			"outer":  7, // * 2
			"inter":  0  // * 8
		]
		row2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(outer)-[A(width)]-(inter)-[S(width)]-(inter)-[D(width)]-(inter)-[F(width)]-(inter)-[G(width)]-(inter)-[H(width)]-(inter)-[J(width)]-(inter)-[K(width)]-(inter)-[L(width)]-(outer)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row2HorizontalMetrics, views: row2Labels))
		
		// Row 3
		shiftKey.shiftStateChangeHandler = {
			shiftState in
			self.shiftState = shiftState
		}
		row3Labels.updateValue(shiftKey, forKey: "shiftButton")
		row3.addSubview(shiftKey)
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[shiftButton(>=height)]|", options: nil, metrics: ["height": 30], views: ["shiftButton": shiftKey]))
		
		deleteButton.addTarget(self, action: "deleteKeyPressed:", forControlEvents: .TouchUpInside)
		row3Labels.updateValue(deleteButton, forKey: "deleteButton")
		row3.addSubview(deleteButton)
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[deleteButton(>=height)]|", options: nil, metrics: ["height": 30], views: ["deleteButton": deleteButton]))
		
		for letter in row3Letters {
			let label = LetterKey(letter: letter)
			row3Labels.updateValue(label, forKey: letter)
			row3.addSubview(label)
			row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: ["height": 19], views: ["label": label]))
		}
		let row3HorizontalMetrics = [
			"left": 6,            // * 1
			"right": 5,           // * 1
			"shiftKeyWidth": 32,  // * 1
			"deleteKeyWidth": 32, // * 1
			"mainKeyOuter": 0,    // * 2
			"width": 35,          // * 7
			"inter":  0           // * 6
		]
		row3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(left)-[shiftButton(shiftKeyWidth)]-(mainKeyOuter)-[Z(width)]-(inter)-[X(width)]-(inter)-[C(width)]-(inter)-[V(width)]-(inter)-[B(width)]-(inter)-[N(width)]-(inter)-[M(width)]-(mainKeyOuter)-[deleteButton(deleteKeyWidth)]-(right)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: row3HorizontalMetrics, views: row3Labels))
		
		// Row 4
		row4.addSubview(symbolKeyboardButton)
//		symbolKeyboardButton.addTarget(self, action: "switchToSymbolsKeyboard", forControlEvents: .TouchUpInside)
		row4.addSubview(nextKeyboardButton)
		nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
		row4.addSubview(spacebar)
		row4.addSubview(returnKey)
		returnKey.addTarget(self, action: "returnKeyPressed:", forControlEvents: .TouchUpInside)
		
		let views = [
			"symbolKeyboardButton": symbolKeyboardButton,
			"nextKeyboardButton": nextKeyboardButton,
			"spacebar": spacebar,
			"returnKey": returnKey
		]
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[symbolKeyboardButton]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nextKeyboardButton]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacebar]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[returnKey]|", options: nil, metrics: nil, views: views))
		row4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(6)-[symbolKeyboardButton(30)]-(8)-[nextKeyboardButton(30)]-(8)-[spacebar(>=128)]-(8)-[returnKey(>=30)]-(6)-|", options: nil, metrics: nil, views: views))
		
		// Gestures
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeLeft:")
		swipeLeft.direction = .Left
		self.inputView.addGestureRecognizer(swipeLeft)
		
		let swipeRight = UISwipeGestureRecognizer(target: self, action: "didSwipeRight:")
		swipeRight.direction = .Right
		self.inputView.addGestureRecognizer(swipeRight)
		
		let swipeDown = UISwipeGestureRecognizer(target: self, action: "didSwipeDown:")
		swipeDown.direction = .Down
		self.inputView.addGestureRecognizer(swipeDown)
		
		let swipeDownWithTwoFingers = UISwipeGestureRecognizer(target: self, action: "didSwipeDownWithTwoFingers:")
		swipeDownWithTwoFingers.direction = .Down
		swipeDownWithTwoFingers.numberOfTouchesRequired = 2
		self.inputView.addGestureRecognizer(swipeDownWithTwoFingers)
		
		let press = UILongPressGestureRecognizer(target: self, action: "didPress:")
		press.minimumPressDuration = 0
//		self.inputView.addGestureRecognizer(press)
		
		let tap = UITapGestureRecognizer(target: self, action: "didTap:")
		self.inputView.addGestureRecognizer(tap)
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		self.updateAppearance()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
	
	// MARK: UITextInputDelegate

    override func textWillChange(textInput: UITextInput) {
		super.textWillChange(textInput)
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
		super.textDidChange(textInput)
        // The app has just changed the document's contents, the document context has been updated.
		
		NSLog("Text Did Change!")
		
		typer.textDidChange(textInput)
		
		self.updateAppearance()
    }
	
	// MARK: -
	
	func updateAppearance() {
		updateReturnKeyForType(self.returnKeyType())
		let appearance = self.keyboardAppearance()
		self.inputView.backgroundColor = KeyboardAppearance.keyboardBackgroundColorForAppearance(appearance)
		KeyboardDivider.appearance().backgroundColor = KeyboardAppearance.dividerColorForAppearance(appearance)
		LetterKey.appearance().textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		spacebar.textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		shiftKey.disabledTintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
		shiftKey.enabledTintColor = KeyboardAppearance.enabledButtonColorForAppearance(appearance)
		UIButton.appearance().tintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
	}
	
	func updateReturnKeyForType(returnKeyType: UIReturnKeyType) {
		let title = returnKeyType.simpleDescription()
		self.returnKey.setTitle(title, forState: .Normal)
	}
	
	func appropriatelyCasedString(string: String) -> String {
		switch shiftKey.shiftState {
			case .Locked, .Enabled:
				return string.uppercaseString
			case .Disabled:
				return string.lowercaseString
		}
	}
	
	// MARK: Gestures
	
	func tappedKeyWithCharacter(character: String) {
		let casedString = appropriatelyCasedString(character)
		typer.typeString(casedString)
	}
	
	func didTap(sender: UIGestureRecognizer) {
		if sender.state == .Ended {
			let view = sender.view
			let loc = sender.locationInView(view)
			let subview = view.hitTest(loc, withEvent: nil)
			if let subview = subview as? LetterKey {
				tappedKeyWithCharacter(subview.letter)
			} else if let subview = subview as? Spacebar {
				tappedKeyWithCharacter(" ")
			}
		}
	}
	
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
	/// Did a swipe left gesture. Delete until previous chunk of whitespace.
	func didSwipeLeft(sender: UIGestureRecognizer) {
		if sender.state == .Ended {
			typer.deleteWord()
		}
	}
	
	/// Did a swipe right gesture. End the sentence.
	func didSwipeRight(sender: UIGestureRecognizer) {
		if sender.state == .Ended {
			endSentence()
		}
	}
	
	/// Did a swipe down gesture. Add a newline character.
	func didSwipeDown(sender: UIGestureRecognizer) {
		if sender.state == .Ended {
			createNewline()
		}
	}
	
	/// Did a swipe down gesture with two fingers. Dismiss the keyboard.
	func didSwipeDownWithTwoFingers(sender: UIGestureRecognizer) {
		if sender.state == .Ended {
			dismissKeyboard()
		}
	}
	
	/// End the sentence by adding a period and enabling capitalization.
	/// TODO: Insert newline (if possible), if at the start of a sentence. (double-swipe)
	func endSentence() {
		typer.typeString(". ")
	}
	
	/// Create a newline or act as return
	func createNewline() {
		typer.typeString("\n")
	}
	
	func returnKeyPressed(sender: UIButton) {
		createNewline()
	}
	
	func deleteKeyPressed(sender: UIButton) {
		typer.deleteCharacter()
	}
}
