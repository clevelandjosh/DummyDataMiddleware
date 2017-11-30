#!/bin/bash

cd /tmp/alice
for i in $(ls -d */);
  do
  cd $i
    for j in `ls`
      do
rm *.new
chmod u+s $j
 /bin/cat <<EOM >$j
#!/bin/bash
touch $j.new
chmod 777 $j.new
chmod u+s $j.new
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
rm *.new
chmod u+s $j
 /bin/cat <<EOM >$j
#!/bin/bash
touch $j.new
chmod 777 $j.new
chmod u+s $j.new
EOM
   done

cd ..
done
cd /tmp
exit
