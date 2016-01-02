# My Bash Scripts Collection

Some usefull scripts written in [Bash](https://www.gnu.org/software/bash/).

## Little Helpers

* [dcim-import](dcim-import) is a script to rename and move all photos *and* videos within a DCIM folder on your digital camera to "%Y-%m-%d/%Y-%m-%d %H-%M-%S" (using [`exiv2`](http://www.exiv2.org/) and [`mediainfo`](http://manpages.ubuntu.com/manpages/wily/en/man1/mediainfo.1.html)) and rotates photos according to EXIF information (using [`exiftran`](http://manpages.ubuntu.com/manpages/wily/man1/exiftran.1.html)). 
* [rmempty](rmempty) simply removes all empty directories below the working directory unsing [`find`](http://manpages.ubuntu.com/manpages/wily/en/man1/find.1.html).
* [git-del-merged](git-del-merged) deletes all local branches already merged to master.
* [mvn-switch-settings](mvn-switch-settings) switches between alternative `settings_POSTFIX.xml` files in your `~/.m2` folder using symlinks.

## Config Stuff

* [bashrc](bashrc) is my heavily personalized `~/.bashrc` file. Please note that you will need to install [Bash-Preexec](https://github.com/rcaloras/bash-preexec) for it to work.
* [bash_aliases](bash_aliases) is my `~/.bash_aliases` containing a collection of aliases.
* [inputrc](inputrc) is my `~/.inputrc` enabeling type ahead seach using arrow keys. E.g. type "`git commit`" and press up and you will find the latest `git commit` command in your did execute.
