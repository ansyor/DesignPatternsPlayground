//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct User {
	static let sharedInstance = User()
	
	private init() { }
}

