termtile
=============

termtile is a set of scripts, which set you free from your mouse and touchpad.
Don't distract yourself and manage all your terminal windows with a handful of commands.

All scripts are written in AppleScript, so they are unfortunately limited to OS X at the moment.

![Gif demo](http://apaszke.github.io/termtile/assets/img/main_demo.gif)

Installation
-----------

Just paste the following lines into the terminal:

```bash
git clone https://github.com/apaszke/termtile
cd termtile; ./install.sh
```

You can delete the cloned repository afterwards.

Aliases
-------

The `install.sh` script can set up several aliases for You:
* `ll` - fill left half of the screen
* `rr` - fill right half
* `up` - fill upper half
* `down` - fill lower half
* `ul` - fill upper-left quarter
* `ur` - fill upper-right quarter
* `dl` - fill lower-left quarter
* `dr` - fill lower-right quarter
* `big` - make the window bigger
* `cen` - center the window

You can always change them on your own. They always look like this:

```bash
alias ll='osascript ~/.termtile/tile.scpt left'
#             ^              ^              ^
#         osascript    path to script     args
```

They are also very convenient in conjunction with other commands e.g.

```bash
alias vim='big && cen && vim'
```

Included scripts
----------------

Currently there are three scripts:

**tile.applescript**

Distributes windows across 2 x 2 grid (affects only the last active window).
Accepted arguments:

<img src="http://apaszke.github.io/termtile/assets/img/tile_args.svg" alt="Quater arguments">

**center.applescript**

Centers the window.

**resize.applescript**

Makes the window comfortably sized for tasks requiring more space (eg. vim).
Default size is 1000x600, but it can be changed with the arguments (first is width, second is height).


Contributing
------------

0. If you have any suggestions feel free to file an issue.
0. Pull requests are very welcome, but consider creating an issue first,
so we can decide together if it's worth spending time on it :blush:

License
-------

Licensed under MIT license. Copyright (c) 2015 Adam Paszke
