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

## Extra Credit - 
### 4. SUID and GUID
 4a. Bob will execute a script that sets the SUID and GUID on the files and directories from the first phase. 
This script will run commands as Alice for Bob.
