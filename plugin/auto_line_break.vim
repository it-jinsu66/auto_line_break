" すでにスクリプトをロードした場合は終了
if exists('g:loaded_auto_line_break')
  finish
endif
let g:loaded_auto_line_break = 1

command! LB call auto_line_break#array()
