extends Tree

var all_items = []
var objects
var filter_node_type
var filter_node_cat
var filter_node_sort

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
	
func update_tree_all():
	self.clear()
	var root =  self.create_item(self.get_root())
	var last_type = "!"
	var type_item
	var last_cat = "!"
	var cat_item
	var last_item
	
	for id_str in all_items:
		var object = objects.id_str[id_str]
		if filter(object):
			var parts = id_str. split("_")
			if last_type != parts[0]:
				last_type = parts[0]
				type_item = self.create_item(root)
				type_item.set_text(0, tr("TYPE_"+ last_type))
				last_cat = "!"
			if last_cat != parts[1]:
				last_cat = parts[1]
				if last_cat == "":
					cat_item = type_item
				else:
					cat_item = self.create_item(type_item)
					cat_item.set_text(0, tr("CAT_"+ last_cat))
			var item = self.create_item(cat_item)
			item.set_text(0, object.name)
			if object.icon != "":
				item.set_icon(0, get_node("/root/Data").load_res(object.icon))
			item.set_metadata(0, id_str)
			last_item = item
	last_item.select(0)

func update_tree():
	self.clear()
	var root =  self.create_item(self.get_root())
	var last_item
	
	for id_str in all_items:
		var object = objects.id_str[id_str]
		if filter(object):
			var item = self.create_item(root)
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
		update_tree_all()

func update_info():
	var id_str = get_selected().get_metadata(get_selected_column())
	if id_str == null:
		return
	var object =  get_node("/root/Data").objects.id_str[id_str]
	print(object)
	if object.image != "":
		get_node("../Image").set_texture(get_node("/root/Data").load_res(object.image))
	else:
		get_node("../Image").set_texture(null)
	get_node("../Label").set_text(object.name)
#	print(object.description)
	get_node("../Info/Descripion").parse_bbcode(object.description)
	if object.get("research") != null:
		get_node("../Info/Research").parse_bbcode(object.get("research"))
#	get_node("../Info/Production").parse_bbcode(object.description)
	if object.get("details_order") != null:
		var bbc = ""
		for detail in object.details_order:
			if object.details[detail] == null:
				pass
			elif (typeof(object.details[detail]) == TYPE_DICTIONARY):
				bbc += ""+ tr("OBJECT_DETAIL_" + detail) + " [right]"
				for detail_str in object.details[detail]:
					bbc += tr(detail_str) +": "+ str(object.details[detail][detail_str]) + "\n"
				bbc += "[/right]\n"
			else:
				bbc += ""+ tr("OBJECT_DETAIL_" + detail) + " [right]" + str(object.details[detail]) +"[/right]\n"
		get_node("../Info/Details").parse_bbcode(bbc)
	else:
		get_node("../Info/Details").parse_bbcode("")
	

# open URL in Browser
func _on_RichTextLabel_meta_clicked( meta ):
	print("open URL: " + meta)
	OS.shell_open(meta)

func _ready():
	objects = get_node("/root/Data").objects
	self.set_columns(1)
	self.set_hide_root(true)
	connect("cell_selected", self, "update_info")
	
	filter_node_type = get_node("../Filter/Type")
	filter_node_cat = get_node("../Filter/Category")
	filter_node_type.add_item(tr("FILTER_NONE"))
	filter_node_cat.add_item(tr("FILTER_NONE"))
	filter_node_type.connect("item_selected", self, "on_type_selected")
	filter_node_cat.connect("item_selected", self, "on_type_selected")

	filter_node_sort = get_node("../Filter/Sort")
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

	update_tree_all()

# Callback for .sort_custom()
func sort_items(a, b):
	objects = get_node("/root/Data").objects
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

#	var item = self.create_item(root)
#	item.set_text(0, "Aliens")
#	var child = self.create_item(item)
#	child.set_text(0, "Movi")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "E.T.")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "ALF")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "Brain Bug")
#	var child = self.create_item(item)
#	child.set_text(0, "Marsiana")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "Mars-Man")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "Mars-Woman")
#
#	var item2 = self.create_item(root)
#	item2.set_text(0, "Ufos")
#	var child = self.create_item(item2)
#	child.set_text(0, "Movi")
#	var child = self.create_item(item2)
#	child.set_text(0, "Marsiana")
#	var subchild = self.create_item(child)
#	subchild.set_text(0, "Flying saucer")
