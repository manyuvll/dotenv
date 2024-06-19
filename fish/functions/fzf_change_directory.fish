function fzf_change_directory
  begin
    # Output the configuration directory as an option
    echo $HOME/.config
    
    # Find directories within the `ghq` root up to 4 levels deep that contain a .git directory
    find (ghq root) -maxdepth 4 -type d -name .git | sed 's/\/\.git//'
    
    # List all directories in the current directory and prepend the current path
    ls -ad */|perl -pe "s#^#$PWD/#"|grep -v \.git
    
    # List all directories in $HOME/Developments/*/* and exclude .git directories
    ls -ad $HOME/Developments/*/* |grep -v \.git
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end


function _fzf_change_directory
  # Invoke fzf and escape any spaces or parentheses in the selected directory
  fzf | perl -pe 's/([ ()])/\\\\$1/g'|read foo
  
  # If a directory was selected
  if [ $foo ]
    # Change to the selected directory
    builtin cd $foo
    
    # Clear the command line
    commandline -r ''
    
    # Refresh the command line display
    commandline -f repaint
  else
    # If no directory was selected, just clear the command line
    commandline ''
  end
end
