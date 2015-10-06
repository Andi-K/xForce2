# singelton /root/Data autoloaded via engine.cfg
#
# store and manage all game / gameset data

extends Node

# user mutable game config
var config # = {"play_intro" : false, "lang" : "en"}

# static game config (game version etc.)
# => use Project Setings / Globals.get()

# gameset config (ID = short filesystem safe name)
var gameset

# list of game set objects (xforse-Base, groundunits)
var objects

# list of gui scenes
var pages # = {
	#poc = "PoC GorndBattel",
	#geoscape = {"name" : "Geoscape", "color" : "red", "sidebar" : 2, "custom" : ""}, 
	#ufopedia = {"name" : "UFOpedia", "color" : "red", "sidebar" : 1, "custom" : ""},
	#demo = {"name" : "Godot Example", "color" : "black", "sidebar" : 1, "custom" : "demo"},
	# = "Bases",
	# = "Fleet",
	# = "Combat Units",
	# = "Research",
	# = "Production",
	# = "Storage",
	# = "Job market",
	# = "Base information",
	# = "Countries",
	# = "Finanzes",
#}

# used for runtime added Translations
var translation = Translation.new()

var curent = {"page": "geoscape", "player": "Dummy", "resolution": "FHD"}

func _ready():
	var last
	if check_file("user://last.cfg"):
		last = load_cfg("user://last.cfg")["last"]
		config = load_cfg("user://game.cfg")["config"]
	else:
		last = {"player" : "Dummy", "gameset" : "demo"}
		config = load_cfg("res://data/user/game.cfg")["config"]
		save_cfg({"last": last}, "user://last.cfg")
		save_cfg({"config": config}, "user://game.cfg")
		
#	print(last)
#	print(config)
	
	# todo: change to user://
	curent["gameset_path"] = "res://gameset/" + last.gameset + "/"

	load_trans("en", false)
	if load_trans(config["lang"]) == null: 
		# use en as fallback 
		load_trans("en")
		translation.set_locale("en")
		TranslationServer.set_locale("en")
	else:
		translation.set_locale(config["lang"])
		TranslationServer.set_locale(config["lang"])
	TranslationServer.add_translation(translation)

	# TODO: load from gemeset
	pages = load_file("res://data/mod/pages.json", 0)

	gameset = load_cfg(curent["gameset_path"] + "gameset.cfg")["main"]

	var object_list = preload("res://scripts/data/object-list.gd")
	objects = object_list.new(load_cfg("gs://objects.dat"))

func load_res(var res_path):
	if res_path.begins_with('gs://'):
		res_path = curent["gameset_path"] + res_path.right(5)
	var res = load(res_path)
	return res

# generate a csv file for gameset translations
func save_tr_str_gs(lang, file):
	var tr_strings = []
	var cats =[]
	
	for id_str in objects.id_str:
		tr_strings.append(id_str +"_NAME")
		tr_strings.append(id_str +"_DESC")
		for detail in objects.id_str[id_str].details:
			if tr_strings.find("OBJECT_DETAIL_" + detail) < 0:
				tr_strings.append("OBJECT_DETAIL_" + detail)
		if cats.find(objects.id_str[id_str].category) < 0:
			cats.append(objects.id_str[id_str].category)
	
	tr_strings.sort()
	cats.sort()
	
	for otype in objects.object_types:
		tr_strings.append("TYPE_" + objects.object_types[otype].type)
	for stri in cats:
		tr_strings.append("CAT_" + stri)
	
	var trans
	if config["lang"] != lang:
		trans = load_trans(lang)
		
	var csv_str = "# TransStr, "+ lang +"\n"
	for stri in tr_strings:
		var tr = tr(stri)
		if stri == tr:
			tr = "untranslated"
		csv_str += "\""+ stri +"\", \""+ tr +"\"\n"

#	print(csv_str)
	save_file(csv_str, file +"."+ lang +".csv")

	if config["lang"] != lang:
		TranslationServer.set_locale(config["lang"])
		if trans != null: # .is_type("PHashTranslation"):
			TranslationServer.remove_translation(trans)

func load_trans(lang, gs = true):
	var path
	if gs:
		path = "gs://translation."+ lang +".xl"
	else:
		path = "res://translations/translation."+ lang +".xl"
	var trans = load_res(path)
	if trans != null:
		trans.set_locale(lang)
		TranslationServer.add_translation(trans)
		return trans
	else:
		printerr("ERR: Can't load translation '" + path +"'")
		return null  

