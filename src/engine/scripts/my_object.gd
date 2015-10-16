extends Node

export(String)    var foo = "bar" 
export(int)       var id = 4
export(bool)      var test = false

var do_not = "export" 
var this_vars = true 

func get_export_vars():
    # TODO: find a more safe way to get export vars
    var export_vars = []
    var properties = get_property_list()
    for p in properties:
        if p.usage == 7:
            export_vars.append(p.name)
    return export_vars

func as_dict():
    var dic = {}
    for property in get_export_vars():
        dic[property] = self[property]
    return dic

func from_dict(dic):
    for p in dic:
        self[p] = dic[p]

func _init(serialized = null):
	if serialized != null:
		var dic = {}
		dic.parse_json(serialized)
		from_dict(dic)

