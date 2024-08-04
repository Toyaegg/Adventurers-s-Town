class_name GameEvents
extends Node

##游戏流程
const GAME_START := "100"
const GAME_RESUME := "101"
const GAME_EXIT := "102"
const GAME_LOAD := "103"
const SAVE_FILE_LOADED := "104"


##UI控制
const UI_OPEN := "200"
const UI_HIDE := "201"
const UI_CLOSE := "202"
const UI_TIPS_OPEN := "203"
const UI_PROGRESS_CHANGED := "204"
const UI_VISIBLE_BUILDING_INFO := "205"

##时间
const TIME_VALUE_CHANGED := "300"
const TIME_SYSTEM_START := "301"
const TIME_SYSTEM_STOP := "302"
const TIME_SYSTEM_STARTED := "303"
const TIME_SYSTEM_STOPED := "304"
const TIME_SET_TIME_SPEED := "305"


##建造
const BUILD_BUILDING := "400"
const BUILD_CLICK_BUILD_MENU := "401"
const BUILD_BUILDING_COMPLETE := "402"
const BUILD_ENTER_BUILD_MODE := "403"



##冒险者
const ADVENTURER_CREATED := "500"
const ADVENTURER_ACCEPT_TASK := "501"
const ADVENTURER_COMPLETE_TASK := "adventurer_complete_task"
const ADVENTURER_SHOPPING := "adventurer_shopping"
const ADVENTURER_SELLING := "adventurer_selling"
const ADVENTURER_TREAT := "adventurer_treat"
const ADVENTURER_LIFT := "adventurer_lift"
const ADVENTURER_BLESSING := "adventurer_blessing"
const ADVENTURER_REST := "adventurer_rest"
const ADVENTURER_TRAINING := "adventurer_training"


##地下城
const DUNGEON_CREATED := "600"
