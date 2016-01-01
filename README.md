# My Bash Scripts Collection
Some usefull scripts written in [Bash](https://www.gnu.org/software/bash/).

* [dcim-import](dcim-import) is a script to rename and move all photos *and* videos within a DCIM folder on your digital camera to "%Y-%m-%d/%Y-%m-%d %H-%M-%S" (using [`exiv2`](http://www.exiv2.org/) and [`mediainfo`](http://manpages.ubuntu.com/manpages/wily/en/man1/mediainfo.1.html)) and rotates photos according to EXIF information (using [`exiftran`](http://manpages.ubuntu.com/manpages/wily/man1/exiftran.1.html)). 
* [rmempty](rmempty) simply removes all empty directories below the working directory unsing [`find`](http://manpages.ubuntu.com/manpages/wily/en/man1/find.1.html)