# erlang-motions.vim

Motions and text objects for erlang!

### Motions

* `]]` go to next function declaration

* `[[` previous function declaration

* `]m` next function clause

* `[m` previous function clause

* And more: `]M`, `[M`, `][`, `[]` go to **end** of next/previous clause/declaration.

  Each motion can be prefixed with a count.

### Text objects

* `im`, `am` inside/around function clause

* `iM`, `aM` inside/around function declaration

### Example

* `vim` "visual inner method (function clause)":

![screen shot 2014-03-21 at 11 05 25 pm copy](https://f.cloud.github.com/assets/1532071/2492908/bb87be1a-b265-11e3-9e5d-693d0ad821ae.png)

* `vaM` "visual arround Method (function declaration)":

![screen shot 2014-03-21 at 11 04 53 pm](https://f.cloud.github.com/assets/1532071/2488015/0960aa86-b13d-11e3-985c-6835eac0dc68.png)

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
