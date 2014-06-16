//
//  KeyboardDivider.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class KeyboardDivider: UIView {
	
	convenience init() {
		self.init(frame: CGRectZero)
	}

    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.backgroundColor = KeyboardViewController.dividerColorForAppearance(UIKeyboardAppearance.Default)
    }

}
