#!/bin/bash

if [ $# != 2 ]; then
    scriptName=`basename $0`
    echo "Usage: ./$scriptName [directory-with-input-pref-files] [target-directory-for-converted-files]"
    exit;
fi

inputPath=$1
targetPath=$2

# A work-around to preserve multiple continuous spaces in bash variables
# http://logbuffer.wordpress.com/2010/09/23/bash-scripting-preserve-whitespaces-in-variables/
IFS='%'

ls $inputPath | while read filename ; do
    if [ ${filename:(-5)} = ".json" ]; then

        idValue=${filename:0:${#filename}-5}
        fourSpaces=`printf '%4s' ' '`

        convertedStr={'\n'$fourSpaces\"_id\":\ \"$idValue\",'\n'$fourSpaces\"value\":\

        counter=0
        while read contentLine || [ -n "$contentLine" ]; do
            if [ $counter -eq 0 ]; then
                convertedStr+=$contentLine'\n'
            else
                convertedStr+=$fourSpaces$contentLine'\n';
            fi
            counter=$[$counter +1]
        done < <(cat $inputPath/$filename)

        convertedStr+=}

        if [ ! -d "$targetPath" ]; then
            mkdir $targetPath
        fi
        echo -e $convertedStr > $targetPath/$filename
    fi
done

echo "Done!"