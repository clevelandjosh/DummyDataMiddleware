#!/bin/bash

su bob
cd /tmp/alice
for i in $(ls -d *); 
  do 
  cd $i 
    for j in `ls`
      do cat > $j <<EOF
modified
EOF
   done 
cd .. 
done
