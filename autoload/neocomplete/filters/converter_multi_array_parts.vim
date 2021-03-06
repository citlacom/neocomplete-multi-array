let s:save_cpo = &cpo
set cpo&vim

function! neocomplete#filters#converter_multi_array_parts#define() "{{{
  "echomsg string(Backtrace(expand('<sfile>')))
  return s:converter
endfunction"}}}

let s:converter = {
      \ 'name' : 'converter_multi_array_parts',
      \ 'description' : 'Form a multi dimensional array part suggestions as candidates.',
      \}

function! s:converter.filter(context) "{{{
  let candidates = []
  let pattern = '\[[''"][[:alnum:]_\-#\$]\+[''"]\]*\]$'
  "call prettyprint#echo(prettyprint#prettyprint(a:context), 1, 1)

  for candidate in a:context.candidates
    call add(candidates, candidate)
    let newcandidate = copy(candidate)
    while (newcandidate.word =~ pattern)
      let newcandidate.word = substitute(newcandidate.word, pattern, '', '')
      call add(candidates, copy(newcandidate))
    endwhile
  endfor

  return candidates
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
