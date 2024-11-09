# According to https://help.obsidian.md/Obsidian/Credits#Lucide
# The version of lucide used by Obsidian is currently v0.268.0 ._.
LUCIDE_VERSION="0.268.0"

# Check if there's a lucide-icons*/ in $PWD
if [[ -d "icons/" ]]; then
	printf "Found icons/ directory\n"
else
	printf "Please download the icons from the below URL\nhttps://github.com/lucide-icons/lucide/releases/tag/$LUCIDE_VERSION\n\nAnd then extract that zip file into this directory\n"
	return
fi

# Load in the icons
# Get the icon names

icons=();
files=(./icons/*)

printf "Found ${#files[@]} files in icons/\n";

for file in "${files[@]}"; do
	# We're ignoring the JSON files because they cause double ups
	if [[ $file == *".svg" ]]; then
		# Chop off the .svg & add the file name to our icons list!
		icons+=("${file:8:-4}");
	fi
done

printf "Found ${#icons[@]} icons";

# Make a mega custom callouts.css file
# Make a example callouts.md file
cssstring="";
examplemd="";

colour_i=0;
colour_names=("red" "orange" "yellow" "green" "cyan" "blue" "purple" "pink");
colours=("--color-red" "--color-orange" "--color-yellow" "--color-green" "--color-cyan" "--color-blue" "--color-purple" "--color-pink");

for item in "${icons[@]}"; do
	itemnodash=$(printf "$item" | sed 's/-//g')
	
	cssstring+="\n\t&[data-callout*=\"-$itemnodash-\"] {\n\t\t--callout-icon: \"$item\";\n\t}"
	
	examplemd+="> [!custom-$itemnodash-${colour_names[$colour_i]}] $itemnodash - $item \n\n"

	# Make the examples all rainbow :)
	if [[ $((colour_i+1)) == "${#colours[@]}" ]]; then
		colour_i=0;
	else
		colour_i=$((colour_i + 1));
	fi
done

# We can now make the custom callout list!
echo -e $examplemd > "mega custom callout list.md"

for ((i=0; i<${#colours[@]}; i++)); do
	cssstring+="\n\t&[data-callout*=\"-${colour_names[$i]}\"] {\n\t\t--callout-color: var(${colours[$i]});\n\t}"
done

# TODO: mega custom callouts.css needs a div[data-callout|="custom"]

echo -e "div[data-callout|=\"custom\"] {\n"$cssstring"}" > "mega custom callouts.css"
