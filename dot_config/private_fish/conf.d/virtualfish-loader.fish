set -g VIRTUALFISH_VERSION 2.5.5
set -g VIRTUALFISH_PYTHON_EXEC /usr/local/bin/python3
source "$HOME"/.local/pipx/venvs/virtualfish/lib/python3.11/site-packages/virtualfish/virtual.fish
source "$HOME"/.local/pipx/venvs/virtualfish/lib/python3.11/site-packages/virtualfish/compat_aliases.fish
source "$HOME"/.local/pipx/venvs/virtualfish/lib/python3.11/site-packages/virtualfish/projects.fish
source "$HOME"/.local/pipx/venvs/virtualfish/lib/python3.11/site-packages/virtualfish/environment.fish
source "$HOME"/.local/pipx/venvs/virtualfish/lib/python3.11/site-packages/virtualfish/auto_activation.fish
emit virtualfish_did_setup_plugins
