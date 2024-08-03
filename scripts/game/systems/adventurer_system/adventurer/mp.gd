class_name MP
extends Node

var mp : float

var cur_mp : float

var mp_amount : float:
	get:
		return cur_mp / mp;
