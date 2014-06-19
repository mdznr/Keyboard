//
//  Keyboard.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/19/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class Keyboard: UIControl {
	
	// MARK: Initialization
	
	init(frame: CGRect)  {
		super.init(frame: frame)
	}
	
	// MARK: Properties
	
	/// The number of rows on the keyboard.
	var numberOfRows = 4
	
	/// An array of rows (an array) of keys.
	var keys = UIView[][]()
	
}
