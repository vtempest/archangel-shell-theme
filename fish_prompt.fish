# name: L
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l arrow "λ"
  set -l cwd $blue(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set git_info $green(_git_branch_name)
    set git_info ":$git_info"

    if [ (_is_git_dirty) ]
      set -l dirty "*"
      set git_info "$git_info$dirty"
    end
  end
  
  if test -n (set -q $SSH_TTY )
    echo -n -s (set_color green) $ip
  end
  
  echo -n -s  (set_color normal) $cwd $git_info $normal ' ' $arrow ' '
end
