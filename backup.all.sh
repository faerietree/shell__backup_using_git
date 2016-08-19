#!/bin/bash



disks=
{
	q	# daten
	,d	# bilder
	#,p	# not included because this network disk is used to store not only the
		#backups but also the bare shared repositories (accessible via SSH).
}



cd /


for d in $disks; do

	echo "" >> backup.all.log
	echo "Backing up disk: "$d >> backup.all.log

	echo "Current working directory: "$PWD
	echo "Changing working directory to: "$d
	cd $d

	

	# TODO Check if currently on branch "new" and abort if so?
	
	#What if modifications / new files are overridden? git checkout master
	git tag -D master_previous
	echo "Deleting previous master_previous: "#TODO turn label into commit hash $master_previous
	echo "Tagging master as master_previous to remember it to be able to reset to it."
	git tag master_previous
	
	
	#======= INFORMATION
	echo "Current HEAD ("$HEAD") ." >> backup.all.log
	#git branch new HEAD
	
	
	#======= ADD, BACKUP CHANGES
	echo "Committing modifications to branch 'new'..." >> backup.all.log
	git commit -a -m "Update files."
	
	echo "Pushing commit individually to keep transfer size low (backup often! Daily or" >> backup.all.log
	echo "after important changes if advanced!) ..." >> backup.all.log
	git push origin master
	
	
	#======= ADD, COMMIT NEW FILES
	echo "Committing new files ..."
	git add ./[^$]*  # TODO Test if this works properly!
	git commit -m "Add new files."

	echo "Pushing commit individually to keep transfer size low (backup often! Daily or" >> backup.all.log
	echo "after important changes if advanced!) ..." >> backup.all.log
	git push origin master

	echo "*done* Backing up disk: "$d >> backup.all.log

end




