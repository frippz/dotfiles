# Darwin only aliases
#

case "$OSTYPE" in
  *darwin*)
    # Clean up "Open with…" menu
    alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
    ;;
esac
