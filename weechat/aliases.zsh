if command -v weechat >/dev/null 2>&1 ; then
  alias weechat='LD_PRELOAD=$HOME/.lib/libwcwidth.so weechat'
fi
