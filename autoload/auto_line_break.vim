let s:sep = fnamemodify('.', ':p')[-1:]

function! auto_line_break#array() abort
  let line = getline('.')
  let start_line_number = line('.')
  let next_line = getline('.')
  let has_hash_string = stridx(line, '[')
  let current_line_length = len(getline('.'))
  let last_array_line_number = 0

  if stridx(line, '[') == -1
    return
  endif

  if line[current_line_length - 1] =~# '['
    execute "normal \<cr>"
  else
    execute "normal 0f[a\<cr>\<esc>"
  endif

  let is_last_array = 1

  while is_last_array
    call s:lineBreakWhenIncludedComma()

    if stridx(getline('.'), ']') != -1
      let is_last_array = 0
      let last_array_line_number = line(".")
    endif

    call s:lineBreakWhenLastArray()
  endwhile

  " not working
  execute "normal!" start_line_number . "G"
  execute "normal! v" . last_array_line_number . "G="
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

