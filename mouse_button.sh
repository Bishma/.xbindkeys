#!/bin/bash

# This script is meant to fire when mouse button 8 is pressed in X11 (Gnome in
# my case). It uses xdotool to detect the active window and act accordingly.

ACTIVE_WINDOW=$(xdotool getwindowfocus getwindowname)

# Get the current active browser window's URL by reading my mozilla profile
function get_firefox_site() {
    if [[ $ACTIVE_WINDOW =~ " / Twitter" ]]; then
        SITE="twitter"
    elif [[ $ACTIVE_WINDOW =~ "All Personal Feeds" ]]; then
        SITE="feedly"
    else
        SITE="other"
    fi

    echo $SITE
}

MOUSE_BUTTON=$1

if [ -z "$MOUSE_BUTTON" ]; then
    # fallback
    MOUSE_BUTTON=8
fi

# Mouse button 8 or 9 pressed
if [ $MOUSE_BUTTON == 8 ] || [ $MOUSE_BUTTON == 9 ]; then
    # When in my browser
    if [[ $ACTIVE_WINDOW =~ "Mozilla Firefox" ]]; then
        # Get the url from my profile
        SITE=$( get_firefox_site )

        # Best we can, based on window title, detect the site we're using and send
        # the appropriate next/prev keystroke using xdotool.
        case $SITE in
            # twitter and feedly use j and k for back and forth
            twitter | feedly)
                if [ $MOUSE_BUTTON -eq 8 ]; then
                    xdotool key --clearmodifiers j
                else
                    xdotool key --clearmodifiers k
                fi
                ;;
            other)
                # Reddit uses n and p for next and previous when browsing in the lightbox.
                # When in the lightbox the post title becomes the window title/ I haven't
                # a way, because of this, to differentiate reddit from other sites.
                if [ $MOUSE_BUTTON -eq 8 ]; then
                    xdotool key --clearmodifiers n
                else
                    xdotool key --clearmodifiers p
                fi
                ;;
            *)
                # This won't currently do anything because I can't differentiate reddit from other sites
                if [ $MOUSE_BUTTON -eq 8 ]; then
                    xdotool key alt Left Arrow
                else
                    xdotool key alt Right Arrow
                fi
                ;;
        esac
    fi
# Alt + Mouse 4 or 5
elif [ $MOUSE_BUTTON == "alt4" ] || [ $MOUSE_BUTTON == "alt5" ]; then
        # Volume controls: 
        # volume up: alt + wheel up
        # volume down: alt + wheel down]
        if [ $MOUSE_BUTTON == "alt4" ]; then
            xdotool key XF86AudioRaiseVolume
        elif [ $MOUSE_BUTTON == "alt5" ]; then
            xdotool key XF86AudioLowerVolume
        fi
fi