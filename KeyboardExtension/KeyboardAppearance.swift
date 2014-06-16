//
//  KeyboardAppearance.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class KeyboardAppearance {
	
	class func keyboardLetterFont() -> UIFont {
		return UIFont.systemFontOfSize(24)
	}
	
	/// The color to use for the background.
	class func keyboardBackgroundColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor.blackColor()
		case .Default, .Light:
			return UIColor(hue: 0.67, saturation: 0, brightness: 0.97, alpha: 1)
		}
	}
	
	/// The color to use for primary buttons, such as letters.
	class func primaryButtonColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 0.8, alpha: 1)
		case .Default, .Light:
			return UIColor(white: 0.32, alpha: 1)
		}
	}
	
	/// The color to use for secondary buttons, like next keyboard, shift, delete.
	class func secondaryButtonColorForApperance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 1, alpha: 0.33)
		case .Default, .Light:
			return UIColor(hue: 0.67, saturation: 0.02, brightness: 0.8, alpha: 1)
		}
	}
	
	/// The color to use for buttons--like the return key or shift key--when they're enabled.
	class func enabledButtonColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(hue: 0.59, saturation: 1, brightness: 1, alpha: 1)
		case .Default, .Light:
			return UIColor(hue: 0.59, saturation: 1, brightness: 1, alpha: 1)
		}
	}
	
	/// The color to use for the dividers between rows.
	class func dividerColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
		switch appearance {
		case .Dark:
			return UIColor(white: 1, alpha: 0.10)
		case .Default, .Light:
			return UIColor(hue: 0.67, saturation: 0.02, brightness: 0.8, alpha: 1)
		}
	}
	
}
