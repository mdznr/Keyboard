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
	}
	
	// MARK: Properties
	
	/// An array of rows (an array) of keys.
	var keys: KeyboardKey[][] = KeyboardKey[][]() {
		willSet {
			// Remove all layout constraints.
			self.removeConstraints(self.constraints())
			// Remove all the rows from the view.
			for view in self.subviews as UIView[] {
				view.removeFromSuperview()
			}
		}
		didSet {
			var rows = Dictionary<String, UIView>()
			var rowVisualFormatString = "V:|"
			for x in 0..keys.count {
				let rowOfKeys = keys[x]
				let row = Keyboard.createRow()
				let rowName = "row" + x.description
				rows.updateValue(row, forKey: rowName)
				self.addSubview(row)
				self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[row]|", options: nil, metrics: nil, views: ["row": row]))
				rowVisualFormatString += "[\(rowName)(\(rowHeights[x]))]"
				
				let metrics = ["top": edgeInsets[x].top, "bottom": edgeInsets[x].bottom]
				var horizontalVisualFormatString = "H:|-(\(edgeInsets[x].left))-"
				var views = Dictionary<String, UIView>()
				var firstEquallySizedView = -1
				for i in 0..rowOfKeys.count {
					let view = rowOfKeys[i]
					let viewName = "view" + i.description
					views.updateValue(view, forKey: viewName)
					row.addSubview(view)
					row.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(top)-[view]-(bottom)-|", options: nil, metrics: metrics, views: ["view": view]))
					let contentSize = view.intrinsicContentSize()
					if contentSize.width == UIViewNoIntrinsicMetric {
						if firstEquallySizedView < 0 {
							firstEquallySizedView = i
							horizontalVisualFormatString += "[\(viewName)]"
						} else {
							horizontalVisualFormatString += "[\(viewName)(==view\(firstEquallySizedView.description))]"
						}
					} else {
						horizontalVisualFormatString += "[\(viewName)]"
					}
				}
				horizontalVisualFormatString += "-(\(edgeInsets[x].right))-|"
				if views.count > 0 {
					row.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormatString, options: nil, metrics: nil, views: views))
				}
			}
			rowVisualFormatString += "|"
			self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(rowVisualFormatString, options: nil, metrics: nil, views: rows))
		}
	}
	
	/// The edge insets for each row.
	var edgeInsets = UIEdgeInsets[]()
	
	/// The heights for each row.
	var rowHeights = CGFloat[]()
	
	
	// MARK: Helper functions
	
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
