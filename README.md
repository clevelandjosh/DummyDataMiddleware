# Understanding the Sticky Bit

## This is a simple overview of how the sticky bit (and a little bit on SUID and GUID bits work too) in Linux permissions.

## There are three phases to the scripts.
### 1. Create the test environment 
 1a. Create users Alice and Bob (Alice is the file owner, Bob will be the bad guy later)
 1b. Create Alice's files and directories
 1c. Set the permissions on the files

### 2. Have Bob take a whack at the files
 2a. Bob will first try to modify each of the files created. He will first try to write to each file
 2b. Bob will try to delete each file

### 3. Verify the results
 3a. record the output.

## As an example
### [root@ip tmp]# ls -al
total 8
drwxrwxrwt.  2 root root   77 Nov 30 03:50 .
dr-xr-xr-x. 18 root root  236 Nov 29 19:49 ..
-rwxr-xr-x.  1 root root 1175 Nov 29 19:15 directory_and_file_creation.sh
-rwxrwxr-x.  1 bob  bob   480 Nov 30 03:49 try_to_edit_and_remove.sh
### [root@ip tmp]# ./directory_and_file_creation.sh
### [root@ip tmp]# ls -al
total 8
drwxrwxrwt.  4 root  root   102 Nov 30 03:50 .
dr-xr-xr-x. 18 root  root   236 Nov 29 19:49 ..
drwxr-xr-x.  6 alice alice  124 Nov 30 03:50 alice
-rwxr-xr-x.  1 root  root  1175 Nov 29 19:15 directory_and_file_creation.sh
drwxr-xr-x.  6 root  root   124 Nov 30 03:50 root
-rwxrwxr-x.  1 bob   bob    480 Nov 30 03:49 try_to_edit_and_remove.sh

## This is a breakdown of the permissions created by directory_and_file_creation.sh

### [root@ip tmp]# ls -al alice/*/*
-rwxr-xr-x. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 0 Nov 30 03:50 alice/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 0 Nov 30 03:50 alice/ww_dir_with_sticky/ww_file_with_sticky
### [root@ip tmp]# ls -al root/*/*
-rwxr-xr-x. 1 root root 0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root 0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 0 Nov 30 03:50 root/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 0 Nov 30 03:50 root/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root 0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root 0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 0 Nov 30 03:50 root/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 0 Nov 30 03:50 root/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root 0 Nov 30 03:50 root/ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root 0 Nov 30 03:50 root/ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 0 Nov 30 03:50 root/ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 0 Nov 30 03:50 root/ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root 0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root 0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 0 Nov 30 03:50 root/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 0 Nov 30 03:50 root/ww_dir_with_sticky/ww_file_with_sticky

### [root@ip tmp]# su bob
### [bob@ip tmp]$ ls -al try_to_edit_and_remove.sh
-rwxrwxr-x. 1 bob bob 480 Nov 30 03:49 try_to_edit_and_remove.sh
### [bob@ip tmp]$ ./try_to_edit_and_remove.sh
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 12: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_without_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_without_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘not_ww_file_with_sticky’: Operation not permitted
./try_to_edit_and_remove.sh: line 32: not_ww_file_with_sticky: Permission denied
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_without_sticky’: Operation not permitted
rm: cannot remove ‘*.new’: No such file or directory
chmod: changing permissions of ‘ww_file_with_sticky’: Operation not permitted
### [bob@ip tmp]$ ls -al alice/*/*
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/ww_dir_with_sticky/ww_file_with_sticky
### [bob@ip tmp]$ ls -al root/*/*
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/ww_dir_with_sticky/ww_file_with_sticky
### [bob@ip tmp]$


[bob@ip tmp]$ ls -al root/*/*
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 root/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 root/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 root/ww_dir_with_sticky/ww_file_with_sticky
[bob@ip tmp]$ ls -al alice/*/*
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_without_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/not_ww_dir_without_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/not_ww_dir_without_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/not_ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/not_ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/not_ww_dir_with_sticky/ww_file_with_sticky
-rwxr-xr-x. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_without_sticky
-rwxr-xr-t. 1 alice alice   0 Nov 30 03:50 alice/ww_dir_with_sticky/not_ww_file_with_sticky
-rwxrwxrwx. 1 alice alice 166 Nov 30 03:57 alice/ww_dir_with_sticky/ww_file_without_sticky
-rwxrwxrwt. 1 alice alice 154 Nov 30 03:57 alice/ww_dir_with_sticky/ww_file_with_sticky
[bob@ip tmp]$
 ls -al root/*
root/not_ww_dir_without_sticky:
total 8
drwxr-xr-x. 2 root root 128 Nov 30 03:50 .
drwxr-xr-x. 6 root root 124 Nov 30 03:50 ..
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 ww_file_with_sticky

root/not_ww_dir_with_sticky:
total 8
drwxr-xr-t. 2 root root 128 Nov 30 03:50 .
drwxr-xr-x. 6 root root 124 Nov 30 03:50 ..
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 ww_file_with_sticky

root/ww_dir_without_sticky:
total 0
drwxrwxrwx. 2 root root   6 Nov 30 04:01 .
drwxr-xr-x. 6 root root 124 Nov 30 03:50 ..

root/ww_dir_with_sticky:
total 8
drwxrwxrwt. 2 root root 128 Nov 30 03:50 .
drwxr-xr-x. 6 root root 124 Nov 30 03:50 ..
-rwxr-xr-x. 1 root root   0 Nov 30 03:50 not_ww_file_without_sticky
-rwxr-xr-t. 1 root root   0 Nov 30 03:50 not_ww_file_with_sticky
-rwxrwxrwx. 1 root root 119 Nov 30 03:57 ww_file_without_sticky
-rwxrwxrwt. 1 root root 110 Nov 30 03:57 ww_file_with_sticky

## Note the files removed were all in the ww_dir_without_sticky directories.
