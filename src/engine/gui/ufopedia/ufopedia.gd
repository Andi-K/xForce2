extends Control

var all_items = []
var objects
var filter_node_type
var filter_node_cat
var filter_node_sort
var selected_ids = []

func _ready():
	var tree = get_node("Tree")
	tree.set_columns(1)
	tree.set_hide_root(true)
	tree.set_select_mode(tree.SELECT_MULTI)
#	tree.connect("cell_selected", self, "update_info")
	tree.connect("multi_selected", self, "_on_Tree_multi_selected")

	get_node("Info/Split/DETAILS").set_hide_root(true)

	objects = get_node("/root/Data").objects
	filter_node_type = get_node("Filter/Type")
	filter_node_cat = get_node("Filter/Category")
	filter_node_type.add_item(tr("FILTER_NONE"))
	filter_node_cat.add_item(tr("FILTER_NONE"))
	filter_node_type.connect("item_selected", self, "on_type_selected")
	filter_node_cat.connect("item_selected", self, "on_type_selected")

	filter_node_sort = get_node("Filter/Sort")
	for item in ["SORT_NONE", "SORT_A-Z", "SORT_Z-A", "---", "SORT_BY_ID"]:
		if item == "---":
			filter_node_sort.add_separator()
		else:
			filter_node_sort.add_item(tr(item))
	filter_node_sort.connect("item_selected", self, "on_sort_selected")
	
	var types = {}
	var cats = {}

	for id_str in objects.active:
		var object = objects.id_str[id_str]
		if filter(object):
			if types.has(object.type):
				types[object.type] += 1
			else:
				types[object.type] = 1
			if cats.has(object.category):
				cats[object.category] += 1
			else:
				cats[object.category] = 1
			all_items.append(id_str)

	all_items.sort()
	
	for type in types:
		filter_node_type.add_item(tr("TYPE_"+ type) + " ("+ str(types[type]) +")")
		filter_node_type.set_item_metadata(filter_node_type.get_item_count() -1, type)
	for cat in cats:
		filter_node_cat.add_item(tr("CAT_"+ cat) + " ("+ str(cats[cat]) +")")
		filter_node_cat.set_item_metadata(filter_node_cat.get_item_count() -1, cat)

	update_tree_unfiltered()

func filter(object):

	if not object extends (objects.object_types["STORY"]):
		return false
	if object.hiden:
		return false
	if filter_node_type.get_selected() > 0:
		if object.type != filter_node_type.get_selected_metadata():
			return false
	if filter_node_cat.get_selected() > 0:
		if object.category != filter_node_cat.get_selected_metadata():
			return false
	return true
	
func update_tree_unfiltered():
	var tree = get_node("Tree")
	tree.clear()
	var root =  tree.create_item(tree.get_root())
	var last_type = "!"
	var type_item
	var last_cat = "!"
	var cat_item
	var last_item = TreeItem.new()
	
	for id_str in all_items:
		var object = objects.id_str[id_str]
		if filter(object):
			var parts = id_str. split("_")
			if last_type != parts[0]:
				last_type = parts[0]
				type_item = tree.create_item(root)
				type_item.set_text(0, tr("TYPE_"+ last_type))
				last_cat = "!"
			if last_cat != parts[1]:
				last_cat = parts[1]
				if last_cat == "":
					cat_item = type_item
				else:
					cat_item = tree.create_item(type_item)
					cat_item.set_text(0, tr("CAT_"+ last_cat))
			var item = tree.create_item(cat_item)
			item.set_text(0, object.name)
			if object.icon != "":
				item.set_icon(0, get_node("/root/Data").load_res(object.icon))
			item.set_metadata(0, id_str)
			last_item = item
#	last_item.select(0)
#	selected_ids = [last_item.get_metadata(0)]

func update_tree():
	var tree = get_node("Tree")
	tree.clear()
	var root =  tree.create_item(tree.get_root())
	var last_item
	
	for id_str in all_items:
		var object = objects.id_str[id_str]
		if filter(object):
			var item = tree.create_item(root)
			item.set_text(0, object.name)
			item.set_metadata(0, id_str)
			last_item = item
	last_item.select(0)

func on_sort_selected( ID ):
	if ID > 0:
		all_items.sort_custom(self, "sort_items")
		on_type_selected( filter_node_type.get_selected() )
	else:
		all_items.sort()

func on_type_selected( ID ):
	if filter_node_type.get_selected() > 0:
		update_tree()
	else:
		update_tree_unfiltered()

func update_info():
	var tree = get_node("Tree")
	var id_str = tree.get_selected().get_metadata(tree.get_selected_column())
	if id_str == null:
		return
	var object =  objects.id_str[id_str]
	var text = ""
	text += "[center][b][i]"+ object.name +"[/i][/b][/center]\n\n"
	text += "\n\n[b][i]"+ tr("DESCRIPTION") +"[/i][/b]\n\n"
	text += object.description
#	if object.get("research") != null:
	text += "\n\n[b][i]"+ tr("RESEARCH") +"[/i][/b]\n\n"
	text += "(Reserch text)"
	text += "\n\n[b][i]"+ tr("PRODUCTION") +"[/i][/b]\n\n"
	text += "(Production text)\n\n"
	get_node("Info/DESCRIPTION").parse_bbcode(text)

	if object.image != "":
