#!/bin/bash

# This should be run as bob. Switch user to bob before execution.
cd /tmp/alice
for i in $(ls -d */);
  do
  cd $i
    for j in `ls`
      do
 /bin/cat <<EOM >$j
#!/bin/bash
touch $j.new &> /dev/null
chmod 777 $j.new &> /dev/null
chmod u+s $j.new &> /dev/null
EOM
   done

cd ..
done

cd /tmp/root
for i in $(ls -d */);
  do
  cd $i
    for j in `ls`
      do
 /bin/cat <<EOM >$j
#!/bin/bash
touch $j.new &> /dev/null
chmod 777 $j.new &> /dev/null
chmod u+s $j.new &> /dev/null
EOM
   done

cd ..
done
cd /tmp
ls -al /tmp/alice/*/* /tmp/root/*/* > initial_results.txt
exit
