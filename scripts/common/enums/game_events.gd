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
const BUILDING_LEVEL_UP := "404"
const BUILDING_LEVEL_UP_FINISH := "405"

const BUILDING_FEATURE_FINISH_DUNGEON := "410"
const BUILDING_FEATURE_FINISH_SHOPPING := "411"
const BUILDING_FEATURE_FINISH_SELLING := "412"
const BUILDING_FEATURE_FINISH_TREAT := "413"
const BUILDING_FEATURE_FINISH_LIFT := "414"
const BUILDING_FEATURE_FINISH_BLESSING := "415"
const BUILDING_FEATURE_FINISH_REST := "416"
const BUILDING_FEATURE_FINISH_TRAINING := "417"

const GOLD_CAST := "440"

const BUILDING_ADVENTURER_UNION_ADD_EXP := "450"
const BUILDING_ADVENTURER_UNION_LEVEL_UP := "451"



##冒险者
const ADVENTURER_CREATED := "500"
const ADVENTURER_CHALLENGE_DUNGEON := "501"
const ADVENTURER_SHOPPING := "502"
const ADVENTURER_SELLING := "503"
const ADVENTURER_TREAT := "504"
const ADVENTURER_LIFT := "505"
const ADVENTURER_BLESSING := "506"
const ADVENTURER_REST := "507"
const ADVENTURER_TRAINING := "508"

const ADVENTURER_GOLD_CHANGED := "510"
const ADVENTURER_EXP_CHANGED := "511"


##地下城
const DUNGEON_CREATED := "600"
const DUNGEON_FINISH_MESSAGE := "601"


##资源
const RESOURCE_ADD := "700"
const RESOURCE_USE := "701"
const RESOURVE_CHANGED := "702"
