//
//  Spacebar.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class Spacebar: MetaKey {
	
	override func refreshAppearance() {
		UIView.animateWithDuration(0.18, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .BeginFromCurrentState | .AllowUserInteraction, animations: {
			if self.highlighted {
				self.horizontalLine.backgroundColor = self.enabledTintColor
				self.horizontalLine.frame.size.height = 3
			} else {
				self.horizontalLine.backgroundColor = self.disabledTintColor
				self.horizontalLine.frame.size.height = 1
			}
			// Center the line vertically
			self.horizontalLine.frame.origin.y =  CGRectGetMidY(self.bounds) - (self.horizontalLine.frame.size.height/2)
		}, completion: nil)
	}
	
	let horizontalLine: UIView = {
		let view = UIView()
		view.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin | .FlexibleBottomMargin
		return view
	}()
	
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
		
		horizontalLine.frame = CGRect(x: 0, y: CGRectGetMidY(self.bounds) - 0.5, width: self.bounds.size.width, height: 1)
		self.addSubview(horizontalLine)
    }

}
