extends Node

var level := -1
var playerCount := 0
var speedMultiplier := 1.5
var originalChanceOfBooster := 0.1 # Percent from 0 to 1
var chanceOfBooster := originalChanceOfBooster

func setLevel(lev):
	level = lev

func getLevel():
	return level
