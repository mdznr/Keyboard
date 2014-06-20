//
//  LetterKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class LetterKey: KeyboardKey {
	
	/// The letter to display on the key.
	/// This will truncate to one letter.
	var letter: NSString {
		get {
			let text = label.text
			return capitalized ? text.uppercaseString : text.lowercaseString
		}
		set {
			let text = newValue.substringToIndex(1)
			label.text = capitalized ? text.uppercaseString : text.lowercaseString
		}
	}
	
	/// A Boolean value representing whether or not the letter is capitalized
	var capitalized: Bool = false {
		didSet {
			label.text = capitalized ? label.text.uppercaseString : label.text.lowercaseString
		}
	}
	
	var textColor: UIColor {
		get {
			return self.label.textColor
		}
		set {
			self.label.textColor = textColor
		}
	}
	
	/// A change in appearance when highlighted is set.
	override var highlighted: Bool {
		didSet {
			self.backgroundColor = highlighted ? UIColor.redColor() : UIColor.clearColor()
		}
	}
	
	convenience init(letter: NSString) {
		self.init()
		self.letter = letter
	}
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 22, height: 19))
	}
	
	init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		self.addSubview(label)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label]|", options: nil, metrics: nil, views: ["label": label]))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: nil, views: ["label": label]))
		
		label.textAlignment = .Center
		label.font = KeyboardAppearance.keyboardLetterFont()
		label.textColor = KeyboardAppearance.primaryButtonColorForAppearance(.Default)
	}
	
	let label = UILabel()
	
}
