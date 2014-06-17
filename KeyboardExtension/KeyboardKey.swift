//
//  KeyboardKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class KeyboardKey: UILabel {
	
	/// The letter to display on the key.
	/// This will truncate to one letter.
	var letter: NSString {
		get {
			return self.text
		}
		set {
			self.text = newValue.substringToIndex(1)
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
		self.textAlignment = .Center
		self.font = KeyboardAppearance.keyboardLetterFont()
		self.textColor = KeyboardAppearance.primaryButtonColorForAppearance(.Default)
	}
	
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView! {
		return pointInside(point, withEvent: event) ? self : nil
	}
	
	override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
		return CGRectContainsPoint(self.bounds, point)
	}

}
