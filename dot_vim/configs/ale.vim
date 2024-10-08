Plug 'dense-analysis/ale'

"Plugin Settings
let b:ale_warn_about_trailing_whitespace = 0  " Disable whitespace warnings
let b:ale_echo_msg_error_str = 'E'
let b:ale_echo_msg_warning_str = 'W'
let b:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let b:ale_completion_enabled = 1
let b:ale_linters={'python': ['pylint'],}
let b:ale_fixers={'python': ['isort', 'pylint'],}
let b:ale_fix_on_save = 1
let b:ale_python_pylint_use_global = 1
let b:ale_python_pylint_options = '--disable=E0401'

