if [ -d "$(brew --prefix)/opt/python/libexec/bin" ]; then
  export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"
fi
