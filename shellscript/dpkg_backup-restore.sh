#!/bin/bash

dpkgupdate() {
# updates the list of packages in dpkg

    local tempName=""

    # setup temp filename for updating dpkg
    tempName="${HOME}/temp_avail"

    # make sure temp file doesnt exist as another file or directory
    while ( [[ -f "${tempName}" ]] || [[ -d "${tempName}" ]] )
    do
        tempName="${tempName}1"
    done

    # export info from 'apt' to temp file
    eval "sudo apt-cache dumpavail > \"${tempName}\""

    # read info from temp file into dpkg
    eval "sudo dpkg --merge-avail \"${tempName}\""

    # Remove temp file
    eval "sudo rm -r -f \"${tempName}\""

    # indicate operation was successful
    echo ""
    echo "The dpkg package list has been sucessfully updated!!!"
    echo ""

}

dpkgbackup() {
# backs up packages in a format that dkpg can later import

    # update package list
    eval "dpkgupdate"

    local saveFolder=""
    local dirCur=""
    local curTimeDir=""

    # determine directory to save in (see if there is an input)
    if (( $# > 0 )) && ( ! [[ -z "$1" ]] ); then
        saveFolder="${*}"
    else
        saveFolder="${HOME}/bin/DPKG_Package_Backups"
    fi

    # get current date time and use it as the target folder name
    # make folder name valid by replacing " " and ":" with "_" and ".". 'date' output has 5 spaces and 2 colons.
    curTimeDir="$(date)"
    curTimeDir="${curTimeDir// /_}"
    curTimeDir="${curTimeDir//:/.}"
    curTimeDir="$(echo "$curTimeDir" | sed -E s/'^(.*[a-zA-Z])__([0-9]_.*)$'/'\1_0\2'/)"

    saveFolder="${saveFolder%/}/${curTimeDir}"

    # create directory
    sudo mkdir -p "${saveFolder}"

    # make sub-directory
    sudo mkdir "${saveFolder}/DPKG_Restorable_Backup"
    sudo mkdir "${saveFolder}/DPKG_Restorable_Backup/sources.list"

    sudo chown -R ${USER}:${USER} ${saveFolder}/

    echo ""
    echo "Backup list of all installed packages will be generated in a form that allows automated restore using 'dpkg'"
    echo ""
    echo "The dpkg-restorable package-list will be saved in: ${saveFolder}/DPKG_Restorable_Backup"
    echo ""
    echo "This package list backup contains 3 items: "
    echo -e "    1) 'Package.list' ( file ) \n    2) 'sources.list' ( directory ) ( contents are named 'sources.list.*' ) \n    3) 'Repo.keys' ( file ) \n"
    echo ""
    echo "A 'simple list' of installed packages will also be generated and saved in ${saveFolder}"
    echo ""

    sleep 3

    # save package list for DPKG restore
    eval "sudo dpkg --get-selections > \"${saveFolder}/DPKG_Restorable_Backup/Package.list\""
    eval "sudo cp -R /etc/apt/sources.list* \"${saveFolder}/DPKG_Restorable_Backup/sources.list\""
    eval "sudo apt-key exportall > \"${saveFolder}/DPKG_Restorable_Backup/Repo.keys\""

    # save a 'simple formatted' list
    eval "sudo dpkg -l > \"${saveFolder}/installedPackages_simpleList.txt\""

    echo ""
    echo "Package backup list generated successfully!!!"
    echo "These have been stored in: ${saveFolder}"
    echo ""
    echo "To re-install packages automatically using dpkg, run: 'dpkgrestore'"
    echo "NOTE: 'dpkgrestore' seems to be working in 'dry runs' but the actual package restoration had never been attempted. Use at you own risk."

    # return to starting directory
    sudo cd "${dirCur}"

}

dpkgrestore() {
# Restores installed packages using the output of "dpkgbackup"
# requires 3 items be present: 'Package.list' , 'sources.list' , 'Repo.keys'

    echo ""
    echo "NOTE: 'dpkgrestore' seems to be working in 'dry runs' but the actual package restoration had never been attempted. Use at you own risk."
    echo ""
    sleep 3

    local saveFolder=""

    # determine directory to save in (see if there is an input)
    if (( $# > 0 )) && ( ! [[ -z "$1" ]] ); then

        if [[ -d "$1" ]]; then
                saveFolder="$1"

        elif [[ -d "$(pwd)/${1}" ]]; then
                saveFolder="$(pwd)/${1}"

        elif [[ -d "${HOME}/bin/${1}" ]]; then
                saveFolder="$HOME/bin/${1}"

        elif [[ -d "${HOME}/${1}" ]]; then
                saveFolder="${HOME}/${1}"
        fi

    else
        saveFolder="${HOME}/bin/DPKG_Package_Backups"
    fi

    # automatically search for backup save directory if no input + not in default location or if input was invalid
    if ! [[ -d "${saveFolder}" ]]; then

        local saveFolderTry=""

        echo "Save folder was not found based on input (if given) or standard save location (if no input given)."
        echo "The code will automatically search for a valid save located on this computers filesystem."
        echo ""
        echo "Searching current directory for possible valid locations..."
        saveFolderTry="$(ls -lrtd1 $(sudo find -O2 "./" -regex "^.*\/DPKG_Restorable_Backup\/?$") | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"

        if [[ -z "${saveFolderTry}" ]]; then
            echo "Not found. Searching User's main \$HOME directory for possible valid locations..."
            saveFolderTry="$(ls -lrtd1 $(sudo find -O2 "$HOME/" -regex "^.*\/DPKG_Restorable_Backup\/?$") | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"

            if [[ -z "${saveFolderTry}" ]]; then
                echo "Not found. Searching entire filesystem for possible valid locations..."
                saveFolderTry="$(ls -lrtd1 $(sudo find -O2 "/" -regex "^.*\/DPKG_Restorable_Backup\/?$") | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"

                if [[ -z "${saveFolderTry}" ]]; then
                    echo "The code was unable to locate a valid backup directory. Please manually input the directory to use. Code will exit with status 3."
                    exit 3
                fi
            fi
        fi

        echo ""
        echo "MATCH FOUND!!!"
        echo ""
        echo "The following backup directory used. To prevent this, manually stop the function from executing by pressing 'ctrl+c'."
        echo ""
        echo "BACKUP DIR: ${saveFolderTry}"
        echo ""

        local nn
        for nn in {1..5};
        do
            echo $((( 6 - $nn )))
            sleep 1
        done
        echo "TIMES UP!!! Code execution will continue using the backup directory specified above."
        echo ""

        saveFolder="${saveFolderTry}"

    fi

    saveFolder="${saveFolder%/}"

    echo "Packages will now be restored using dpkg and a dpkg-restorable package list"
    echo "The selected package list backup is located at: ${saveFolder}"

    # make sure we have the needed files directory doesnt exist
    if ( ! [[ -f "${saveFolder}/Repo.keys" ]] ) || ( ! [[ -f "${saveFolder}/Package.list" ]] ) || ( ! [[ -d "${saveFolder}/sources.list" ]] ); then

        local pathRepo=""
        local pathSources=""
        local pathPackages=""

        pathRepo="$(ls -lrtd1 "$(find -O2 "${saveFolder}/" -regex "^.*Repo\.keys$")" | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"
        pathSources="$(ls -lrtd1 "$(find -O2 "${saveFolder}/" -regex "^.*sources\.list$" | grep -v -E "sources\.list/sources\.list$")" | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"
        pathPackages="$(ls -lrtd1 "$(find -O2 "${saveFolder}/" -regex "^.*Package\.list$")" | tail -n 1 | sed -E s/'^.*[0-9] [0-9]{1,2}:[0-9]{2} (.*)$'/'\1'/)"

        if [[ -z "${pathRepo}" ]] ||  [[ -z "${pathSources}" ]] || [[ -z "${pathPackages}" ]] || ( ! [[ -f "${pathRepo}" ]] ) || ( ! [[ -d "${pathSources}" ]] ) || ( ! [[ -f "${pathPackages}" ]] ); then

            echo "The directory specified/found did not contain the requisite files. Please manually enter the correct directory and try running this code again. Code will exit with status 2."
            exit 2

        else

            echo ""
            echo "FINAL SELECTIONS:"
            echo ""
            echo "Keys: ${pathRepo}"
            echo "Sources: ${pathSources}"
            echo "Packages: ${pathPackages}"
            echo ""
            echo "Last chance to cancel the package restoration..."
            for nn in {1..10};
            do
                echo $((( 11 - $nn )))
                sleep 1
            done
            echo "TIMES UP!!! The DPKG package restoration process will now begin!"
            echo ""

            # Restore packages
            sudo apt-key add "$(find -O2 "${saveFolder}/" -regex "^.*Repo\.keys$")"
            sudo cp -R "$(find -O2 "${saveFolder}/" -regex "^.*sources\.list$" | grep -v -E "sources\.list/sources\.list$")" /etc/apt/
            sudo apt-get update
            sudo apt-get install dselect -y
            sudo dselect update
            sudo dpkg --set-selections < "$(find -O2 "${saveFolder}/" -regex "^.*Package\.list$")"
            sudo apt-get dselect-upgrade -y

        fi

    else

        echo ""
        echo "FINAL SELECTIONS:"
        echo ""
        echo "Keys: ${saveFolder}/Repo.keys"
        echo "Sources: ${saveFolder}/sources.list"
        echo "Packages: ${saveFolder}/Package.list"
        echo ""
        echo "Last chance to cancel the package restoration..."
        for nn in {1..10};
        do
            echo $((( 11 - $nn )))
            sleep 1
        done
        echo "TIMES UP!!! The DPKG package restoration process will now begin!"
        echo ""

        # Restore packages
        sudo apt-key add "${saveFolder}/Repo.keys"
        sudo cp -R -f "${saveFolder}/sources.list" /etc/apt/
        sudo apt-get update
        sudo apt-get install dselect -y
        sudo dselect update
        sudo dpkg --set-selections < "${saveFolder}/Package.list"
        sudo apt-get dselect-upgrade -y

    fi

}