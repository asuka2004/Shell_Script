map <F2> :call TitleDet()<cr>
 function AddTitle()
     call append(0,"\#!/bin/bash")
     call append(1,"# **************************************************")
     call append(2,"# Description  :  ")
     call append(3,"# Build        : ".strftime("%Y-%m-%d %H:%M"))
     call append(4,"# Author       : Kung")
     call append(5,"# System       :    ")
     call append(6,"# Version      :     ")
     call append(7,"# *************************************************")
     call append(8,"export LANG=C")
     call append(9,"export PATH=$PATH")
     call append(10,"export PS4='+${LINENO} ') 
     call append(11,"[ -f /etc/init.d/functions] && . /etc/init.d/functions")
     call append(12,"script=/root/github")
     call append(13,"log=/root/log")
     echohl WarningMsg | echo "Successful in adding copyright." | echohl None
 endf
 
 function UpdateTitle()
      normal m'
      execute '/# Last modified/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
      normal ''
      normal mk
      execute '/# Filename/s@:.*$@\=":\t".expand("%:t")@'
      execute "noh"
      normal 'k
      echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
 endfunction
 
 function TitleDet()
     let n=1 
     while n < 10
         let line = getline(n)
         if line =~ '^\#\s*\S*Last\smodified\S*.*$'
             call UpdateTitle()
             return
         endif
         let n = n + 1
     endwhile
     call AddTitle()
 endfunction
