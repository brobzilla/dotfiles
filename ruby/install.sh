#!/bin/sh
if [ "$(uname)" == "Darwin" ]; then
	do_mac
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
fi

do_mac() {
	if test ! $(which rbenv)
	then
	  echo "  Installing rbenv for you."
	  brew install rbenv > /tmp/rbenv-install.log
	fi
	
	if test ! $(which ruby-build)
	then
	  echo "  Installing ruby-build for you."
	  brew install ruby-build > /tmp/ruby-build-install.log
	fi
}
