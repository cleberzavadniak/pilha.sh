# pilha.sh

A place to store your one-liner things.

![example.gif](https://github.com/cleberzavadniak/pilha.sh/blob/main/example.gif?raw=true "Usage example")

## Requirements

If using the `ui`:

* dmenu
* xclip

## Install

Simply copy `pilha.sh` to any directory under your `PATH`.

(I have my own `~/bin`, so I clone this repository somewhere else and
symlink the file there.)

## Usage

### Using dmenu

```bash
$ pilha.sh ui
```

This will call dmenu and display your content in a searchable way.

Selecting an entry copy it to the clipboard using `xclip`.


If you type an entry starting with `+ `, it will be added.

Internally, it's going to be saved in a file with the same name as the
first tag, so `+ utils pilha.sh` will save a `{your-pasted-content}
% utils pilha.sh` entry inside a `utils` file inside `BASEDIR` (usually
`~/.config/pilha`).

#### Usage suggestion

I have a keybinding to call `pilha.sh ui` and use the system clipboard as
input and output. If I want to save an URL from the Web browser, for
instance, I'd do:

* In the browser: ctrl+l, ctrl+c (to copy the URL)
* Windows key + Menu key (my keybinding to the program)
* `+ some tags I want to apply to the URL` and Enter

As said before, using the `+ ` already grabs the content from the
clipboard, so all you have to do is to apply your preferred tags.

### Command line

Subcommands:

#### add : add a new entry

```bash
$ pilha.sh add "the content here, like some URL" tag1 tag2 tag3
$ pilha.sh add "Something" tag-four
```

#### get : search for an entry


```bash
$ pilha.sh get tag1
the content here, like some URL % tag1 tag2 tag3
```

#### Get : search for an entry, case sensitive


```bash
$ pilha.sh Get Something
Something % tag-four
```

#### bget : "blind get": do not show any tags in the output

```bash
$ pilha.sh bget content
the content here, like some URL
```
