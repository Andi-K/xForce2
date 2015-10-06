# nunber "translation" / format
# convert a int or real into a localisiced string
#
# your have to include "DECIMALS_SEP" and "THOUSANDS_SEP" in your translations
static func ntr(number, max_decimals = -1):
	var decimals_sep = tr("DECIMALS_SEP")
	if decimals_sep == "DECIMALS_SEP":
		decimals_sep = "."
	var thousands_sep = tr("THOUSANDS_SEP")
	if thousands_sep == "THOUSANDS_SEP":
		thousands_sep = ","
	var parts = []
	var deci
	
	if typeof(number) == TYPE_REAL: # Float
		if max_decimals == -1:
			deci = str(number).split(".")[1]
		elif max_decimals != 0:
			deci = str(number).pad_decimals(max_decimals).split(".")[1]
		number = int(number)
	
	if typeof(number) == TYPE_STRING:
		if number.is_valid_integer():
			number = number.to_int()
		elif number.is_valid_float():
			if max_decimals == -1:
				deci = number.split(".")[1]
			elif max_decimals != 0:
				deci = number.pad_decimals(max_decimals).split(".")[1]
			number = number.to_int()
		else:
			return ""

	while number > 1000:
		var part = floor(number % 1000)
		parts.append(str(part).pad_zeros(3))
		number = int(number / 1000)
	var string = str(floor(number))
	
	parts.invert()
	for part in parts:
		string += thousands_sep + part

	if typeof(deci) != TYPE_NIL:
		string += decimals_sep + deci
	return string

