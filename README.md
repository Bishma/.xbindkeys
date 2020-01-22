# Context aware mouse button scripting using xbindkeys

Prior to switching full time to linux I had an autohotkey script which would map mouse buttons 8 and 9 to be program specific and, in Firefox, the various next/prev hot keys on websites I frequent. This is an attempt to recreate that experiance in Ubunut 18.04 (Home PC) and 19.10 (Work PC) using [xbindkeys](https://linux.die.net/man/1/xbindkeys).

## Requirements

### xbindkeys

    sudo apt install xbindkeys

### Config file

I store everything in a hidden folder `.xbindkeys` in $HOME then symlink the `.xbindkeysrc` config file up a directory

    ln -s ~/.xbindkeys/.xbindkeysrc ~/.xbindkeysrc

Alternatively you could invoke xbindkeys using the config flag

    xbindkeys -fg ./.xbindkeys/.xbindkeysrc

### xdotool

[xdotool](http://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html) is a commandline X11 manipulation / automation tool. I use it to send keystrokes to and reading information from the active window in Gnome.

    sudo apt install xdotool