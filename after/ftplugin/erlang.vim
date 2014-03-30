
let b:undo_ftplugin = exists("b:undo_ftplugin") ? b:undo_ftplugin . "|" : ""

nnoremap <silent> <buffer> ]] :<C-U>call <SID>declaration('', 'n', v:count1)<CR>
nnoremap <silent> <buffer> [[ :<C-U>call <SID>declaration('b', 'n', v:count1)<CR>
nnoremap <silent> <buffer> ][ :<C-U>call <SID>declaration_end('', 'n', v:count1)<CR>
nnoremap <silent> <buffer> [] :<C-U>call <SID>declaration_end('b', 'n', v:count1)<CR>

xnoremap <silent> <buffer> ]] :<C-U>call <SID>declaration('', 'v', v:count1)<CR>
xnoremap <silent> <buffer> [[ :<C-U>call <SID>declaration('b', 'v', v:count1)<CR>
xnoremap <silent> <buffer> ][ :<C-U>call <SID>declaration_end('', 'v', v:count1)<CR>
xnoremap <silent> <buffer> [] :<C-U>call <SID>declaration_end('b', 'v', v:count1)<CR>
let b:undo_ftplugin .= " exe 'unmap <buffer> [[' |  exe 'unmap <buffer> ]]' |  exe 'unmap <buffer> []' |  exe 'unmap <buffer> ]['"

nnoremap <silent> <buffer> ]m :<C-U>call <SID>clause('', 'n', v:count1)<CR>
nnoremap <silent> <buffer> [m :<C-U>call <SID>clause('b', 'n', v:count1)<CR>
nnoremap <silent> <buffer> ]M :<C-U>call <SID>clause_end('', 'n', v:count1)<CR>
nnoremap <silent> <buffer> [M :<C-U>call <SID>clause_end('b', 'n', v:count1)<CR>

xnoremap <silent> <buffer> ]m :<C-U>call <SID>clause('', 'v', v:count1)<CR>
xnoremap <silent> <buffer> [m :<C-U>call <SID>clause('b', 'v', v:count1)<CR>
xnoremap <silent> <buffer> ]M :<C-U>call <SID>clause_end('', 'v', v:count1)<CR>
xnoremap <silent> <buffer> [M :<C-U>call <SID>clause_end('b', 'v', v:count1)<CR>
let b:undo_ftplugin .= " | exe 'unmap <buffer> [m' |  exe 'unmap <buffer> ]m' |  exe 'unmap <buffer> [M' |  exe 'unmap <buffer> ]M'"

if maparg('im','n') == ''
  xnoremap <silent> <buffer> im :<C-U>call <SID>inside('[m',']M')<CR>
  xnoremap <silent> <buffer> am :<C-U>call <SID>around('[m',']M')<CR>
  onoremap <silent> <buffer> im :<C-U>call <SID>inside('[m',']M')<CR>
  onoremap <silent> <buffer> am :<C-U>call <SID>around('[m',']M')<CR>
  let b:undo_ftplugin .= " | exe 'ounmap <buffer> im' |  exe 'ounmap <buffer> am' |  exe 'xunmap <buffer> im' |  exe 'xunmap <buffer> am'"
endif

if maparg('iM','n') == ''
  onoremap <silent> <buffer> iM :<C-U>call <SID>inside('[[','][')<CR>
  onoremap <silent> <buffer> aM :<C-U>call <SID>around('[[','][')<CR>
  xnoremap <silent> <buffer> iM :<C-U>call <SID>inside('[[','][')<CR>
  xnoremap <silent> <buffer> aM :<C-U>call <SID>around('[[','][')<CR>
  let b:undo_ftplugin .= " | exe 'ounmap <buffer> iM' |  exe 'ounmap <buffer> aM' |  exe 'xunmap <buffer> iM' |  exe 'xunmap <buffer> aM'"
endif

fun! s:declaration(flags, mode, count)
  call s:go_to('\(\.\|\%^\)\_s*\(%.*\n\|\_s\)*\n*\_^\s*\zs[a-z][a-zA-Z_0-9]*(', a:flags, '', a:mode, a:count)
endfun

fun! s:declaration_end(flags, mode, count)
  call s:go_to('\.\w\@!', a:flags, 'erlangComment\|erlangString\|erlangSkippableAttributeDeclaration', a:mode, a:count)
endfun

fun! s:clause(flags, mode, count)
  call s:go_to('\(\.\|\%^\|\;\)\_s*\(%.*\n\|\_s\)*\n*\_^\s*\zs[a-z][a-zA-Z_0-9]*(', a:flags, '', a:mode, a:count)
endfun

fun! s:clause_end(flags, mode, count)
  call s:go_to('\(\.\w\@!\|[\;\.]\_s*\(%.*\n\|\_s\)*\n*\_^\s*[a-z][a-zA-Z_0-9]*(\)', a:flags, 'erlangComment\|erlangString\|erlangSkippableAttributeDeclaration', a:mode, a:count)
endfun

fun! s:go_to(pattern, flags, skip_syn, mode, count)
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif

  let match_count = a:count
  while match_count > 0
    let match_count -= 1

    let line = line('.') | let col  = col('.')
    let pos = search(a:pattern,'W'.a:flags)

    if len(a:skip_syn) > 0
      while pos != 0 && s:synname() =~# a:skip_syn
        let pos = search(a:pattern,'W'.a:flags)
      endwhile
    endif

    if pos == 0
      call cursor(line,col)
      return
    endif
  endwhile
endfunction

function! s:synname()
  return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")'), ' ')
endfunction

function! s:around(back, forward)
  execute 'norm h'
  execute 'norm ' . a:forward . a:back . 'V' . a:forward
endfunction

function! s:inside(back, forward)
  execute 'norm h'
  execute 'norm ' . a:forward . a:back
  call search('->\n\?\s*.', 'We')
  execute 'norm ' . 'v' . a:forward . 'h'
endfunction
