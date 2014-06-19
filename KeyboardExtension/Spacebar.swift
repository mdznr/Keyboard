//
//  Spacebar.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class Spacebar: KeyboardKey {
	
	var textColor: UIColor = KeyboardAppearance.primaryButtonColorForAppearance(.Default) {
		didSet {
			horizontalLine.backgroundColor = textColor
		}
	}
	
	override var highlighted: Bool {
		didSet {
			UIView.animateWithDuration(0.18, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .BeginFromCurrentState | .AllowUserInteraction, animations: {
				if self.highlighted {
					self.horizontalLine.frame.size.height = 3
				} else {
					self.horizontalLine.frame.size.height = 1
				}
				// Center the line vertically
				self.horizontalLine.frame.origin.y = (self.bounds.size.height/2) - self.horizontalLine.frame.size.height/2
			}, completion: nil)
		}
	}
	
	let horizontalLine: UIView = {
		let view = UIView()
		view.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin | .FlexibleBottomMargin
		return view
	}()
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		horizontalLine.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 1)
		self.addSubview(horizontalLine)
    }

}
