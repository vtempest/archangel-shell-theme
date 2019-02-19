function fish_greeting
 

  set sym_os ⌘ 

  if command --search pacman >/dev/null 
    set pac '◷ '(pacman -Qe|wc -l)
    set sym_os λ
  else if command --search dpkg >/dev/null 
    set pac '⎀'(dpkg --list|wc -l)
    set sym_os ✪
  end
  set os (cat /etc/*release| grep NAME | head -1| cut -d= -f2 |  sed  's/\"//g') 


  set cpuinfo  (lscpu | grep @ | awk -F ')' '{print $NF}'  | sed 's/CPU//' | sed 's/0GHz//'  | sed 's/ [ ]*//g')

  set cpu (echo $cpuinfo | cut -d'@' -f1) 
  set speed (grep "cpu MHz" /proc/cpuinfo | head -1  | \
    sed 's/..\..*//' | tail -c 3 | sed -e 's/^\(.\)/\1\./')

  set cpu_speed ⚇ (nproc)⚬$speed

  if test -n (set -q $ipinfo )
    set -U ipinfo  (dig +short myip.opendns.com @resolver1.opendns.com  2>&1 )
  end

  if echo $ipinfo | grep -q "not found"
    set -xg ipinfo ☠ Offline  🖧
  end


  set top ☕(ps -eo pcpu,comm --sort=-%cpu --no-headers  | head -1 | sed 's/\.[0-9]/%/' )
  set disk_use (df | grep '/$' | awk '{print $5}')

  set -xg ip ( host -t txt o-o.myaddr.l.google.com 8.8.8.8 |
          grep -oP "client-subnet \K(\d{1,3}\.){3}\d{1,3}"  2>&1 )' '

  echo -n (set_color $fish_color_user)$sym_os $os (set_color $fish_color_quote)$pac 
  echo -n (set_color $fish_color_param) ❖$cpu(set_color $fish_color_end) $cpu_speed 
  # echo -n (set_color normal) (set_color $fish_color_quote)$top

  echo -n (set_color $fish_color_user) 🖴 $disk_use
  echo -n (set_color $fish_color_redirection)⊕ $ipinfo
  echo ''
end


function fish_greeting5
        neofetch --stdout | cut -d':' -f2 | awk '{$1=$1};1' |  sed  's/^--*/λ/g' | tr  '\n' ' ';
end



function fish_greeting2 
  # sed -i 's/.*Public IP/  info "Public IP/' ~/.config/neofetch/config.conf 

  set neo (neofetch --stdout )

  function sub    
      echo $neo | string match -r \
        '(?<='$argv':)[^:]*  (?=.*)' | string trim
  end

  set user (set_color $fish_color_user)♔ (whoami)
  set host (set_color $fish_color_user)🖵 (hostname)
  set cpu (set_color $fish_color_error)⊙ (echo $neo | string match -r \
        '(?<=CPU:)[^:]*  (?=.*)' | string trim  )


  set cpu (echo $cpu | string replace '00GHz' '' | \
      string replace 'Intel' '' | tr -d '('  | tr -d ')' | \
      string replace ' @ ' '⚬' | string trim ) 

  set os (set_color $fish_color_redirection)λ (echo $neo | string match -r \
        '(?<=OS:)[^:]*  (?=.*)' | string trim )
  set pac (set_color $fish_color_param)◷(echo $neo | string match -r \
        '(?<=Packages:)[^:]*  (?=.*)' | string trim  | cut -d'(' -f1 | string trim)
  set disk (set_color $fish_color_quote)🖴 (echo $neo | \
      string match -ar 'Disk[^:]*:[^:]*  ' | \
      string match -ar '(?<=\()[^)]*(?=\))'| \
      string join ' ' | string trim )
  set ip (set_color $fish_color_end)👁 (echo $neo | string match -r \
        '(?<=Public IP:)[^:]*  (?=.*)' | string trim )

  set top (set_color $fish_color_host)☕ \
      (ps -eo comm,\%cpu --sort=-%cpu --no-headers | \
      head -1 |  sed 's/\.[0-9]*/%/' | sed 's/ [ ]*/ /g'   )

  set top (set_color $fish_color_host)⛬ (ps -eo pcpu,comm --sort=-%cpu --no-headers  | head -1 | sed 's/\.[0-9]/%/' )
  
  
  # echo $host $cpu $os $pac $top $disk $ip (set_color $fish_color_normal)
  #   ⌚ ❖ ⚇ ⎀ ⛬ ♘  ✪ ♔ ⌘  λ ✪ 
  echo $cpu $os $pac  $ip (set_color $fish_color_normal)

end



function info

  set os (lsb_release -ds | sed 's/"//g') 
#(uname -r | cut -d'-' -f1 )

  if command --search pacman >/dev/null 
    set pac '◷ '(pacman -Qe|wc -l)
  else if command --search dpkg >/dev/null 
    set pac '⎀ '(dpkg --list|wc -l)
  end
  
  set top ( ps -eo pcpu,comm --sort=-%cpu --no-headers  | head -1 | sed 's/\.[0-9]/%/' )

  #set top (echo $top | cut -d' ' -f2)

  set cpuinfo  (lscpu | grep @ | awk -F ')' '{print $NF}'  | sed 's/CPU//' | sed 's/0GHz//'  | sed 's/ [ ]*//g')

  set cpu (echo $cpuinfo | cut -d'@' -f1) 
  set cpu_speed (echo $cpuinfo | cut -d'@' -f2)

  set disk_use (df | grep '/$' | awk '{print $5}')

  set -xg ipinfo '👁 '(dig +short myip.opendns.com @resolver1.opendns.com  2>&1 )

  if echo $ipinfo | grep -q "not found"
    set -xg ipinfo '👁 Offline'
  end

  set loc '⊕ '(curl -s ipinfo.io/city)

  set host (curl -s ipinfo.io/hostname | awk -F. '{print $(NF-1)}')

  #output  ⌚ ❖ ⚇ ⎀ ⛬ ♘  ✪
  if echo (whoami) | grep -q "root" 
    set sym ♔
  else
    set sym ♘
  end

  set sym_os ⌘ 
  if echo $os | grep -q "Arch"
    set sym_os λ
  else if echo $os | grep -q "Ubuntu"
    set sym_os ✪
  end

  echo (set_color $fish_color_end)$sym (whoami)(set_color $fish_color_param) (set_color $fish_color_host)🖵 (hostname) \
  (set_color $fish_color_user)$sym_os $os  (set_color $fish_color_redirection)$ipinfo (set_color $fish_color_user)$loc
  echo (set_color $fish_color_param)⚇ $cpu(set_color $fish_color_end) ⚇(nproc)⚬$cpu_speed (set_color $fish_color_quote)$pac (set_color $fish_color_end)🖴 $disk_use (set_color normal)  (set_color $fish_color_host)☕(echo $top)

end

