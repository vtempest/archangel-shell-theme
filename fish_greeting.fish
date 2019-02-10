function fish_greeting
 

  set sym_os ⌘ 

  if command --search pacman >/dev/null 
    set pac '◷'(pacman -Qe|wc -l)
    set sym_os λ
  else if command --search dpkg >/dev/null 
    set pac '⎀'(dpkg --list|wc -l)
    set sym_os ✪
  end
  set os (lsb_release -is | sed 's/"//g') 


  set cpuinfo  (lscpu | grep @ | awk -F ')' '{print $NF}'  | sed 's/CPU//' | sed 's/0GHz//'  | sed 's/ [ ]*//g')

  set cpu (echo $cpuinfo | cut -d'@' -f1) 
  set speed (grep "cpu MHz" /proc/cpuinfo | head -1  | \
    sed 's/..\..*//' | tail -c 3 | sed -e 's/^\(.\)/\1\./')

  set cpu_speed ⚇ (nproc)⚬$speed

  if test -n (set -q $ipinfo )
    set -U ipinfo  🖧 (dig +short myip.opendns.com @resolver1.opendns.com  2>&1 )
  end

  if echo $ipinfo | grep -q "not found"
    set -xg ipinfo ☠ Offline
  end


  set top ☕(ps -eo pcpu,comm --sort=-%cpu --no-headers  | head -1 | sed 's/\.[0-9]/%/' )
  set disk_use (df | grep '/$' | awk '{print $5}')

  


  echo -n (set_color $fish_color_user)$sym_os $os (set_color $fish_color_quote)$pac 
  echo -n (set_color $fish_color_param) ❖$cpu(set_color $fish_color_end) $cpu_speed 
  # echo -n (set_color normal) (set_color $fish_color_quote)$top

  echo -n (set_color $fish_color_user) 🖴 $disk_use
  echo -n (set_color $fish_color_redirection) $ipinfo
  echo ''
end

