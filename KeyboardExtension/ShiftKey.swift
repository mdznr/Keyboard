//
//  ShiftKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ShiftKey: MetaKey {
	
	// MARK: Public Properties
	
	var shiftState: KeyboardShiftState {
		didSet {
			// Update appearance.
			refreshAppearance()
		}
	}
	
	var shiftStateChangeHandler: (shitState: KeyboardShiftState) -> () = {shiftState in}
	
	// MARK: Initialization
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
	}
	
    init(frame: CGRect) {
		// Disabled is the default state.
		self.shiftState = .Disabled
		
        super.init(frame: frame)
        // Initialization code
    }
	
	// MARK: Toggling state
	
	override func refreshAppearance() {
		super.refreshAppearance()
		switch shiftState {
			case .Disabled:
				imageView.tintColor = disabledTintColor
				imageView.image = UIImage(named: "Shift Disabled")
			case .Enabled:
				imageView.tintColor = enabledTintColor
				imageView.image = UIImage(named: "Shift Enabled")
			case .Locked:
				imageView.tintColor = enabledTintColor
				imageView.image = UIImage(named: "Caps Lock")
		}
	}
	
	/// Use this to suggest a change in shiftState
	func updateShiftState(shiftState: KeyboardShiftState) {
		shiftStateChangeHandler(shitState: shiftState)
	}
	
	var potentiallyDoubleTapping: Bool = false
	
	var doubleTapTimer: NSTimer!
	
	override func didSelect() {
		if potentiallyDoubleTapping == true {
			updateShiftState(.Locked)
			potentiallyDoubleTapping = false
			doubleTapTimer?.invalidate()
		} else {
			switch shiftState {
			case .Disabled:
				updateShiftState(.Enabled)
			case .Enabled, .Locked:
				updateShiftState(.Disabled)
			}
			potentiallyDoubleTapping = true
			doubleTapTimer = NSTimer(timeInterval: 0.3, target: self, selector: "failedToDoubleTapShift:", userInfo: nil, repeats: false)
			NSRunLoop.currentRunLoop().addTimer(doubleTapTimer, forMode: NSDefaultRunLoopMode)
		}
	}
	
	func failedToDoubleTapShift(timer: NSTimer) {
		potentiallyDoubleTapping = false
	}

}
