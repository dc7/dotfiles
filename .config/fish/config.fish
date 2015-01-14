# virtual environment settings
set -x WORKON_HOME $HOME/.virtualenvs
set -x PROJECT_HOME $HOME/revup/work
set -x PIP_RESPECT_VIRTUALENV true
set -x PIP_VIRTUALENV_BASE $WORKON_HOME

# misc environment variables
set -x desktop $HOME/Desktop
set -x docs $HOME/Documents
set -gx PATH $PATH $HOME/scripts
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/lib

# virtualenvwrapper emulation
function workon
    source $HOME/.virtualenvs/$argv/bin/activate.fish
    cd $HOME/revup/work/$argv
    end

# disable welcome message
set --erase fish_greeting

# use dollar sign as prompt
function fish_prompt
    echo "\$ "
    end

# use frontend environment by default
workon "frontend"
