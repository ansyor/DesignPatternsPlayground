//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol Iterator {
	
	var first: AnyObject? { get }
	func hasNext() -> Bool
	func next() -> AnyObject?
	
}

protocol Container {
	
	var iterator: Iterator? { get set }
	
}

class NameIterator: Iterator {
	
	var first: AnyObject? {
		return names.first as AnyObject?
	}
	
	var names: [String]
	var currentIndex: Int = 0

	
	init(names : [String]) {
		self.names = names
	}
	
	func hasNext() -> Bool {
		let names = self.names
		
		return currentIndex < (names.count - 1)
	}
	
	func next() -> AnyObject? {
		if self.hasNext() {
			let nextIndex = names.index(after: currentIndex)
			currentIndex = nextIndex
			
			return self.names[nextIndex] as AnyObject?
		}
		
		return nil
	}
}

class NamesRepository: Container {
	var iterator: Iterator?
	
	var names: [String]?
	
	init(names: [String]) {
		self.names = names
	}
}

let names = [ "Edo" , "MasHeri" , "Sinta", "Yoga", "Iqbal"]
let namesRepository = NamesRepository(names: names)
let nameIterator = NameIterator(names: names)

namesRepository.iterator = nameIterator

print(nameIterator.first)

while nameIterator.hasNext() {
	print(namesRepository.iterator?.next())
}

// Cek lagi : http://www.journaldev.com/1716/iterator-design-pattern-java
// http://audreyli.me/2015/07/04/a-design-pattern-story-in-swift-chapter-9-iteratorsequence-and-generator/
