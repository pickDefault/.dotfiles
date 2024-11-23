" make Shift+r delete letter under cursor and enter insert mode
" noremap R s
" If search is bidirectional, we should revert to S native behaviour
noremap S S

" Substitute ^ and _ behaviour
noremap ^ _
noremap _ ^

" Make Ctrl+F and Ctrl+B work right in insert mode
" imap <c-b> <left>
" imap <c-f> <right>
" imap <c-n> <down>
" imap <c-p> <up>

" Move through Vim tabs with Ctrl+H, Ctrl+L
" nnoremap <c-h> gT
" nnoremap <c-l> gt
" inoremap <c-h> <C-o>gT
" inoremap <c-l> <C-o>gt

" Make <count>j/k appear in jumplist, from https://vi.stackexchange.com/questions/7582/how-to-add-numbered-movement-to-the-jump-list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