func add_trans(trans, prefix = ""):
	var lang = translation.get_locale()
	if trans.has(lang):
		for id_str in trans[lang]:
			translation.add_message(prefix + id_str, trans[lang][id_str])


#### file utils ####
# Description:
# Load / save / check for file (savegames)
 
# Usage:
# save_file(a,b,c,d) / load_file(b,c,d) / check_file(b)
# a = data (like array or dictionary)
# b = filename (user://temp_save.txt)
# c = no password (0) use OS.crypt (1) or password (2)
# d = password
 
# Based on:
# Author (s)
# Marco Heizmann
# Version:
# V1.0
# Link:
# http://www.godotengine.de/de/script_modules/mod_file
 
######## Test mode should always be present.
#func modtest():
#	print("Module -mod_file- loaded")
#	return true
########
 
# save file
func save_file(a, b="", c=null, d=null):
	var data

	if (typeof(a) == TYPE_DICTIONARY):
		data = a.to_json()
	else:
		data = str(a)
	# any data?
	if data != "":
		# filename correct?
		if b.begins_with('gs://'):
			b = curent["gameset_path"] + b.right(5)
		if b.begins_with('res://') or b.begins_with('user://'):
			var filex = File.new()
			var error
			# write file
			if c == 1:    # with OS.crypt
				error = filex.open_encrypted_with_pass(b, File.WRITE, OS.get_unique_ID())
			elif c == 2:  # with password
				error = filex.open_encrypted_with_pass(b, File.WRITE, d)
			else:
				error = filex.open(b, File.WRITE)
			#now write
			if (filex.is_open()):
				filex.store_string(data)
				filex.close()
				return true
			else:
				print("Unable to read file "+ b +"!")
				return error
		else:
			print("file doesn't exist "+ b +"!")
			return false
	else:
		print("invald file path "+ b +"!")
		return false
 
# load file
func load_file(b="", c=null, d=null):
	# filename correct?
	if b.begins_with('gs://'):
		b = curent["gameset_path"] + b.right(5)
	if b.begins_with('res://') or b.begins_with('user://'):
		# file exists?
		if check_file(b):
			var filex = File.new()
			var error
			var returndata = {}
			# open file
			if c == 1:    # with OS.crypt
				error = filex.open_encrypted_with_pass(b, File.READ, OS.get_unique_ID())
			elif c == 2:  # with password
				error = filex.open_encrypted_with_pass(b, File.READ, d)
			else:
				error = filex.open(b, File.READ)
			#now read
			if (filex.is_open()):
				returndata.parse_json(filex.get_as_text())
				filex.close()
				# TODO: catch error

				# return filecontent
				return returndata
			else:
				print("Unable to read file "+ b +"!")
				return error
		else:
			print("file doesn't exist "+ b +"!")
			return false
	else:
		print("invald file path "+ b +"!")
		return false
 
# check for file exists
func check_file(b=""):
	# filename correct?
	
	if b.begins_with('res://') or b.begins_with('user://'):
		# file exists?
		if File.new().file_exists(b):
			return true # file exists
		else:
			return false # file doesn't exist
	else:
		return false # wrong filename

### END file utils  ###

func save_cfg(dic, path):
	var f = ConfigFile.new()
	if path.begins_with('gs://'):
		path = curent["gameset_path"] + path.right(5)
#	f.load(path)
	for section in dic:
		for key in dic[section]:
#			f.set_value(section, key, str(dic[section][key]))
			if typeof(dic[section][key]) == TYPE_REAL:
				# BUG: Integers are saved as Real
				# FIXME: Remove it if saving integers works
				f.set_value(section, key, str(dic[section][key]))
#			else:
			f.set_value(section, key, dic[section][key])
	f.save(path)

func load_cfg(path):
	var dic = {}
	var f = ConfigFile.new()
	if path.begins_with('gs://'):
		path = curent["gameset_path"] + path.right(5)
	if f.load(path) > 0:
		printerr("can't load '"+ path +"'")
		
	for section in f.get_sections():
		var keys = {}
		for key in f.get_section_keys(section):
			keys[key] = f.get_value(section, key)
		dic[section] = keys
	return dic
 