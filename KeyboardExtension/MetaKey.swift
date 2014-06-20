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
	
	let imageView: UIImageView = {
		let view = UIImageView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		view.contentMode = .Center
		return view
	}()
	
	var contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
	
	override func intrinsicContentSize() -> CGSize {
		let contentSize = imageView.intrinsicContentSize()
		return CGSize(width: contentEdgeInsets.left + contentSize.width + contentEdgeInsets.right, height: contentEdgeInsets.top + contentSize.height + contentEdgeInsets.bottom)
	}

}
