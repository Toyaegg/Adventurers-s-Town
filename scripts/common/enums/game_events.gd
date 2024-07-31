class_name GameEvents
extends Node

##游戏流程
const GAME_START := "game_start"
const GAME_RESUME := "game_resume"
const GAME_EXIT := "game_exit"
const GAME_LOAD := "game_laod"
const SAVE_FILE_LOADED := "save_file_loaded"


##UI控制
const UI_OPEN := "ui_open"
const UI_HIDE := "ui_hide"
const UI_CLOSE := "ui_close"
const UI_TIPS_OPEN := "ui_tips_open"
const UI_PROGRESS_CHANGED := "ui_progress_changed"
const UI_VISIBLE_BUILDING_INFO := "ui_visible_building_info"


##建造
const BUILD_BUILDING := "build_building"
const BUILD_CLICK_BUILD_MENU := "build_click_build_menu"
const BUILD_BUILDING_COMPLETE := "build_building_complete"
const BUILD_ENTER_BUILD_MODE := "build_enter_build_mode"

##时间
const TIME_VALUE_CHANGED := "time_value_changed"
const TIME_SYSTEM_START := "time_system_start"
const TIME_SYSTEM_STOP := "time_system_stop"
const TIME_SET_TIME_SPEED := "time_set_time_speed"
