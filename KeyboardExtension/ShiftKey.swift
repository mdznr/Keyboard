//
//  ShiftKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ShiftKey: KeyboardKey {
	
	// MARK: Public Properties
	
	var disabledTintColor: UIColor = UIColor.lightGrayColor() as UIColor {
		didSet {
			refreshAppearance()
		}
	}
	
	var enabledTintColor: UIColor = UIColor.blueColor() as UIColor {
		didSet {
			refreshAppearance()
		}
	}
	
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
		
		refreshAppearance()
		
		self.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		self.addSubview(arrowImageView)
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[arrowImageView]|", options: nil, metrics: nil, views: ["arrowImageView": arrowImageView]))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[arrowImageView]|", options: nil, metrics: nil, views: ["arrowImageView": arrowImageView]))
    }
	
	// MARK: Private
	
	// MARK: UI
	
	let arrowImageView: UIImageView = {
		let view = UIImageView()
		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		view.contentMode = .Center
		return view
	}()
	
	
	// MARK: Toggling state
	
	func refreshAppearance() {
		switch shiftState {
			case .Disabled:
				arrowImageView.tintColor = disabledTintColor
				arrowImageView.image = UIImage(named: "Shift Disabled")
			case .Enabled:
				arrowImageView.tintColor = enabledTintColor
				arrowImageView.image = UIImage(named: "Shift Enabled")
			case .Locked:
				arrowImageView.tintColor = enabledTintColor
				arrowImageView.image = UIImage(named: "Caps Lock")
		}
	}
	
	/// Use this to suggest a change in shiftState
	func updateShiftState(shiftState: KeyboardShiftState) {
		shiftStateChangeHandler(shitState: shiftState)
	}
	
	var potentiallyDoubleTappingShift: Bool = false
	
	var timer: NSTimer!
	
	override func didSelect() {
		if potentiallyDoubleTappingShift == true {
			updateShiftState(.Locked)
			potentiallyDoubleTappingShift = false
			timer?.invalidate()
		} else {
			switch shiftState {
			case .Disabled:
				updateShiftState(.Enabled)
			case .Enabled, .Locked:
				updateShiftState(.Disabled)
			}
			potentiallyDoubleTappingShift = true
			timer = NSTimer(timeInterval: 0.3, target: self, selector: "failedToDoubleTapShift:", userInfo: nil, repeats: false)
			NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
		}
	}
	
	func failedToDoubleTapShift(timer: NSTimer) {
		potentiallyDoubleTappingShift = false
	}

}
