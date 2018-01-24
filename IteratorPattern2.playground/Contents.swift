//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol Iterator {
	
	func hasNext() -> Bool
	func next() -> AnyObject?
	
}

protocol Container {
	
	var iterator: Iterator? { get set }
	
}

class NamesRepository: Container {
	var iterator: Iterator?
	
	var names: [String]
	
	init(names: [String]) {
		self.names = names
		
		createIterator()
	}
	
	func createIterator() {
		iterator = NameIterator(nameRepository: self)
	}
	
	class NameIterator: Iterator {
		
		var names: [String]
		var currentIndex: Int = 0
		
		init(nameRepository: NamesRepository) {
			self.names = nameRepository.names
		}
		
		func hasNext() -> Bool {
			let names = self.names
			
			return currentIndex < names.count
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

}

let names = [ "Edo" , "MasHeri" , "Sinta", "Yoga", "Iqbal"]
let namesRepository = NamesRepository(names: names)

print(namesRepository.iterator?.next())