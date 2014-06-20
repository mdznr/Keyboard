//
//  ReturnKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/19/14.
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

class ReturnKey: MetaKey {
	
	var type: UIReturnKeyType = .Default {
		didSet {
			label.text = type.simpleDescription()
		}
	}
	
	init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(label)
	}
	
	let label: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFontOfSize(16)
		return label
	}()
	
	let contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
	
	override func intrinsicContentSize() -> CGSize {
		let labelSize = label.intrinsicContentSize()
		return CGSize(width: contentEdgeInsets.left + labelSize.width + contentEdgeInsets.right, height: contentEdgeInsets.top + labelSize.height + contentEdgeInsets.bottom)
	}

}
