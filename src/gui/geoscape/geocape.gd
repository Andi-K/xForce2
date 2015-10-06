extends Control

func _ready():
	get_node("AcceptDialog/RichTextLabel").connect("meta_clicked", self, "_on_RichTextLabel_meta_clicked")

# open URL in Browser
func _on_RichTextLabel_meta_clicked( meta ):
	print("open URL: " + meta)
	OS.shell_open(meta)
