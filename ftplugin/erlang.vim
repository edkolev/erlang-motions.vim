
nnoremap <silent> <buffer> ]] :<C-U>call <SID>declaration('', 'n')<CR>
nnoremap <silent> <buffer> [[ :<C-U>call <SID>declaration('b', 'n')<CR>
nnoremap <silent> <buffer> ][ :<C-U>call <SID>declaration_end('', 'n')<CR>
nnoremap <silent> <buffer> [] :<C-U>call <SID>declaration_end('b', 'n')<CR>

xnoremap <silent> <buffer> ]] :<C-U>call <SID>declaration('', 'v')<CR>
xnoremap <silent> <buffer> [[ :<C-U>call <SID>declaration('b', 'v')<CR>
xnoremap <silent> <buffer> ][ :<C-U>call <SID>declaration_end('', 'v')<CR>
xnoremap <silent> <buffer> [] :<C-U>call <SID>declaration_end('b', 'v')<CR>

nnoremap <silent> <buffer> ]m :<C-U>call <SID>clause('', 'n')<CR>
nnoremap <silent> <buffer> [m :<C-U>call <SID>clause('b', 'n')<CR>
nnoremap <silent> <buffer> ]M :<C-U>call <SID>clause_end('', 'n')<CR>
nnoremap <silent> <buffer> [M :<C-U>call <SID>clause_end('b', 'n')<CR>

xnoremap <silent> <buffer> ]m :<C-U>call <SID>clause('', 'v')<CR>
xnoremap <silent> <buffer> [m :<C-U>call <SID>clause('b', 'v')<CR>
xnoremap <silent> <buffer> ]M :<C-U>call <SID>clause_end('', 'v')<CR>
xnoremap <silent> <buffer> [M :<C-U>call <SID>clause_end('b', 'v')<CR>

if maparg('im','n') == ''
  xnoremap <silent> <buffer> im :<C-U>call <SID>inside('[m',']M')<CR>
  xnoremap <silent> <buffer> am :<C-U>call <SID>around('[m',']M')<CR>
  onoremap <silent> <buffer> im :<C-U>call <SID>inside('[m',']M')<CR>
  onoremap <silent> <buffer> am :<C-U>call <SID>around('[m',']M')<CR>
endif

if maparg('iM','n') == ''
  onoremap <silent> <buffer> iM :<C-U>call <SID>wrap_im('[[','][')<CR>
  onoremap <silent> <buffer> aM :<C-U>call <SID>around('[[','][')<CR>
  xnoremap <silent> <buffer> iM :<C-U>call <SID>inside('[[','][')<CR>
  xnoremap <silent> <buffer> aM :<C-U>call <SID>around('[[','][')<CR>
endif

fun! s:declaration(flags, mode)
  call s:go_to('\(\.\|\%^\)\_s*\(%.*\n\|\_s\)*\n*\_^\s*\zs[a-z][a-zA-Z_0-9]*(', a:flags, '', a:mode)
endfun

fun! s:declaration_end(flags, mode)
  call s:go_to('\.\w\@!', a:flags, 'erlangComment\|erlangString\|erlangSkippableAttributeDeclaration', a:mode)
endfun

fun! s:clause(flags, mode)
  call s:go_to('\(\.\|\%^\|\;\)\_s*\(%.*\n\|\_s\)*\n*\_^\s*\zs[a-z][a-zA-Z_0-9]*(', a:flags, '', a:mode)
endfun

fun! s:clause_end(flags, mode)
  call s:go_to('\(\.\w\@!\|[\;\.]\_s*\(%.*\n\|\_s\)*\n*\_^\s*[a-z][a-zA-Z_0-9]*(\)', a:flags, 'erlangComment\|erlangString\|erlangSkippableAttributeDeclaration', a:mode)
endfun

fun! s:go_to(pattern, flags, skip_syn, mode)
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif

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
