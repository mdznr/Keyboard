//
//  StringExtensions.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import Foundation

extension String {
	
	func isFirstLetterCapitalized() -> Bool {
		// Get the first character as a string.
		let firstLetter = self.substringToIndex(1)
		// See if the uppercase version of the string is the same.
		return !firstLetter.isEmpty &&
			    firstLetter == firstLetter.uppercaseString &&
			    firstLetter != firstLetter.lowercaseString
	}
	
	func numberOfElementsToDeleteToDeleteLastWord() -> Int {
		// All the chunks in the word.
		var chunks = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		
		// The total number of elements and chunks to delete
		var numberOfElementsToDelete = 0
		var numberOfChunksToDelete = 0;
		
		// The current chunk we're looking at.
		var chunk: String
		
		// Delete trailing whitespace and one non-whitespace chunk.
		do {
			numberOfChunksToDelete++
			if ( numberOfChunksToDelete > chunks.count ) {
				break;
			}
			chunk = chunks[chunks.count - numberOfChunksToDelete]
			var numElements = max(countElements(chunk), 1)
			numberOfElementsToDelete += numElements
		} while ( countElements(chunk) == 0 )
		
		return numberOfElementsToDelete
	}
	
	func numberOfElementsToDeleteToDeleteFirstWord() -> Int {
		// All the chunks in the word.
		var chunks = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		
		// The total number of elements and chunks to delete
		var numberOfElementsToDelete = 0
		var numberOfChunksToDelete = 0;
		
		// The current chunk we're looking at.
		var chunk: String
		
		// Delete trailing whitespace and one non-whitespace chunk.
		do {
			if ( numberOfChunksToDelete > chunks.count - 1 ) {
				break;
			}
			chunk = chunks[numberOfChunksToDelete++]
			var numElementsInChunk = max(countElements(chunk), 1)
			numberOfElementsToDelete += numElementsInChunk
		} while ( countElements(chunk) == 0 )
		
		return numberOfElementsToDelete
	}
	
	var isAtBeginningOfPotentialWord: Bool {
		get {
			if self.isEmpty {
				return true
			}
			
			// ORIGINAL REGEX: ^.*( |/|—)$
			let match = self.rangeOfString("^.*( |/|—)$", options: .RegularExpressionSearch)
			if !match.isEmpty {
				return true
			}
			
			return false
		}
	}
	
	var isAtBeginningOfPotentialSentence: Bool {
		get {
			if self.isEmpty {
				return true
			}
			
			// ORIGINAL REGEX: ^.*[\.\!\?][")]?\s+$
			let match = self.rangeOfString("^.*[\\.\\!\\?][\")]?\\s+$", options: .RegularExpressionSearch)
			if !match.isEmpty {
				return true
			}
			
			return false
		}
	}
	
}
