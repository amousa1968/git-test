# Created by Ayman Mousa for migrating cc 2 github
# This script will be used with clearcase dynamic view with the following parameters
# Use Git Shell ./script_name.sh \\am255098_cc2git_dynamic_test
# You need to be at the top of all vobs to be able to view label properties using cleartool command 
# to verify the script setting the correct parameters you can invoke the clearcase command cleartool catcs -tag clearcase_view_name
#set -x
set -o xtrace

#!/bin/bash
#$1 workspace

echo -e  "getting ready to load clearcase dynamic view meta data for github migration now\n"

if [ $# -eq 0 ]
  then
      echo -e  "No arguments supplied"
          echo -e  "Please supply clearcase VOB & view name\n"
    exit 1
fi

# Script home directory'
   curr_dir='/c/Users/am255098/Documents/GitHub/cc2gitDynamic'

# File lists clearcase product, branch release #'s, user view and tag'sa long with "latest",'  
	filename='/c/Users/am255098/Documents/GitHub/cc2gitDynamic/prd_rel_tag.txt'
	
# Read file into single variable and parse' 	
	file=`cat $filename`

# Log and dump what was read to a temp file will be used to copy the passing arguments'
	tmpfile='/c/Users/am255098/Documents/GitHub/cc2gitDynamic/tmp_spec.txt'

# log_file="/Documents/GitHub/cc2gitDynamic/logfile.log"
log_file=$curr_dir/log_file.txt

exec > >(tee -a ${log_file} )
exec 2> >(tee -a ${log_file} >&2)


# the vob that is being migrated   
	vob_name=${1}
	view_name=${2}
		echo -e  "VOB = $1\n"
		echo -e  "VIEW = $2\n"

# This extra step pre-verify the path for clearcase 'workspace' script	
cd /v/access.vw/tdv/nt-i386/bin && 
	echo workspace $workspace &&  	
	ls -la workspace

# use exec [-cl] [-a name] [command [arguments]]'
#      If command is specified, it replaces the shell'

#	exec 4<$filename		# open "filename" for writing on file descriptor 4
#	exec < $filename		# output the file to a text file
#	exec 1>$log_file		# output to a logfile  stdout log replaced with file "logfile.txt
#	exec 2>1
#	exec 2<&1 

#		echo "logging to screen and a log file loging and reading"
#		echolog

# exec 5<&0               # copy read file descriptor 0 onto file descriptor 5	
# exec > $LOGFILE   		# stdout log replaced with file "logfile.txt".
# exec 3<$filename          # open "thisfile" for reading on file descriptor 3
# exec 4> $tmpfile          # open "thatfile" for writing on file descriptor 4
# exec 8<> tmpfile1         # open "tother" for reading and writing on fd 8
# exec 6>> other            # open "other" for appending on file descriptor 6
# exec 5<&0                 # copy read file descriptor 0 onto file descriptor 5
# exec 7>&4                 # copy write file descriptor 4 onto 7
# exec 3<&-                 # close the read file descriptor 3
# exec 6>&-                 # close the write file descriptor 6

echo "Starting with cleartool loading branch type setcs, setview, and start the view"
# The option /C means: Carries out the command  specified by the string and then terminates.

while read -r line 
	do {
		name="$line"
		echo "line read from a file - $name"
		
				cd /v/access.vw/tdv/nt-i386/bin &&
				ls -la workspace &&
				cmd &&
				dir &&
#				exec workspace
				workspace
				echo read temp file > $tmpfile &&
				echo -e " \n"
				$file
    echo $p
	echo -e  " \n"
	echo -e  "Current product config spec set to...\n"

			}
# Read each time config_spec set while loading files from clearcase				
		cleartool catcs -tag $view_name

# add these lines to the temp file
    echo "$filename" > $tmpfile				
#	cat $filename >> $tmpfile
#	echo $file > $tmpfile
#	cat $file >> $tmpfile

#############	if test -r $cspecs/$label; then
	if test -r $filename; then
#		### >>> if it is, then use that one
		cat $filename >> $tmpfile

	else
			### >>> otherwise use this
#		echo "element * $label" >>        $cfgspec_name
#		echo "element * /main/LATEST" >>        $cfgspec_name
		cat $file >>   $tmpfile	

	fi
		
		echo -e  " \n"
		echo -e  "-------------------------------\n"
		
	cd /v/$view_name/opnpde
		pwd; sleep 5
		echo -e  " \n"
		
		echo -e  "Current config spec set to...\n"
# Read each time config_spec set while loading files from clearcase				
#	cleartool catcs -tag $view_name	
	cleartool catcs
		echo -e  " \n"

cd /v/$view_name/opnpde

##### This section is all about GitHub ##########################################

# update cc2git copy of the files to GitHub import -----------------------------------------
	echo -e  "Copy files from CC view to GitHub repository opnpde. \n"

# the vob that is being migrated
cd /v/$view_name/opnpde

		vob_name=${1}
		view_name=${2}
		
		echo $@

		ls -la; sleep 10

###### This section for git  
# Add those steps to git process

# git add --all
# git commit -m "$branch_number use this example opnpde_14.10.2.x"
# git tag -f $label
# git push
# git branch $branch_number
# git push -u origin $branch_number


cd /v/$view_name/opnpde
    echo -e  "opnpde"
# update the git&cc copy of the files to import
echo -e  "Copy files from CC snap view to local git repo. \n"

#look for .lock file"
# while [ -f /v/$view_name/opnpde/.git/index.lock ]; do sleep 1; done
#	echo -e  " done.\n"
	
# push cc labels_tags to git remote repo (master)
echo -e  "Pushing to remote ...\n"

# Adding files to origin
git add --all
	echo -e  " done.\n"
	echo -e  "commit product and release\n"

# Add comments to the added files
git commit -m "$branch_number"
	echo -e  "done.\n"
	echo -e  "Issung git branch and tag \n"
	

git tag $label
	echo -e  " done.\n"
	echo -e  "using github program\n"

# Push to origin
git push
	echo -e  "Push to origin. \n"
	echo -e  " done.\n"  

git branch $branch_number
	echo -e  " done.\n"  

# Push the branch_number to origin
git push -u origin $branch_number
	echo -e  " done.\n"  
	echo -e  "import completed\n"

#	rm -rf $view_name
	echo -e "completed deleting view_name directory."
	ls -al		
	
done < $filename
#----------end script------------------