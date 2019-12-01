# shellcheck shell=bash
FOUND_PYENV=0
pyenvdirs=("$HOME/.pyenv" "$HOME/.local/pyenv" "/usr/local/opt/pyenv" "/usr/local/pyenv" "/opt/pyenv")

for pyenvdir in "${pyenvdirs[@]}"; do
    if [ -d "$pyenvdir/bin" ]  && [ $FOUND_PYENV -eq 0 ]; then
        FOUND_PYENV=1
        if [[ $PYENV_ROOT = '' ]]; then
            PYENV_ROOT=$pyenvdir
        fi
        export PYENV_ROOT
        export PATH=${pyenvdir}/bin:$PATH
        eval "$(pyenv init --no-rehash -)"

        function current_py() {
            pyenv version-name
        }

        function pyenv_prompt_info() {
            current_py
        }
    fi
done
unset nodenvdir

if [ $FOUND_PYENV -eq 0 ]; then
    function pyenv_prompt_info() {
        echo "system: $(python --version)"
    }
fi
