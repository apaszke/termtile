tileterm
=============

tileterm is a set of scripts, which set you free from your mouse and trackpad. Don't distract yourself and manage your terminal windows with a handful of commands.

![Gif demo](http://apaszke.github.io/termtile/assets/img/main_demo.gif)

Installation
-----------

```bash
git clone https://github.com/apaszke/termtile
cd termtile; ./install.sh
```

Aliases
-------

The `install.sh` script can set up several aliases for You:
* `ll` - fill left half of the screen
* `rr` - fill right half
* `up` - fill upper half
* `down` - fill lower half
* `ul` - fill upper-left quater
* `ur` - fill upper-right quater
* `dl` - fill lower-left quater
* `dr` - fill lower-right quater
* `big` - make the window bigger
* `cen` - center the window

You can always set up aliases for your own. For example:

```bash
alias ll='osascript ~/.mac_util/tileTerminal.scpt left'
#             ^                  ^                  ^
#         osascript       <path to script>        args
```

Included scripts
----------------

Currently there are three scripts:

**tileTerminal.applescript**

Distributes windows across 2 x 2 grid (affects only the last active one).
Accepted arguments:

<table border="0">
  <tr>
    <td>
      <img src="http://apaszke.github.io/termtile/assets/img/quaters.svg" alt="Quater arguments">
    </td>
    <td>
      <img src="http://apaszke.github.io/termtile/assets/img/vertical.svg" alt="Quater arguments">
    </td>
    <td>
      <img src="http://apaszke.github.io/termtile/assets/img/horizontal.svg" alt="Quater arguments">
    </td>
  </tr>
</table>

**centerTerminal.applescript**

Centers current window.

**bigTerminal.applescript**

Makes the window comfortably sized for tasks requiring more space (eg. vim).


Contributing
------------

0. If you have any suggestions feel free to file an issue.
0. Pull requests are very wellcome, but consider creating an issue first, so we can decide together if it's worth spending time on it :blush:
