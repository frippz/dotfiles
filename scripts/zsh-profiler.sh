#!/bin/zsh

# Profile ZSH startup time
echo "=== ZSH Startup Profiler ==="
echo ""

# Method 1: Quick overall timing (run this 10 times for average)
echo "Overall startup time (10 runs):"
for i in {1..10}; do
  /usr/bin/time zsh -i -c exit 2>&1 | grep real
done
echo ""

# Method 2: Detailed profiling - uncomment plugins/sources in .zshrc
echo "To profile line-by-line, add this to the TOP of your ~/.zshrc:"
echo "  zmodload zsh/zprof"
echo ""
echo "And add this to the BOTTOM:"
echo "  zprof"
echo ""
echo "Then run: zsh -i -c exit"
echo ""

# Method 3: Manual timing blocks
echo "Or add timing blocks around suspicious sections in ~/.zshrc:"
cat << 'EOF'
  # Start timer
  timer=$(($(date +%s%N)/1000000))

  # Your slow code here (e.g., oh-my-zsh, nvm, etc.)
  source ~/.oh-my-zsh/oh-my-zsh.sh

  # End timer
  now=$(($(date +%s%N)/1000000))
  elapsed=$((now-timer))
  echo "Section took: ${elapsed}ms"
EOF
echo ""

# Check common culprits
echo "=== Common Bottlenecks to Check ==="
echo ""

if [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  echo "✓ Oh-My-Zsh detected"
  echo "  - Disable unused plugins in ~/.zshrc"
  echo "  - Consider switching to zinit or antigen for lazy loading"
fi

if command -v nvm &> /dev/null || [ -f ~/.nvm/nvm.sh ]; then
  echo "✓ NVM detected"
  echo "  - This is usually SLOW. Consider lazy loading:"
  echo '    export NVM_DIR="$HOME/.nvm"'
  echo '    alias nvm="unalias nvm; [ -s \"$NVM_DIR/nvm.sh\" ] && . \"$NVM_DIR/nvm.sh\"; nvm"'
fi

if command -v pyenv &> /dev/null; then
  echo "✓ pyenv detected"
  echo "  - Try: eval \"\$(pyenv init --path)\" (faster than full init)"
fi

if command -v rbenv &> /dev/null; then
  echo "✓ rbenv detected"
  echo "  - Usually fast, but check: rbenv init -"
fi

if [ -f /usr/local/bin/brew ] || [ -f /opt/homebrew/bin/brew ]; then
  echo "✓ Homebrew detected"
  echo "  - brew shellenv can be slow; cache it if needed"
fi

echo ""
echo "=== Security Software Check ==="
[ -d /Applications/Zscaler ] && echo "✗ Zscaler found - may scan scripts on execution"
pgrep -x "Microsoft Defender" &> /dev/null && echo "✗ MS Defender running - likely scanning files"

echo ""
echo "Run this script on both laptops to compare!"
