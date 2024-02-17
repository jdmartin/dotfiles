Plug 'dense-analysis/ale'

"Plugin Settings
let g:ale_warn_about_trailing_whitespace = 0  " Disable whitespace warnings
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_completion_enabled = 1
let g:ale_linters={
\ 'python': ['pylint'],
\}
