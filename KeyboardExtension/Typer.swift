//
//  Typer.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/18/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

/// Represents the state of shift
enum KeyboardShiftState {
	case Disabled /// Shift is disabled—- types lowercase.
	case Enabled  /// Shift is enabled-- types capitals.
	case Locked   /// Shift is locked-- continue to type capitals.
	
	/// Enables, if disabled, but not if locked.
	mutating func enableIfDisabled() {
		if self == .Disabled {
			self = .Enabled
		}
	}
	
	/// Disables, if enabled, but not if locked.
	mutating func disableIfEnabled() {
		if self == .Enabled {
			self = .Disabled
		}
	}
}

/// Delegates of @c Typer must conform to this protocol.
protocol TyperDelegate {
	
	var textualContext: UITextDocumentProxy { get }
	
	/// Tells the delegate that it should update the shift state.
	func shouldUpdateShiftState(shiftState: KeyboardShiftState)
	
}


/// Handles the insertion and deletion of characters.
/// Handles insertion point capitalization for sentences/words based on `autocapitalizationType`.
/// Handles retroactive capitalizaton for proper nouns.
/// Handles autocorrection by replacing words typed.
class Typer: NSObject {
	
	// MARK: Initialization
	
	override init() {
		super.init()
	}
	
	// MARK: Properties
	
	var textualContext: UITextDocumentProxy {
		get {
			return delegate.textualContext
		}
	}
	
	var delegate: TyperDelegate!
	
	var shiftState: KeyboardShiftState = .Disabled
	
	var autocapitalizationType: UITextAutocapitalizationType = .Sentences {
		didSet {
			refreshShiftState()
		}
	}
	
	var autocorrectionType: UITextAutocorrectionType = .Default {
		didSet {
			
		}
	}
	
	// MARK: Public Functions
	
	/// Type a string using the appropriate case given by the shift state.
	/// @discussion This is particularly useful when typing single characters.
	func typeAutocapitalizedString(string: String) {
		textualContext.insertText(appropriatelyCasedString(string))
		
		refreshShiftState()
	}
	
	/// Type a string regardless of the shift state.
	/// @discussion This is particularly useful when needing to insert a whole word.
	func typeString(string: String) {
		textualContext.insertText(string)
		
		refreshShiftState()
	}
	
	func deleteCharacter() {
		// Delete before the insertion point.
		textualContext.deleteBackward()
		
		refreshShiftState()
	}
	
	func deleteWord() {
		if let precedingContext = textualContext.documentContextBeforeInput {
			let numTimesToDelete = precedingContext.numberOfElementsToDeleteToDeleteLastWord()
			for i in 0...numTimesToDelete {
				textualContext.deleteBackward()
			}
		}
		
		refreshShiftState()
	}
	
	func textDidChange(textInput: UITextInput) {
		refreshShiftState()
	}
	
	// MARK: Private
	
	/// Use this to suggest a change to shiftState
	/// This ensures that the delegate gets notified. It's kinda weird, but cleaner than having the delegate do KVO.
	func updateShiftState(shiftState: KeyboardShiftState) {
		delegate?.shouldUpdateShiftState(shiftState)
	}
	
	/// This automatically updates the shift state based on `autocapitlizationType` and preceding context.
	func refreshShiftState() {
		
		// Create a local copy to manipulate.
		var internalShiftState = shiftState
		
		switch autocapitalizationType {
			case .None:
				// Don't do anything.
				break
			case .AllCharacters:
				// TODO: Only update this if there's no context.
				internalShiftState = .Locked
			case .Sentences:
				// If at the beginning of the document or after a valid punction mark followed by a space, enable shift.
				if UITextDocumentProxyIsAtBeginningOfPotentialSentence(textualContext) {
					internalShiftState.enableIfDisabled()
				} else {
					internalShiftState.disableIfEnabled()
				}
			case .Words:
				// If at the begining of the document, or after a space character.
				if UITextDocumentProxyIsAtBeginningOfPotentialWord(textualContext) {
					internalShiftState.enableIfDisabled()
				} else {
					internalShiftState.disableIfEnabled()
				}
		}
		
		// Suggest an update to the shift state.
		updateShiftState(internalShiftState)
	}
	
	func appropriatelyCasedString(string: String) -> String {
		switch shiftState {
			case .Locked, .Enabled:
				return string.uppercaseString
			case .Disabled:
				return string.lowercaseString
		}
	}
	
}
