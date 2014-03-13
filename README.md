# erlang-motions.vim

Motions and text objects for erlang!

### Motions

* `]]` go to next function declaration

* `[[` previous function declaration

* `]m` next function clause

* `[m` previous function clause

* And more: `]M`, `[M`, `][`, `[]` go to next/previous clause/declaration **end**

### Text objects

* `im`, `am` inside/around function clause

* `iM`, `aM` inside/around function declaration

### Installation

- [Pathogen][1] `git clone https://github.com/edkolev/erlang-motions.vim ~/.vim/bundle/erlang-motions.vim`
- [Vundle][2] `Bundle 'edkolev/erlang-motions.vim'`
- [NeoBundle][3] `NeoBundle 'edkolev/erlang-motions.vim'`

### Inspired by

* [vim-ruby][4]

[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/gmarik/vundle
[3]: https://github.com/Shougo/neobundle.vim
[4]: https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt
[5]: http://www.erlang.org/doc/reference_manual/functions.html
