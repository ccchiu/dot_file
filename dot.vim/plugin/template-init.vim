" Template helpers
" vim:sw=2:et:
" ------------------------------------------------------
" Author: Cornelius
" Email:  cornelius.howl@gmail.com
" Web: http://oulixe.us/
" ------------------------------------------------------
" to setup template:
"   au BufNewFile *.t   :call InitTemplate('template.t')
"   au BufNewFile *.pl  :call InitTemplate('')
"
" to setup placeholder:
"   {{!perl:  print q|test|}}
"   {{!vim: expand('%')}}
"   {{:normal ggyp}}
"   {{place holder}}

let g:skeleton_path = expand('~/.vim/skeleton')
let g:skeleton_placeholder_key = '<Tab>'

fu! InitTemplate(tplname)
  let p = g:skeleton_path . '/' . a:tplname
  if filereadable( p ) 
    exec '0r ' .  p
    " bind placeholder function
    exec 'imap <silent> <buffer> ' . g:skeleton_placeholder_key . ' <ESC>:call NextPlaceHolder()<CR>'
    call NextPlaceHolder()
  else
    echomsg 'Can not found template'
  endif
endf

fu! FinalizeTemplate()
  unmap! <silent> <buffer> <Tab>
endf

fu! ListTemplate()
    echo system('find ' . g:skeleton_path . '' )
endf

fu! SelectTemplate()
    call ListTemplate()
    let template_name = input("Template Name:")
    if strlen( template_name ) 
        call InitTemplate( template_name )
    endif
endf
com! SelectTemplate :call SelectTemplate()

fu! NextPlaceHolder()
  call cursor( 1 , 1 )
  let pos = searchpos('{{.\{-}}}', 'p')
  if pos[0] > 0
    let [next,result] = EvalBraceInside( pos[0] , pos[1]+3)

    "cleanup {{ package }}
    exec 's!{{.\{-}}}!' . result . '!'
    if next == 1
      call NextPlaceHolder()
      return
    else
      call cursor( pos[0] , pos[1]  )
      startinsert
    endif
  else 
    call FinalizeTemplate()
  endif
endf

fu! GetBraceInside(x,y)
endf

fu! EvalBraceInside(x,y)
  " save pos
  let ret = ''
  let next = 0
  let prevpos = getpos('.')
  call cursor(a:x,a:y)
  normal vi}"sy
  let tx = getreg('s')
  if tx =~ '^!vim:'
    let tx = strpart(tx,5)
    let ret = eval(tx)
    let next = 1
  elseif tx =~ '^:'
    let tx = strpart(tx,1)
    let next = 1
    exec tx
  elseif tx =~ '^!perl:'
    let tx = strpart(tx,6)
    let ret = system('perl -e "' . tx . '" ')
  elseif tx =~ '^!ruby:'
    let tx = strpart(tx,5)
    let ret = system('ruby -e "' . tx . '" ')
  endif
  call setpos('.',prevpos )
  return [next,ret]
endf

" built-in functions for perl
" ---------------------------
fu! PerlPackageName()
  let pkgname = substitute( matchstr( expand("%") , '^lib/\zs.*\ze\.pm' ), '/', '::', 'g')
  return pkgname
endf

fu! SetupTemplateForType(wild,tplname)
  exec 'au BufNewFile ' . a:wild . " :call InitTemplate('".a:tplname."')"
endf

let s:template_mapping = {}
let s:template_mapping['*.t'] = "template.t"
let s:template_mapping['*.pl'] = "template.pl"
let s:template_mapping['*.pm'] = 'template.pm'

for ptn in keys( s:template_mapping )
  call SetupTemplateForType( ptn , s:template_mapping[ ptn ] )
endfor
