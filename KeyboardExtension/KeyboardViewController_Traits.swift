//
//  KeyboardViewController_Traits.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

// Because of some issue with the compiler right now, I must make this functions and not properties. Ugh.

extension KeyboardViewController {
	
	/// Provides textual context to a custom keyboard.
	func traits() -> UITextDocumentProxy {
		return self.textDocumentProxy as! UITextDocumentProxy
	}
	
	/// The auto-capitalization style for the text object.
	/// @discussion This property determines at what times the Shift key is automatically pressed, thereby making the typed character a capital letter. The default value for this property is @c UITextAutocapitalizationTypeSentences.
	func autocapitalizationType() -> UITextAutocapitalizationType {
		return self.traits().autocapitalizationType!
	}
	
	/// The auto-correction style for the text object.
	/// @discussion This property determines whether auto-correction is enabled or disabled during typing. With auto-correction enabled, the text object tracks unknown words and suggests a more suitable replacement candidate to the user, replacing the typed text automatically unless the user explicitly overrides the action.
	/// @discussion The default value for this property is @c UITextAutocorrectionTypeDefault, which for most input methods results in auto-correction being enabled.
	func autocorrectionType() -> UITextAutocorrectionType {
		return self.traits().autocorrectionType!
	}
	
	/// The spell-checking style for the text object.
	/// @discussion This property determines whether spell-checking is enabled or disabled during typing. With spell-checking enabled, the text object generates red underlines for all misspelled words. If the user taps on a misspelled word, the text object presents the user with a list of possible corrections.
	/// @discussion The default value for this property is @c UITextSpellCheckingTypeDefault, which enables spell-checking when auto-correction is also enabled. The value in this property supersedes the spell-checking setting set by the user in Settings > General > Keyboard.
	func spellCheckingType() -> UITextSpellCheckingType {
		return self.traits().spellCheckingType!
	}
	
	/// A Boolean value indicating whether the return key is automatically enabled when text is entered by the user.
	/// @discussion The default value for this property is @c NO. If you set it to @c YES, the keyboard disables the return key when the text entry area contains no text. As soon as the user enters any text, the return key is automatically enabled.
	func enablesReturnKeyAutomatically() -> Bool {
		return self.traits().enablesReturnKeyAutomatically!
	}
	
	/// The appearance style of the keyboard that is associated with the text object.
	/// This property lets you distinguish between the default text entry inside your application and text entry inside an alert panel. The default value for this property is @c UIKeyboardAppearanceDefault.
	func keyboardAppearance() -> UIKeyboardAppearance {
		return self.traits().keyboardAppearance!
	}
	
	/// The keyboard style associated with the text object.
	/// @discussion Text objects can be targeted for specific types of input, such as plain text, email, numeric entry, and so on. The keyboard style identifies what keys are available on the keyboard and which ones appear by default. The default value for this property is @c UIKeyboardTypeDefault.
	func keyboardType() -> UIKeyboardType {
		return self.traits().keyboardType!
	}
	
	/// The contents of the “return” key.
	/// Setting this property to a different key type changes the title of the key and typically results in the keyboard being dismissed when it is pressed. The default value for this property is @c UIReturnKeyDefault.
	func returnKeyType() ->UIReturnKeyType {
		return self.traits().returnKeyType!
	}
	
}
