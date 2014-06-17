//
//  ShiftKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ShiftKey: UIButton {
	
	var shiftState: KeyboardShiftState {
		didSet {
			// Update appearance.
			switch shiftState {
				case .Disabled:
					self.arrowImageView.image = UIImage(named: "Shift Disabled")
				case .Enabled:
					self.arrowImageView.image = UIImage(named: "Shift Enabled")
				case .Locked:
					self.arrowImageView.image = UIImage(named: "Caps Lock")
			}
		}
	}
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
	}
	
    init(frame: CGRect) {
		// Disabled is the default state.
		self.shiftState = .Disabled
		self.arrowImageView.image = UIImage(named: "Shift Disabled")
		
        super.init(frame: frame)
        // Initialization code
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		self.addSubview(arrowImageView)
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[arrowImageView]|", options: nil, metrics: nil, views: ["arrowImageView": arrowImageView]))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[arrowImageView]|", options: nil, metrics: nil, views: ["arrowImageView": arrowImageView]))
    }
	
	let arrowImageView: UIImageView = {
		let view = UIImageView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		view.contentMode = .ScaleAspectFit
		return view
	}()
	
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView! {
		return pointInside(point, withEvent: event) ? self : nil
	}
	
	override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
		return CGRectContainsPoint(self.bounds, point)
	}

}
