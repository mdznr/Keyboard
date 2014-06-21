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
		self.shiftState = shiftState
	}
	
	var shiftState: KeyboardShiftState = .Disabled {
		didSet {
			typer.shiftState = shiftState
			shiftKey.shiftState = shiftState
			if shiftState != oldValue {
				let capitalized = shiftState != .Disabled
				for letterKey in letterKeys {
					letterKey.capitalized = capitalized
				}
			}
		}
	}
	
	// MARK: Keyboard
	
	let keyboard = Keyboard()
	
	// MARK: Letter Keys
	
	var letterKeys = LetterKey[]()
	
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
		
		keyboard.rowHeights = [59/216, 55/216, 54/216, 48/216]
		
		keyboard.edgeInsets = [
			UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
			UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7),
			UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1),
			UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
		]
		
		var keys = KeyboardKey[][]()
		
		let row1Letters = ["Q","W","E","R","T","Y","U","I","O","P"]
		let row2Letters = ["A","S","D","F","G","H","J","K","L"]
		let row3Letters = ["Z","X","C","V","B","N","M"]
		
		var row1Keys = KeyboardKey[]()
		for letter in row1Letters {
			let letterKey = self.letterKeyWithLetter(letter)
			row1Keys.append(letterKey)
			letterKeys.append(letterKey)
		}
		keys.append(row1Keys)
		
		var row2Keys = KeyboardKey[]()
		for letter in row2Letters {
			let letterKey = self.letterKeyWithLetter(letter)
			row2Keys.append(letterKey)
			letterKeys.append(letterKey)
		}
		keys.append(row2Keys)
		
		var row3Keys = KeyboardKey[]()
		row3Keys.append(shiftKey)
		shiftKey.action = {
			self.shiftState = self.shiftKey.shiftState
		}
		for letter in row3Letters {
			let letterKey = self.letterKeyWithLetter(letter)
			row3Keys.append(letterKey)
			letterKeys.append(letterKey)
		}
		row3Keys.append(deleteKey)
		deleteKey.action = {
			self.typer.deleteCharacter()
		}
		keys.append(row3Keys)
		
		var row4Keys = KeyboardKey[]()
		row4Keys.append(symbolKeyboardKey)
		symbolKeyboardKey.action = {
		}
		row4Keys.append(nextKeyboardKey)
		nextKeyboardKey.action = {
			self.advanceToNextInputMode()
		}
		row4Keys.append(spacebar)
		spacebar.action = {
			self.typer.typeString(" ")
		}
		row4Keys.append(returnKey)
		returnKey.action = {
			self.createNewline()
		}
		keys.append(row4Keys)
		
		keyboard.keys = keys
		
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
    }
	
	func letterKeyWithLetter(letter: String) -> LetterKey {
		let letterKey = LetterKey(letter: letter)
		letterKey.action = {
			self.typer.typeString(letterKey.letter)
		}
		return letterKey
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
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
		KeyboardDivider.appearance().backgroundColor = KeyboardAppearance.dividerColorForAppearance(appearance)
		LetterKey.appearance().textColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		Spacebar.appearance().disabledTintColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		Spacebar.appearance().enabledTintColor = KeyboardAppearance.primaryButtonColorForAppearance(appearance)
		ShiftKey.appearance().disabledTintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
		ShiftKey.appearance().enabledTintColor = KeyboardAppearance.enabledButtonColorForAppearance(appearance)
		ReturnKey.appearance().disabledTintColor = KeyboardAppearance.enabledButtonColorForAppearance(appearance)
		ReturnKey.appearance().enabledTintColor = KeyboardAppearance.enabledButtonColorForAppearance(appearance).colorWithAlphaComponent(0.7)
		UIButton.appearance().tintColor = KeyboardAppearance.secondaryButtonColorForApperance(appearance)
	}
	
	func appropriatelyCasedString(string: String) -> String {
		switch shiftState {
			case .Locked, .Enabled:
				return string.uppercaseString
			case .Disabled:
				return string.lowercaseString
		}
	}
	
	// MARK: Gestures
	
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
}
