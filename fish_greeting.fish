function fish_greeting
 
  set sym_os ⌘ 
  if command --search pacman >/dev/null 
    set pac ◷ (pacman -Qe|wc -l)
    set sym_os λ
  else if command --search dpkg >/dev/null 
    set pac ⎀(dpkg --list|wc -l)
    set sym_os ✪
  end
  
  set os (cat /etc/*release| grep -oP -m1 "NAME=\"\K([^\"]*)")

  set cpu ( grep -oP -m1 "model name.*:\K(.*)" /proc/cpuinfo | \
    sed 's/CPU//' | sed 's/ *@ /⚬/' | sed 's/0GHz//'  | sed 's/.*[\)]//g')


  set disk_use (df | grep '/$' | awk '{print $5}')

  set -xg ip ( host -W 1 -t txt o-o.myaddr.l.google.com 8.8.8.8 | grep -oP "client-subnet \K(\d{1,3}\.){3}\d{1,3}"  2>&1 )

  set top (ps -eo pcpu,comm --sort=-%cpu --no-headers  | head -1 | sed 's/\.[0-9]/%/' )

  echo -n (set_color $fish_color_user)$sym_os $os (set_color $fish_color_quote)$pac 
  echo -n (set_color $fish_color_param) ⚇$cpu(set_color $fish_color_end) $cpu_speed 
  echo -n (set_color $fish_color_quote) ⛬$top

  echo -n (set_color $fish_color_user) ❖ $disk_use
  echo -n (set_color $fish_color_redirection) ⊕ $ip
  echo ''
end

function fish_greeting_neo
        neofetch --stdout | cut -d':' -f2 | awk '{$1=$1};1' |  sed  's/^--*/λ/g' | tr  '\n' ' ';
end
