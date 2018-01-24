//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

typealias Name = String

struct NameRepository {
	var names: [Name]
	let no: Int = 0
}

struct NamesIterator: IteratorProtocol {
	
	private var current = 0
	private let names: [Name]
	
	init(names: [Name]) {
		self.names = names
	}
	
	mutating func next() -> Name? {
		defer { current += 1 }
		return names.count > current ? names[current] : nil
	}
}

extension NameRepository: Sequence {
	func makeIterator() -> NamesIterator {
		return NamesIterator(names: names)
	}
}

let names = [ "Edo" , "MasHeri", "Sinta", "Yoga"]
let namesRepository = NameRepository(names: names)

for name in namesRepository {
	print("I've read: \(name)")
}
