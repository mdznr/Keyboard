//
//  TextDocumentProxyHelper.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/18/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

extension KeyboardViewController {
	
	/// Whether the document context is empty or not.
	func isDocumentContextEmpty() -> Bool {
		let proxy = self.textDocumentProxy as UITextDocumentProxy
		if let precedingContext = proxy.documentContextBeforeInput {
			if countElements(precedingContext) == 0 {
				return true
			}
		}
		if let subsequentContext = proxy.documentContextAfterInput {
			if countElements(subsequentContext) == 0 {
				return true
			}
		}
		return true
	}
	
	/// Whether the insertion point is at the beginning of a potential word.
	func isAtBeginningOfPotentialWord() -> Bool {
		// Must be following a whitespace character or nothing at all.
		let proxy = self.textDocumentProxy as UITextDocumentProxy
		if let precedingContext = proxy.documentContextBeforeInput {
//			if precedingContext.isEmpty {
//				return true
//			}
//			// ORIGINAL REGEX: ^.*( |/|—)$
//			let match = precedingContext.rangeOfString("^.*( |/|—)$", options: .RegularExpressionSearch)
//			if !match.isEmpty {
//				return true
//			}
			
			if precedingContext.isAtBeginningOfPotentialWord {
				return true
			}
		}
		
		return false
	}
	
	/// Whether the insertion point is at the beginning of a potential sentence.
	func isAtBeginningOfPotentialSentence() -> Bool {
		// Must be following a set of whitespace characters back to an ending puncutation mark set or nothing at all.
		let proxy = self.textDocumentProxy as UITextDocumentProxy
		if let precedingContext = proxy.documentContextBeforeInput {
//			if precedingContext.isEmpty {
//				return true
//			}
//			// ORIGINAL REGEX: ^.*[\.\!\?][")]?\s+$
//			let match = precedingContext.rangeOfString("^.*[\\.\\!\\?][\")]?\\s+$", options: .RegularExpressionSearch)
//			if !match.isEmpty {
//				return true
//			}
			
			if precedingContext.isAtBeginningOfPotentialSentence {
				return true
			}
		}
		
		return false
	}
}
