# Understanding the Sticky Bit

## This is a simple overview of how the sticky bit in Linux permissions.

## There are three phases to the scripts.
### 1. Create the test environment 
 - Create users Alice and Bob (Alice is the file owner, Bob will be the bad guy later)
 - Create Alice's files and directories
 - Create root files and directories as well
 - Set the permissions on the files

### 2. Have Bob take a whack at the files
 - Bob will first try to modify each of the files created. He will first try to write to each file
 - Bob will try to delete each file

### 3. Verify the results
 - record the output.

## As an example
### Note the sticky bit is ON for the /tmp directory
### 
```
[root@ip tmp]# ls -al
total 8
drwxrwxrwt.  2 root root   77 Nov 30 03:50 .
dr-xr-xr-x. 18 root root  236 Nov 29 19:49 ..
-rwxr-xr-x.  1 root root 1175 Nov 29 19:15 directory_and_file_creation.sh
-rwxrwxr-x.  1 bob  bob   480 Nov 30 03:49 try_to_edit_and_remove.sh
```

### As root create the files and directories
```
[root@ip tmp]# ./directory_and_file_creation.sh
```

### This shows the created alice and root directories
```
[root@ip tmp]# ls -al
total 8
drwxrwxrwt.  4 root  root   102 Nov 30 03:50 .
dr-xr-xr-x. 18 root  root   236 Nov 29 19:49 ..
drwxr-xr-x.  6 alice alice  124 Nov 30 03:50 alice
-rwxr-xr-x.  1 root  root  1175 Nov 29 19:15 directory_and_file_creation.sh
drwxr-xr-x.  6 root  root   124 Nov 30 03:50 root
-rwxrwxr-x.  1 bob   bob    480 Nov 30 03:49 try_to_edit_and_remove.sh
```

### This is a breakdown of the permissions created by directory_and_file_creation.sh
### Note they are all empty 

```
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
```

### Now lets switch to user bob
```
### [root@ip tmp]# su bob
```

### bob will run the try_to_edit_and_remove.sh script
```
### [bob@ip tmp]$ ls -al try_to_edit_and_remove.sh
-rwxrwxr-x. 1 bob bob 480 Nov 30 03:49 try_to_edit_and_remove.sh

### [bob@ip tmp]$ ./try_to_edit_and_remove.sh
```
### The errors are being directed to null, they are expected. If you want to see the errors swap out commands with the error redirects off.
### Note the files that were world writable (sticky bit or not) were written to. See the file size? 

```
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
```

### As the user bob, we will see if he can remove files, in /tmp 
### Remember the sticky bit on /tmp? We are checking for sub-directories being impacted.

```
[bob@ip tmp]$ rm -f root/*/* alice/*/*
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
```


## Note the files removed were all in the ww_dir_without_sticky directories.