#		get_node("Info/DESCRIPTION").push_align(RichTextLabel.ALIGN_CENTER)
#		get_node("Info/DESCRIPTION").add_image(get_node("/root/Data").load_res(object.image))
		get_node("Info/Split/Image").set_texture(get_node("/root/Data").load_res(object.image))
	else:
		get_node("Info/Split/Image").set_texture(null)

	var node = get_node("Info/Split/DETAILS")
	node.set_columns(2)
	node.clear()
	if object.get("details_order") != null:
		var root =  node.create_item(node.get_root())
		node.set_column_title(1, object.name)
		for detail in object.details_order:
			if typeof(object.details[detail]) == TYPE_NIL:
				pass
			elif typeof(object.details[detail]) == TYPE_DICTIONARY:
				var item = node.create_item(root)
				item.set_text(0, tr("OBJECT_DETAIL_" + detail))
				for detail_str in object.details[detail]:
					var sub_item = node.create_item(item)
#					item.set_text(0, tr(detail_str))
					sub_item.set_text(0, detail_str)
					sub_item.set_text(1, str(object.details[detail][detail_str]))
			else:
				var item = node.create_item(root)
				item.set_text(0, tr("OBJECT_DETAIL_" + detail))
				item.set_text(1, str(object.details[detail]))
	

# open URL in Browser
func _on_RichTextLabel_meta_clicked( meta ):
	print("open URL: " + meta)
	OS.shell_open(meta)


# Callback for .sort_custom()
func sort_items(a, b):
	if (b==null):
		return false
	
	var sory_type = filter_node_sort.get_selected()
	if  sory_type == 1:
		var A = objects.id_str[a].name
		var B = objects.id_str[b].name
		if (A.nocasecmp_to(B)>=0):
			return false
	elif  sory_type == 2:
		var A = objects.id_str[a].name
		var B = objects.id_str[b].name
		if (A.nocasecmp_to(B)<0):
			return false
	elif  sory_type == 4:
		var A = objects.id_str[a].id
		var B = objects.id_str[b].id
		if (A > B):
			return false
	
	return true

func _on_Tree_multi_selected( item, column, selected ):
	var id_str = item.get_metadata(column)
	if id_str == null:
		return
	if selected:
		selected_ids.append(id_str)
	else:
		selected_ids.erase(id_str)

	if selected_ids.size() > 0:
		get_node("Info").set_collapsed(true)
		get_node("Info/Split").set_collapsed(true)
		var node = get_node("Info/Split/DETAILS")
		node.set_column_titles_visible(true)
		node.set_columns(1 + selected_ids.size())
		node.clear()
		var all_details = []
		for id in selected_ids:
			var object =  objects.id_str[id]
			for detail in object.details_order:
				if all_details.find(detail) == -1:
					all_details.append(detail)
		
		var root =  node.create_item(node.get_root())
		var type_item =  node.create_item(root)
		type_item.set_text(0, tr("TYPE"))
		var cat_item =  node.create_item(root)
		cat_item.set_text(0, tr("CATEGORY"))
		var col = 1
		for id in selected_ids:
			var object =  objects.id_str[id]
			node.set_column_title(col, object.name)
			type_item.set_text(col, tr("TYPE_"+ object.type))
			cat_item.set_text(col, tr("CAT_"+ object.category))
			col += 1

		for detail in all_details:
			var item =  node.create_item(root)
			item.set_text(0, tr("OBJECT_DETAIL_" + detail))
			var col = 1
			for id in selected_ids:
				var object =  objects.id_str[id]
				if !object.details.has(detail) or typeof(object.details[detail]) == TYPE_NIL:
					item.set_text(col, "---")
				elif typeof(object.details[detail]) == TYPE_DICTIONARY:
					for detail_str in object.details[detail]:
						var sub_item = node.create_item(item)
	#					item.set_text(0, tr(detail_str))
						sub_item.set_text(0, detail_str)
						sub_item.set_text(col, str(object.details[detail][detail_str]))
						sub_item.set_selectable(col, false)
				else:
					item.set_text(col, str(object.details[detail]))
				item.set_selectable(col, false)
				col += 1
	else:
		get_node("Info").set_collapsed(false)
		get_node("Info/Split").set_collapsed(false)
		get_node("Info/Split/DETAILS").set_column_titles_visible(false)
	if selected_ids.size() == 1:

		get_node("Info").set_collapsed(false)
		get_node("Info/Split").set_collapsed(false)
		get_node("Info/Split/DETAILS").set_column_titles_visible(false)
		var tree = get_node("Tree")
		id_str = tree.get_selected().get_metadata(tree.get_selected_column())
		var object =  objects.id_str[id_str]
		var text = ""
		text += "[center][b][i]"+ object.name +"[/i][/b][/center]\n\n"
		text += "\n\n[b][i]"+ tr("DESCRIPTION") +"[/i][/b]\n\n"
		text += object.description
	#	if object.get("research") != null:
		text += "\n\n[b][i]"+ tr("RESEARCH") +"[/i][/b]\n\n"
		text += "(Reserch text)"
		text += "\n\n[b][i]"+ tr("PRODUCTION") +"[/i][/b]\n\n"
		text += "(Production text)\n\n"
		get_node("Info/DESCRIPTION").parse_bbcode(text)
	
		if object.image != "":
	#		get_node("Info/DESCRIPTION").push_align(RichTextLabel.ALIGN_CENTER)
	#		get_node("Info/DESCRIPTION").add_image(get_node("/root/Data").load_res(object.image))
			get_node("Info/Split/CenterContainer/Image").set_texture(get_node("/root/Data").load_res(object.image))
		else:
			get_node("Info/Split/CenterContainer/Image").set_texture(null)
