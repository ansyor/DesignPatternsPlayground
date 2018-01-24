//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Expenditure {
	
	var amount: Int
}

protocol Chain {
	
	var nextManagementLevel: Chain? { get set }
	func shouldApprovExpenditure(expenditure: Expenditure)
	
}

class Employee: Chain {
	var nextManagementLevel: Chain?
	
	func shouldApprovExpenditure(expenditure: Expenditure) {
		let amount = expenditure.amount
		
		if (amount < 100) {
			print("(****) \(self) can approve this expenditure")
		} else {
			print("\(self) cannot approve this expenditure!")
			guard let validNextManagementLevel = nextManagementLevel else {
				return
			}
			
			validNextManagementLevel.shouldApprovExpenditure(expenditure: expenditure)
		}
	}
}

class Manager: Chain {
	var nextManagementLevel: Chain?
	
	func shouldApprovExpenditure(expenditure: Expenditure) {
		let amount = expenditure.amount
		
		if (amount > 101 && amount < 1000) {
			print("(****) \(self) can approve this expenditure")
		} else {
			print("\(self) cannot approve this expenditure!")
			guard let validNextManagementLevel = nextManagementLevel else {
				return
			}
			
			validNextManagementLevel.shouldApprovExpenditure(expenditure: expenditure)
		}
	}
}

class CEO: Chain {
	var nextManagementLevel: Chain?
	
	func shouldApprovExpenditure(expenditure: Expenditure) {
		let amount = expenditure.amount
		
		if (amount > 1001 && amount < 10000) {
			print(" (****) \(self) can approve this expenditure")
		} else {
			print("This expediture is too big")
		}
	}
}

let employee = Employee()
let manager = Manager()
let ceo = CEO()

employee.nextManagementLevel = manager
manager.nextManagementLevel = ceo

var expenditure = Expenditure(amount: 50)
employee.shouldApprovExpenditure(expenditure: expenditure)

expenditure = Expenditure(amount: 500)
employee.shouldApprovExpenditure(expenditure: expenditure)

expenditure = Expenditure(amount: 5000)
employee.shouldApprovExpenditure(expenditure: expenditure)

expenditure = Expenditure(amount: 50000)
employee.shouldApprovExpenditure(expenditure: expenditure)
