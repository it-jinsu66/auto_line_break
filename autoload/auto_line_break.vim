":source :call filename#funcname() 現在のパスからパスセパレータを取得しています。
" ここはそれほど重要ではないので、おまじないと考えておいてください。
" 詳しく知りたい方は`:h fnamemodify()`を参照してください。
let s:sep = fnamemodify('.', ':p')[-1:]
let jinsu = [1, 2, 3, 4, 5]

function! js_auto_format#array() abort
  let line = getline('.')
  let next_line = getline('.')
  let has_hash_string = stridx(line, '[')
  let current_line_length = len(getline('.'))

  if stridx(line, '[') == -1
    echom 'not array'
    return
  endif

  if !(getline('.')[current_line_length - 1]  =~# '[')
    execute "normal f[a\<cr>\<esc>"
  else
    execute "normal \<cr>"
  endif

  let start_index = 0
  let is_last_array = 1

  while is_last_array
    echom 'is_last_array'
    echom getline('.')
    " method1: split comma
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

    if stridx(getline('.'), ']') != -1
      let is_last_array = 0
    endif

    let current_line_length = len(getline('.'))
    if getline('.')[current_line_length - 1]  =~# ']'
      execute "normal f]i\<cr>\<esc>"
    else
      execute "normal \<cr>"
    endif

    let start_index += 1

    echom 'last is_last_array'
  endwhile

  echom line + 0
  echom line + start_index
  " not working
  execute "normal!" line + 0 . "Gv" . line + start_index . "="
endfunction
