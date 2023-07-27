{ config
, lib
, pkgs
, ...
}: {
     programs.neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
      extraPackages = [];

      extraConfig = ''
          " designed for vim 8+
          if has("eval")                               " vim-tiny lacks 'eval'
            let skip_defaults_vim = 1
          endif

          set nocompatible

          "####################### Vi Compatible (~/.exrc) #######################

          " automatically indent new lines
          set autoindent

          " automatically write files when changing when multiple files open
          set autowrite

          " deactivate line numbers
          set number

          " turn col and row position on in bottom right
          set ruler " see ruf for formatting

          " show command and insert mode
          set showmode

          set tabstop=4

          "#######################################################################

          " disable visual bell (also disable in .inputrc)
          set t_vb=

          let mapleader=" "

          set softtabstop=2

          " mostly used with >> and <<
          set shiftwidth=2

          set smartindent

          set smarttab

          if v:version >= 800
            " stop vim from silently messing with files that it shouldn't
            set nofixendofline

            " better ascii friendly listchars
            set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

            " i hate automatic folding
            set foldmethod=manual
            set nofoldenable
          endif

          " mark trailing spaces as errors
          match IncSearch '\s\+$'

          " enough for line numbers + gutter within 80 standard
          set textwidth=72
          "set colorcolumn=73

          set termguicolors

          " replace tabs with spaces automatically
          set expandtab

          " disable relative line numbers, remove no to sample it
          set norelativenumber

          " makes ~ effectively invisible
          highlight NonText guifg=bg

          " turn on default spell checking
          set spell spelllang=en_us
          set spellsuggest=fast,20 "Don't show too much suggestion for spell check.
          set spellfile=~/.config/vim/spell/en.utf-8.add

          " disable spellcapcheck
          set spc=

          " more risky, but cleaner
          set nobackup
          set nowrap
          set noswapfile
          set nowritebackup

          set icon

          " center the cursor always on the screen
          "set scrolloff=999

          " highlight search hits
          set nohlsearch
          set incsearch
          set linebreak

          " avoid most of the 'Hit Enter ...' messages
          set shortmess=aoOtTI

          " prevents truncated yanks, deletes, etc.
          set viminfo='20,<1000,s1000


          if has("unnamedplus")
              set clipboard=unnamedplus
          else
              set clipboard=unnamed
          endif

          " not a fan of bracket matching or folding
          if has("eval") " vim-tiny detection
            let g:loaded_matchparen=1
          endif
          set noshowmatch

          " wrap around when searching
          set wrapscan

          " Just the formatoptions defaults, these are changed per filetype by
          " plugins. Most of the utility of all of this has been superceded by the use of
          " modern simplified pandoc for capturing knowledge source instead of
          " arbitrary raw text files.

          set fo-=t   " don't auto-wrap text using text width
          set fo+=c   " autowrap comments using textwidth with leader
          set fo-=r   " don't auto-insert comment leader on enter in insert
          set fo-=o   " don't auto-insert comment leader on o/O in normal
          set fo+=q   " allow formatting of comments with gq
          set fo-=w   " don't use trailing whitespace for paragraphs
          set fo-=a   " disable auto-formatting of paragraph changes
          set fo-=n   " don't recognized numbered lists
          set fo+=j   " delete comment prefix when joining
          set fo-=2   " don't use the indent of second paragraph line
          set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
          set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
          set fo+=l   " long lines not broken in insert mode
          set fo+=m   " multi-byte character line break support
          set fo+=M   " don't add space before or after multi-byte char
          set fo-=B   " don't add space between two multi-byte chars
          set fo+=1   " don't break a line after a one-letter word

          " requires PLATFORM env variable set (in ~/.bashrc)
          if $PLATFORM == 'mac'
            " required for mac delete to work
            set backspace=indent,eol,start
          endif

          " stop complaints about switching buffer with changes
          set hidden

          " command history
          set history=1000

          " here because plugins and stuff need it
          if has("syntax")
            syntax enable
          endif

          " faster scrolling
          set ttyfast

          " allow sensing the filetype
          filetype plugin on

          " high contrast for streaming, etc.
          set background=dark

          set cinoptions+=:0

          " Colorscheme to gruvbox
          colorscheme murphy


          " Edit/Reload vimrc configuration file
          nnoremap confe :e $HOME/.vimrc<CR>
          nnoremap confr :source $HOME/.vimrc<CR>

          set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

          "autocmd vimleavepre *.md !perl -p -i -e 's,(?<!\[)my `(\w+)` (package|module|repo|command|utility),[my `\1` \2](https://gitlab.com/rwxrob/\1),g' %

          " fill in empty markdown links with duck.com search
          " [some thing]() -> [some thing](https://duck.com/lite?kae=t&q=some thing)
          " s,/foo,/bar,g
          "autocmd vimleavepre *.md !perl -p -i -e 's,\[([^\]]+)\]\(\),[\1](https://duck.com/lite?kd=-1&kp=-1&q=\1),g' %

          autocmd BufWritePost *.md silent !toemoji %
          autocmd BufWritePost *.md silent !toduck %

          " fill in anything beginning with @ with a link to twitch to it
          "autocmd vimleavepre *.md !perl -p -i -e 's, @(\w+), [\\@\1](https://twitch.tv/\1),g' %

          " make Y consitent with D and C (yank til end)
          map Y y$

          " better command-line completion
          set wildmenu

          " disable search highlighting with <C-L> when refreshing screen
          nnoremap <C-L> :nohl<CR><C-L>

          " enable omni-completion
          set omnifunc=syntaxcomplete#Complete

          " force some files to be specific file type
          au bufnewfile,bufRead $SNIPPETS/md/* set ft=pandoc
          au bufnewfile,bufRead $SNIPPETS/sh/* set ft=sh
          au bufnewfile,bufRead $SNIPPETS/bash/* set ft=bash
          au bufnewfile,bufRead $SNIPPETS/go/* set ft=go
          au bufnewfile,bufRead $SNIPPETS/c/* set ft=c
          au bufnewfile,bufRead $SNIPPETS/html/* set ft=html
          au bufnewfile,bufRead $SNIPPETS/css/* set ft=css
          au bufnewfile,bufRead $SNIPPETS/js/* set ft=javascript
          au bufnewfile,bufRead $SNIPPETS/python/* set ft=python
          au bufnewfile,bufRead $SNIPPETS/perl/* set ft=perl
          au bufnewfile,bufRead user-data set ft=yaml
          au bufnewfile,bufRead meta-data set ft=yaml
          au bufnewfile,bufRead keg set ft=yaml
          au bufnewfile,bufRead *.bash* set ft=bash
          au bufnewfile,bufRead *.{peg,pegn} set ft=config
          au bufnewfile,bufRead *.gotmpl set ft=go
          au bufnewfile,bufRead *.profile set filetype=sh
          au bufnewfile,bufRead *.crontab set filetype=crontab
          au bufnewfile,bufRead *ssh/config set filetype=sshconfig
          au bufnewfile,bufRead .dockerignore set filetype=gitignore
          au bufnewfile,bufRead *gitconfig set filetype=gitconfig
          au bufnewfile,bufRead /tmp/psql.edit.* set syntax=sql
          au bufnewfile,bufRead *.go set spell spellcapcheck=0
          au bufnewfile,bufRead commands.yaml set spell

         " remove trailing whitespace
          autocmd BufWritePre * :%s/\s\+$//e

          "fix bork bash detection
          if has("eval")  " vim-tiny detection
          fun! s:DetectBash()
              if getline(1) == '#!/usr/bin/bash' || getline(1) == '#!/bin/bash'
                  set ft=bash
                  set shiftwidth=2
              endif
          endfun
          autocmd BufNewFile,BufRead * call s:DetectBash()
          endif

          " displays all the syntax rules for current position, useful
          " when writing vimscript syntax plugins
          if has("syntax")
          function! <SID>SynStack()
            if !exists("*synstack")
              return
            endif
              echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
          endfunc
          endif


          " start at last place you were editing
          au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
          au BufWritePost ~/.vimrc so ~/.vimrc

          " autocmd VimEnter * TSEnable highlight

          " functions keys
          map <F1> :set number!<CR> :set relativenumber!<CR>
          nmap <F2> :call <SID>SynStack()<CR>
          set pastetoggle=<F3>
          map <F4> :set list!<CR>
          map <F5> :set cursorline!<CR>
          map <F7> :set spell!<CR>
          map <F8> :source $HOME/.config/nvim/init.vim<CR> :echo "config reloaded"<CR>
          map <F12> :set fdm=indent<CR>

          nmap <leader>2 :set paste<CR>

          " disable arrow keys (vi muscle memory)
          noremap <Up> :echo "Umm, use k instead"<CR>
          noremap <Down> :echo "Umm, use j instead"<CR>
          noremap <Left> :echo "Umm, use h instead"<CR>
          noremap <Right> :echo "Umm, use l instead"<CR>
          "inoremap <up> <NOP>
          "inoremap <down> <NOP>
          "inoremap <left> <NOP>
          "inoremap <right> <NOP>

          " better use of arrow keys, number increment/decrement
          "nnoremap <up> <C-a>
          "nnoremap <down> <C-x>

          " Better page down and page up
          noremap <C-n> <C-d>
          noremap <C-p> <C-b>

          " Set TMUX window name to name of file
          " au fileopened * !tmux rename-window TESTING

          " read personal/private vim configuration (keep last to override)
          set rtp^=~/.vimpersonal
          set rtp^=~/.vimprivate
          set rtp^=~/.vimwork

          " Nerd tree plugin settings
          nnoremap ; :NERDTreeFocus<CR>
          nnoremap <C-t> :NERDTree<CR>
          nnoremap <C-n> :NERDTreeToggle<CR>
          nnoremap <C-f> :NERDTreeFind<CR>
          let NERDTreeShowHidden=1

          " Commenting blocks of code.
          augroup commenting_blocks_of_code
            autocmd!
            autocmd FileType sh,ruby,python,ansible  let b:comment_leader = '# '
            autocmd FileType conf,fstab,terraform    let b:comment_leader = '# '
            autocmd FileType c,cpp,java,scala        let b:comment_leader = '// '
            autocmd FileType tex                     let b:comment_leader = '% '
            autocmd FileType mail                    let b:comment_leader = '> '
            autocmd FileType vim                     let b:comment_leader = '" '
          augroup END
          noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
          noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
        '';
   };
}
