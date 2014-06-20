//
//  MetaKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/19/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class MetaKey: KeyboardKey {
	
	var disabledTintColor: UIColor = UIColor.lightGrayColor() as UIColor {
		didSet {
			refreshAppearance()
		}
	}
	
	var enabledTintColor: UIColor = UIColor.blueColor() as UIColor {
		didSet {
			refreshAppearance()
		}
	}
	
	func refreshAppearance() {
		imageView.tintColor = highlighted ? enabledTintColor : disabledTintColor
	}
	
	// What to do when this is selected.
	var action: () -> () = {}
	
	// MARK: Initialization
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
	}
	
	init(frame: CGRect) {
		super.init(frame: frame)
		// Initialization code
		
		refreshAppearance()
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		self.addSubview(imageView)
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: nil, metrics: nil, views: ["imageView": imageView]))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: nil, metrics: nil, views: ["imageView": imageView]))
	}
	
	override func didSelect() {
		action()
	}
	
	let imageView: UIImageView = {
		let view = UIImageView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		view.contentMode = .Center
		return view
	}()

}
