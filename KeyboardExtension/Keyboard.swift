//
//  Keyboard.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/19/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

protocol KeyboardDelegate {
	
	func keyboard(keyboard: Keyboard, didSelectKey key: KeyboardKey)
	
}

class Keyboard: UIControl {
	
	// MARK: Initialization
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	init(frame: CGRect)  {
		super.init(frame: frame)
		self.autoresizingMask = .FlexibleWidth | .FlexibleHeight
		setup()
	}
	
	// MARK: Properties
	
	/// The number of rows on the keyboard.
//	var numberOfRows = 4
	
	/// An array of rows (an array) of keys.
//	var keys = KeyboardKey[][]()
	
	var row1Keys: KeyboardKey[] = KeyboardKey[]() {
		willSet {
			row1.removeConstraints(row1.constraints())
			for view in row1.subviews as UIView[] {
				view.removeFromSuperview()
			}
		}
		didSet {
			let metrics = [
				"top": row1Insets.top,
				"bottom": row1Insets.bottom
			]
			var horizontalVisualFormatString = "H:|-(\(row1Insets.left))-"
			var row1KeysDictionary = Dictionary<String, UIView>()
			for i in 0..row1Keys.count {
				let view = row1Keys[i]
				let dictionaryKey = "view" + i.description
				row1KeysDictionary.updateValue(view, forKey: dictionaryKey)
				row1.addSubview(view)
				row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(top)-[view]-(bottom)-|", options: nil, metrics: metrics, views: ["view": view]))
				horizontalVisualFormatString += "[\(dictionaryKey)(==view0)]"
			}
			horizontalVisualFormatString += "-(\(row1Insets.right))-|"
			row1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormatString, options: nil, metrics: nil, views: row1KeysDictionary))
		}
	}
	var row2Keys: KeyboardKey[] = KeyboardKey[]()
	var row3Keys: KeyboardKey[] = KeyboardKey[]()
	var row4Keys: KeyboardKey[] = KeyboardKey[]()
	
	var row1Insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	var row2Insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	var row3Insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	var row4Insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	
	let row1 = Keyboard.createRow()
	let row2 = Keyboard.createRow()
	let row3 = Keyboard.createRow()
	let row4 = Keyboard.createRow()
	
	// MARK: Setup
	
	func setup() {
		// Rows
		let rows = [
			"row1": row1,
			"row2": row2,
			"row3": row3,
			"row4": row4,
		]
		for (rowName, row) in rows {
			self.addSubview(row)
		}
		let row1Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row1]|", options: nil, metrics: nil, views: rows)
		self.addConstraints(row1Constraints)
		let row2Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row2]|", options: nil, metrics: nil, views: rows)
		self.addConstraints(row2Constraints)
		let row3Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row3]|", options: nil, metrics: nil, views: rows)
		self.addConstraints(row3Constraints)
		let row4Constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[row4]|", options: nil, metrics: nil, views: rows)
		self.addConstraints(row4Constraints)
		let rowConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[row1(59)][row2(55)][row3(54)][row4(48)]|", options: nil, metrics: nil, views: rows)
		self.addConstraints(rowConstraints)
	}
	
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
	
}

class KeyboardKey: UIView {
	
	/// A Boolean value represeting whether the key is highlighted (a touch is inside).
	var highlighted: Bool = false
	
	/// Called when a key has been selected.
	func didSelect() {}
	
	init(frame: CGRect) {
		super.init(frame: frame)
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
	}
	
}

class KeyboardDivider: UIView {
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	init(frame: CGRect) {
		super.init(frame: frame)
		// Initialization code
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		self.backgroundColor = KeyboardAppearance.dividerColorForAppearance(UIKeyboardAppearance.Default)
	}
	
}
