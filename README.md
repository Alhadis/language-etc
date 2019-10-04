Highlighting for dot-files, `/etc/*` configs, and program-specific manifests
============================================================================

Syntax highlighting for various configs and file-formats too specific to warrant
their own repositories. Basically, a junk-drawer for any language grammar I felt
an itch to write, or those I've written for [GitHub Linguist][1].

Feel free to install this in Atom, but don't complain about the mess it'll make
of your [`grammar-selector`](https://github.com/atom/grammar-selector)'s menu…


Supported formats
-----------------
* [x] [`.gitignore`](https://git-scm.com/docs/gitignore)
* [x] [`.gitattributes`](https://git-scm.com/docs/gitattributes)
* [x] [`.gitconfig`](https://git-scm.com/docs/git-config)
* [x] [`.hgignore`](https://www.mercurial-scm.org/wiki/.hgignore)
* [x] [`.nanorc`](https://www.nano-editor.org/dist/v2.1/nanorc.5.html)
* [ ] [`.curlrc`](https://curl.haxx.se/docs/manpage.html#-K)
* [x] [`.npmrc`](https://docs.npmjs.com/files/npmrc)
* [ ] [`.inputrc`](https://goo.gl/cCvKes)
* [ ] [`.wgetrc`](https://goo.gl/KRoNsn)
* [ ] [`.tmux.conf`](https://wiki.archlinux.org/index.php/tmux#Configuration)
* [x] [`dosbox.conf`](https://www.dosbox.com/wiki/Dosbox.conf)
* [x] [`mocha.opts`](https://mochajs.org/#mochaopts)
* [x] [`man.conf`](https://man.openbsd.org/man.conf.5)
* [x] [Coccinelle/SmPL](http://coccinelle.lip6.fr/docs/index.html)
* [x] [M4/Autotools](http://wolfram.schneider.org/bsd/7thEdManVol2/m4/m4.pdf)
* [x] [SSH configs](https://www.ssh.com/ssh/config/)
* [x] [SVG](https://developer.mozilla.org/en-US/docs/Web/SVG/Element)
* [ ] [Tags index](https://en.wikipedia.org/wiki/Ctags#Tags_file_formats)
* [ ] [Terminfo](http://invisible-island.net/ncurses/ncurses.faq.html#which_terminfo)


Installing in Atom
------------------
You'll need [Git][2], because I don't plan on ever publishing this to `atom.io`:

~~~shell
# On Unix-like platforms
cd ~/.atom/packages && git clone https://github.com/Alhadis/language-etc.git
~~~

~~~batchfile
:: For Windows users
cd %HOMEPATH%\.atom\packages
git clone "https://github.com/Alhadis/language-etc.git"
~~~


[Referenced Links]:_____________________________________________________________
[1]: https://github.com/github/linguist
[2]: https://git-scm.com/downloads
