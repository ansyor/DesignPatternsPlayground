//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol Command {
	func execute()
	func undo()
	func redo()
}

class Tv {
	var isOn: Bool = false
	var channel: Int = 0
	
	func switchOn() {
		self.isOn = true
	}
	
	func switchOff() {
		self.isOn = false
	}
	
	func switchChannel(channel: Int) {
		self.channel = channel
	}
}

class TvOnCommand: Command {
	
	var tv: Tv
	
	init(tv: Tv) {
		self.tv = tv
	}
	
	func execute() {
		tv.switchOn()
	}
	
	func undo() {
		tv.switchOff()
	}
	
	func redo() {
		tv.switchOn()
	}
}

class TvOffCommand: Command {
	
	var tv: Tv
	
	init(tv: Tv) {
		self.tv = tv
	}
	
	func execute() {
		tv.switchOff()
	}
	
	func undo() {
		tv.switchOn()
	}
	
	func redo() {
		tv.switchOff()
	}
}

class TvSwitchChannel: Command {
	
	var tv: Tv
	var oldChannel: Int
	var newChannel: Int
	
	init(tv: Tv, newChannel: Int) {
		self.tv = tv
		self.oldChannel = tv.channel
		self.newChannel = newChannel
	}
	
	func execute() {
		tv.switchChannel(channel: newChannel)
	}
	
	func undo() {
		tv.switchChannel(channel: oldChannel)
	}
	
	func redo() {
		tv.switchChannel(channel: newChannel)
	}
}

struct CommandStack {
	var commandStacks = [Command]()
	
	mutating func push(command: Command) {
		commandStacks.append(command)
	}
	
	mutating func pop() -> Command {
		return commandStacks.removeLast()
	}
}

class CommandManager {
	var undoStack = CommandStack()
	var redoStack: CommandStack?
	
	func executeCommad(command: Command) {
		redoStack = CommandStack()
		command.execute()
		undoStack.push(command: command)
	}
	
	func undo() {
		
		guard undoStack.commandStacks.count > 0 else {
			return
		}
		
		let topUndo = undoStack.pop()
		topUndo.undo()
		redoStack?.push(command: topUndo)
	}
	
	func redo() {
		
		guard var validRedoStack = redoStack, validRedoStack.commandStacks.count > 0 else {
			return
		}
		
		let topRedo = validRedoStack.pop()
		topRedo.redo()
		undoStack.push(command: topRedo)
	}
}


var tv = Tv()
var commandManager = CommandManager()

print("Tv is \(tv.isOn)")
commandManager.executeCommad(command: TvOnCommand(tv: tv))
print("Tv is \(tv.isOn)")

print("Tv channel \(tv.channel)")
commandManager.executeCommad(command: TvSwitchChannel(tv: tv, newChannel: 3))
print("Tv channel \(tv.channel)")

commandManager.executeCommad(command: TvSwitchChannel(tv: tv, newChannel: 5))
print("Tv channel \(tv.channel)")

commandManager.executeCommad(command: TvSwitchChannel(tv: tv, newChannel: 10))
print("Tv channel \(tv.channel)")

commandManager.undo()
print("Tv channel \(tv.channel)")

commandManager.redo()
print("Tv channel \(tv.channel)")

commandManager.undo()
print("Tv channel \(tv.channel)")

commandManager.undo()
print("Tv channel \(tv.channel)")

commandManager.undo()
print("Tv channel \(tv.channel)")
print("Tv isOn \(tv.isOn)")

commandManager.undo()
print("Tv isOn \(tv.isOn)")