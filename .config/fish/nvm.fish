function fish_greeting
    bass source $NVM_DIR/nvm.sh
end

function nvm
    # This function acts as a bridge to run nvm commands from Fish using bass.
    # It sources nvm.sh in a Bash subshell and then executes the nvm command with arguments.
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
