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
			let letter = newValue.substringToIndex(1)
			let text = capitalized ? letter.uppercaseString : letter.lowercaseString
			label.text = text
			keyDownLabel.text = text
		}
	}
	
	/// A Boolean value representing whether or not the letter is capitalized
	var capitalized: Bool = false {
		didSet {
			let text = capitalized ? label.text.uppercaseString : label.text.lowercaseString
			label.text = text
			keyDownLabel.text = text
		}
	}
	
	var textColor: UIColor {
		get {
			return self.label.textColor
		}
		set {
			self.label.textColor = textColor
			self.keyDownLabel.textColor = textColor
		}
	}
	
	/// A change in appearance when highlighted is set.
	override var highlighted: Bool {
		didSet {
			self.keyDownView.hidden = !highlighted
//			self.backgroundColor = highlighted ? UIColor.redColor() : UIColor.clearColor()
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
		
		keyDownView.addSubview(keyDownLabel)
		keyDownView.hidden = true
		self.addSubview(keyDownView)
	}
	
	let label = UILabel()
	
	let keyDownView: UIView = {
		let view = UIView(frame: CGRect(x: -14, y: -57, width: 62, height: 101))
		
		let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 62, height: 101))
		iv.image = UIImage(named: "LetterKeyDown")
		view.addSubview(iv)
		
		return view
	}()
	
	let keyDownLabel: UILabel = {
		let label = UILabel(frame: CGRect(x: 0, y: 12, width: 62, height: 43))
		label.textAlignment = .Center
		label.font = KeyboardAppearance.keyboardLetterFont().fontWithSize(36)
		label.textColor = KeyboardAppearance.primaryButtonColorForAppearance(.Default)
		return label
	}()
	
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView! {
		return pointInside(point, withEvent: event) ? self : nil
	}
	
	override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
//		var frameAboutOrigin = self.frame
//		frameAboutOrigin.origin = CGPoint(x: 0, y: 0)
		return CGRectContainsPoint(self.label.frame, point)
	}
	
}
