#/home/Sameer9793/.config/startup.sh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting


function _tide_init_install --on-event _tide_init_install
    set -U tide_os_icon (_tide_detect_os)
    set -U VIRTUAL_ENV_DISABLE_PROMPT true
    set -U _tide_var_list tide_os_icon VIRTUAL_ENV_DISABLE_PROMPT

    source (functions --details _tide_sub_configure)
    _load_config lean
    _tide_finish
    set -a _tide_var_list (set --names | string match --regex "^tide.*")

    status is-interactive && switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
        case y ye yes ''
            tide configure
        case '*'
            printf '%s' \n 'Run ' (printf '%s' "tide configure" | fish_indent --ansi) ' to customize your prompt.' \n
    end
end

function _tide_init_update --on-event _tide_init_update
    # v5 introduced tide_prompt_min_cols. Only proceed if older than v5
    set --query tide_prompt_min_cols && return

    # Save old vars to tmp file
    set -l tmp (mktemp -t tide_old_config.XXXXX)
    tide bug-report --verbose >$tmp

    # Delete old vars
    set -e $_tide_var_list _tide_var_list $_tide_prompt_var

    # Print a warning
    set_color yellow
    echo "You have upgraded to version 5 of Tide."
    echo "Since there are breaking changes, your old configuraton has been saved in:"
    set_color normal
    echo $tmp

    sleep 5

    _tide_init_install
end

function _tide_init_uninstall --on-event _tide_init_uninstall
    set -e $_tide_var_list _tide_var_list $_tide_prompt_var
    functions --erase (functions --all | string match --entire --regex '^_tide_')
end

#Idan (shell promt)



#function _git_branch_name
#  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
#end

#function _is_git_dirty
#  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
#end

#function fish_prompt
  #set -l cyan (set_color -o cyan)
  #set -l yellow (set_color -o yellow)
  #set -l red (set_color -o red)
  #set -l blue (set_color -o blue)
  #set -l green (set_color -o green)
  #set -l normal (set_color normal)

  #set -l cwd $cyan(basename (prompt_pwd))

  # output the prompt, left to right

  # Add a newline before prompts
#  echo -e ""
#
  # Display [venvname] if in a virtualenv
  #if set -q VIRTUAL_ENV
   #   echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  #end

  # Display the current directory name
  #echo -n -s $cwd $normal


  # Show git branch and dirty state
  #if [ (_git_branch_name) ]
    #set -l git_branch '(' (_git_branch_name) ')'

    #if [ (_is_git_dirty) ]
     # set git_info $red $git_branch " ★ "
    #else
     # set git_info $green $git_branch
    #end
   # echo -n -s ' · ' $git_info $normal
  #end

  # Terminate with a nice prompt char
 # echo -n -s ' ⟩ ' $normal

#end


#idan right part

#function fish_right_prompt
  #set -l last_status $status
  #set -l cyan (set_color -o cyan)
# # set -l red (set_color -o red)
  #set -l normal (set_color normal)

  #echo -n -s $cyan (prompt_pwd)

  #if test $last_status -ne 0
   # set_color red
  #  printf ' %d' $last_status
 #   set_color normal
##  end
#end

#pfetch
