let g:markerbar_additional =   '"'   " position in buffer when left
let g:markerbar_additional .=  '<>'  " start/end last selection
let g:markerbar_additional .=  '{}'  " start/end paragraph
let g:markerbar_additional .=  '()'  " start/end sentence
let g:markerbar_additional .=  '[]'  " start/end sentence
let g:markerbar_additional .=  '.'   " last change
let g:markerbar_additional .=  "^"   " insert mode stopped
let g:markerbar_additional .=  "'`"

function! KarlMarks()
    for c in map(split(g:markerbar_additional, '\zs'), "char2nr(v:val)") +
                \ range(char2nr('a'), char2nr('z')) +
                \ range(char2nr('A'), char2nr('Z')) +
                \ range(char2nr('0'), char2nr('9'))

        let p = getpos("'".nr2char(c))

        if (p[0] == 0 || p[0] == winbufnr(0)) && p[1] > 0
            exec "sign unplace ".c
            exec "sign define mark_".c." text=".nr2char(c)." texthl=SignColumn"
            exec "sign place ".c." name=mark_".c." line=".p[1]." buffer=".winbufnr(0)
        endif
    endfor
endfunction

autocmd CursorHold * call KarlMarks()

" important for distraction free reading while changing windows
" setlocal signcolumn=yes
