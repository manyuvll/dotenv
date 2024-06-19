if status is-interactive

    # Set fish greeting to an empty string
    set fish_greeting ""

    # Set terminal type to support 256 colors
    set -gx TERM xterm-256color

    # Theme settings
    set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always

    # Aliases
    alias ls "ls -p -G"
    alias la "ls -A"
    alias ll "ls -l"
    alias lla "ll -A"
    alias g git
    command -qv nvim && alias vim nvim

    # Set default editor to nvim
    set -gx EDITOR nvim

    # Add custom paths to PATH
    set -gx PATH bin $PATH
    set -gx PATH ~/bin $PATH
    set -gx PATH ~/.local/bin $PATH

    # Go configuration
    set -g GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH

    # Add brew path
    set -gx PATH /opt/homebrew/bin $PATH
    
    # If you come from bash you might have to change your $PATH.
    set -x PATH $HOME/bin /usr/local/bin $PATH

    set -x PATH $PATH /opt/nvim/

    set -gx XDG_CONFIG_HOME $HOME/.config


    # OS-specific configuration
    switch (uname)
        case Darwin
            source (dirname (status --current-filename))/config-osx.fish
        case Linux
            source (dirname (status --current-filename))/config-linux.fish
        case '*'
            source (dirname (status --current-filename))/config-windows.fish
    end

    # Local configuration
    set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
    if test -f $LOCAL_CONFIG
        source $LOCAL_CONFIG
    end
end
