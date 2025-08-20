# This one copies it
#!/bin/bash

# Select a bookmark from your file using wofi
bookmark=$(grep -v '^#' ~/mega/bookmarks | wofi --dmenu --prompt "Bookmarks:" | cut -f2)

# If a bookmark was selected, copy it to the clipboard using wl-copy
[ -n "$bookmark" ] && echo -n "$bookmark" | wl-copy
