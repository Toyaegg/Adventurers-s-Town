class_name Adventurer
extends Node

enum Tier{
	Normal,
	Elite,
	Ultimate,
}

enum PotentialTendency{
	Attack,
	Defence,
	HP,
}

const ADVENTURER_MAX_LEVEL = 1000

enum State{
	Idel,
	Rest,
	Shopping,
	Selling,
	ToDungeons,
	Back,
	Continue,
	Treat,
	Dispel,
	Cursed,
	Wounded,
	TakeMoney,
	SubmitTask,
	AcceptTask,
	ChallengeDungeon,
	EnhanceStrength,
}
