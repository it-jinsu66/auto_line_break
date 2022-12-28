let jinsu = [1, 2, 3]

function! auto_line_break#array() abort
  let line = getline('.')

  if stridx(line, '[') == -1
    return
  endif

  let start_line_number = line('.')
  let last_array_line_number = 0

  call s:lineBreakWhenFirstObject('[', line)

  let is_last_array = 1
  while is_last_array
    call s:lineBreakWhenIncludedComma()

    if stridx(getline('.'), ']') != -1
      let is_last_array = 0
      let last_array_line_number = line(".")
    endif

    call s:lineBreakWhenLastArray()
  endwhile

  call s:autoFormat(start_line_number, last_array_line_number)
endfunction

function! s:lineBreakWhenIncludedComma() abort
  let is_last_comma = 1

  while is_last_comma
    let current_line_length = len(getline('.'))

    if getline('.')[current_line_length - 1]  =~# ','
      execute "normal \<cr>"
    else
      execute "normal f,a\<cr>\<esc>"
    endif

    if stridx(getline('.'), ',') == -1
      let is_last_comma = 0
    endif
  endwhile
endfunction

function! s:lineBreakWhenLastArray() abort
  let current_line_length = len(getline('.'))

  if getline('.')[current_line_length - 1]  =~# ']'
    execute "normal f]i\<cr>\<esc>"
  else
    execute "normal \<cr>"
  endif
endfunction

function! s:autoFormat(start_line_number, last_array_line_number) abort
  execute "normal!" . a:start_line_number . "G"
  execute "normal! v" . a:last_array_line_number . "G="
endfunction

function! s:lineBreakWhenFirstObject(type_string, current_line) abort
  for bracket in ['[', '{']
    if a:current_line[len(a:current_line) - 1] =~# bracket
      execute "normal \<cr>"
    else
      execute "normal 0f" . bracket . "a\<cr>\<esc>"
    endif
  endfor
endfunction
