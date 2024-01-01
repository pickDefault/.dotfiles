" bidirectional search with lightningspeed plugin
map s <Plug>Lightspeed_omni_s

" ; and , repeat searches for both 's' and 'f'/'t' searches (lightningspeed plugin)
let g:lightspeed_last_motion = ''
augroup lightspeed_last_motion
    autocmd!
    autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
    autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
augroup END
map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"

" make Shift+r delete letter under cursor and enter insert mode
noremap R s
" If search is bidirectional, we should revert to S native behaviour
noremap S S

" Substitute ^ and _ behaviour
noremap ^ _
noremap _ ^