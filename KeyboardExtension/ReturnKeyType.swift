//
//  KeyboardReturnKeyType.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

extension UIReturnKeyType {
	
	func simpleDescription() -> String {
		switch self {
			case Default:       return "return"
			case Go:            return "Go"
			case Google:        return "Google"
			case Join:          return "Join"
			case Next:          return "Next"
			case Route:         return "Route"
			case Search:        return "Search"
			case Send:          return "Send"
			case Yahoo:         return "Yahoo"
			case Done:          return "Done"
			case EmergencyCall: return "Emergency Call"
		}
	}
	
}