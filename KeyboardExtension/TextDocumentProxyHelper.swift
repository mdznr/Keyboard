//
//  TextDocumentProxyHelper.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/18/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

/// Whether the insertion point is at the beginning of a potential sentence.
func UITextDocumentProxyIsAtBeginningOfPotentialSentence(textDocumentProxy: UITextDocumentProxy) -> Bool {
	// Must be following a set of whitespace characters back to an ending puncutation mark set or nothing at all.
	if let precedingContext = textDocumentProxy.documentContextBeforeInput {
		if precedingContext.isAtBeginningOfPotentialSentence {
			return true
		}
		if UITextDocumentProxyIsEmpty(textDocumentProxy) {
			return true
		}
	}
	
	return false
}

/// Whether the insertion point is at the beginning of a potential word.
func UITextDocumentProxyIsAtBeginningOfPotentialWord(textDocumentProxy: UITextDocumentProxy) -> Bool {
	// Must be following a whitespace character or nothing at all.
	if let precedingContext = textDocumentProxy.documentContextBeforeInput {
		if precedingContext.isAtBeginningOfPotentialWord {
			return true
		}
		if UITextDocumentProxyIsEmpty(textDocumentProxy) {
			return true
		}
	}
	
	return false
}

/// Whether the document context is empty or not.
func UITextDocumentProxyIsEmpty(textDocumentProxy: UITextDocumentProxy) -> Bool {
	if let precedingContext = textDocumentProxy.documentContextBeforeInput {
		if count(precedingContext) == 0 {
			return true
		}
	}
	
	if let subsequentContext = textDocumentProxy.documentContextAfterInput {
		if count(subsequentContext) == 0 {
			return true
		}
	}
	
	return true
}
