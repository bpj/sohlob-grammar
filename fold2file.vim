nnor <localleader>ff V"fyzo"tyyzc:call Fold2file(@t,@f)<cr>

fun! Fold2file(title,text)
    let title = substitute(tolower(a:title),'\W\+','-','g')
    let title = substitute(title,'^-\|-$','','g')
    let g:n = empty(g:n) ? 1 : g:n+1
    let chap = printf('%03d-%s.md', g:n, title)
    call writefile(split(a:text,"\n",1),chap)
endfun
