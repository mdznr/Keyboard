//
//  KeyboardViewController_Apperance.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

extension KeyboardViewController {
	
	/// The color to use for the background.
	func keyboardBackgroundColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor.blackColor()
		case .Default, .Light:
			return UIColor(hue: 0.58, saturation: 0.01, brightness: 0.97, alpha: 1)
		}
	}
	
	/// The color to use for primary buttons, such as letters.
	func primaryButtonColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 1, alpha: 0.8)
		case .Default, .Light:
			return UIColor(white: 0, alpha: 0.7)
		}
	}
	
	/// The color to use for secondary buttons, like next keyboard, shift, delete.
	func secondaryButtonColorForApperance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 1, alpha: 0.33)
		case .Default, .Light:
			return UIColor(white: 0, alpha: 0.3)
		}
	}
	
	/// The color to use for buttons--like the return key or shift key--when they're enabled.
	func enabledButtonColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(hue: 0.6, saturation: 0.9, brightness: 1, alpha: 1)
		case .Default, .Light:
			return UIColor(hue: 0.6, saturation: 0.9, brightness: 1, alpha: 1)
		}
	}
	
	/// The color to use for the dividers between rows.
	func dividerColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 1, alpha: 0.10)
		case .Default, .Light:
			return UIColor(white: 0, alpha: 0.03)
		}
	}
	
}
