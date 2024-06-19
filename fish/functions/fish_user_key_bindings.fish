function fish_user_key_bindings
    # fzf: Bind Ctrl-f to invoke the fzf_change_directory function
    bind \cf fzf_change_directory

    # vim-like: Bind Ctrl-l to move forward one character (like pressing the right arrow key in Vim)
    bind \cl forward-char

    # Prevent iTerm2 from closing when typing Ctrl-D (EOF): Bind Ctrl-d to delete the character under the cursor
    bind \cd delete-char
end