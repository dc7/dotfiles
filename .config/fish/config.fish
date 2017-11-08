# disable welcome message
set --erase fish_greeting

# use dollar sign as prompt
function fish_prompt
    echo "\$ "
    end

# enable rvm
rvm default
