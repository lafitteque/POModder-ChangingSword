extends Node

const MYMODNAME_LOG = "POModder-TutorialTemplate"
const MYMODNAME_MOD_DIR = "POModder-TutorialTemplate/"

var dir = ""
var ext_dir = ""
var trans_dir = "res://mods-unpacked/POModder-TutorialTemplate/translations/"

func _init():
	ModLoaderLog.info("Init", MYMODNAME_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	ext_dir = dir + "extensions/"
	
	for loc in ["en" , "es" , "fr"]:
		ModLoaderMod.add_translation(trans_dir + "translations." + loc + ".translation")
	
	
func _ready():
	ModLoaderLog.info("Done", MYMODNAME_LOG)
	add_to_group("mod_init")
	
	StageManager.level_ready.connect(_on_level_ready)
	
	var pathToModYamlUpgrades = "res://mods-unpacked/POModder-TutorialTemplate/yaml/upgrades.yaml"
	var pathToModYamlAssignments = "res://mods-unpacked/POModder-TutorialTemplate/yaml/assignments.yaml"
	
	Data.parseAssignmentYaml(pathToModYamlAssignments)
	Data.parseUpgradesYaml(pathToModYamlUpgrades)	
	
	ModLoaderMod.install_script_extension("res://mods-unpacked/POModder-TutorialTemplate/extensions/Sword.gd")
	
func modInit():
	print("Test : Mod initialized")
	pass

func _on_level_ready():
	print("Test : Level Ready")
	pass
