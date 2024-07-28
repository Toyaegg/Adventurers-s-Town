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


##游戏控制
const GAME_HANDLE_BUILDING := "game_handle_building"
const GAME_HANDLE_CLICK_BUILD_MENU := "game_handle_click_build_menu"
const GAME_HANDLE_BUILDING_COMPLETE := "game_handle_building_complete"
const GAME_HANDLE_ENTER_BUILD_MODE := "game_handle_enter_build_mode"
