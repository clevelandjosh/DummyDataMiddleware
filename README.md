# Understanding the Sticky Bit

This is a simple overview of how the sticky bit (and a little bit on SUID and GUID bits work too) in Linux permissions.

There are three phases to the scripts.
1. Create the test environment 
a. Create users Alice and Bob (Alice is the file owner, Bob will be the bad guy later)
b. Create Alice's files and directories
c. Set the permissions on the files

2. Have Bob take a whack at the files
a. Bob will first try to modify each of the files created. He will first try to write to each file
b. Bob will try to delete each file

3. Verify the results
a. record the output.

Extra Credit - 
SUID and GUID
Bob will execute a script that sets the SUID and GUID on the files and directories from the first phase. 
This script will run commands as Alice for Bob.
