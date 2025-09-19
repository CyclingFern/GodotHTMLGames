extends Node

var fishPosition = Vector3()
var vrconsole = ""
var vrControls = Vector3()

func log(text):
	vrconsole += "\t\n" + str(text)
	return true

func move_drone(input):
	vrControls = input
	return true

func eatVRControls():
	vrControls = Vector3()
