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
	
	// MARK: Keyboard
	
	let keyboard = Keyboard()
	
	// MARK: Special Keys
	
	let shiftKey = ShiftKey()
	
	let deleteKey: MetaKey = {
		let key = MetaKey()
		key.imageView.image = UIImage(named: "Delete")
		return key
	}()
	
	let symbolKeyboardKey: MetaKey = {
		let key = MetaKey()
		key.imageView.image = UIImage(named: "Symbols")
		return key
	}()
	
	let nextKeyboardKey: MetaKey = {
		let key = MetaKey()
		key.imageView.image = UIImage(named: "Globe")
		return key
	}()
	
	let returnKey = ReturnKey()
	
	let spacebar = Spacebar()
	
	// MARK: Lettered Keys
	
	let row1Letters = ["Q","W","E","R","T","Y","U","I","O","P"]
	let row2Letters = ["A","S","D","F","G","H","J","K","L"]
	let row3Letters = ["Z","X","C","V","B","N","M"]
	
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
		
		self.inputView.addSubview(keyboard)
		
		keyboard.rowHeights = [59, 55, 54, 48]
		
		keyboard.edgeInsets = [
			UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
			UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7),
			UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7),
			UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		]
		
		var keys = KeyboardKey[][]()
		
		var row1Keys = KeyboardKey[]()
		for letter in row1Letters {
			let letterKey = LetterKey(letter: letter)
			letterKey.capitalized = true
			row1Keys.append(letterKey)
		}
		keys.append(row1Keys)
		
		var row2Keys = KeyboardKey[]()
		for letter in row2Letters {
			let letterKey = LetterKey(letter: letter)
			letterKey.capitalized = true
			row2Keys.append(letterKey)
		}
		keys.append(row2Keys)
		
		var row3Keys = KeyboardKey[]()
		row3Keys.append(shiftKey)
		for letter in row3Letters {
			let letterKey = LetterKey(letter: letter)
			letterKey.capitalized = true
			row3Keys.append(letterKey)
		}
		row3Keys.append(deleteKey)
		keys.append(row3Keys)
		
		var row4Keys = KeyboardKey[]()
		row4Keys.append(symbolKeyboardKey)
		row4Keys.append(nextKeyboardKey)
		row4Keys.append(spacebar)
		row4Keys.append(returnKey)
		keys.append(row4Keys)
		
		keyboard.keys = keys
		
		let nextKeyboardButton = UIButton()
		self.inputView.addSubview(nextKeyboardButton)
		nextKeyboardButton.setImage(UIImage(named: "Globe"), forState: .Normal)
		nextKeyboardButton.frame = CGRect(x: 45, y: 176, width: 30, height: 30)
		nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
		
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
		returnKey.type = self.returnKeyType()
		let appearance = self.keyboardAppearance()
		self.inputView.backgroundColor = KeyboardAppearance.keyboardBackgroundColorForAppearance(appearance)
//		KeyboardDivider.appearance().backgroundColor = KeyboardAppearance.dividerColorForAppearance(appearance)
//		LetterKey.appearance().textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
//		Spacebar.appearance().textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
//		ShiftKey.appearance().disabledTintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
//		ShiftKey.appearance().enabledTintColor = KeyboardAppearance.enabledButtonColorForAppearance(appearance)
		UIButton.appearance().tintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
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
