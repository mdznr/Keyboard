//
//  Spacebar.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class Spacebar: UIView {
	
	var textColor : UIColor = KeyboardAppearance.primaryButtonColorForAppearance(.Default) {
		didSet {
			horizontalLine.backgroundColor = textColor
		}
	}
	
	let horizontalLine : UIView = {
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
	
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView! {
		return pointInside(point, withEvent: event) ? self : nil
	}
	
	override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
		return CGRectContainsPoint(self.bounds, point)
	}

}
