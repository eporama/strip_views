#!/bin/bash

if [ -z "$1" ]; then 
    echo usage: $0 gzipped_sql_file.sql.gz or plain_sql_file.sql
    exit
fi
if [ ! -e "$1" ]; then
	echo $1 does not exist.
	exit
fi
OFILE=scrubbed-$(date +%Y%m%d_%H%M%S).sql

echo "saving $1 to $OFILE"

MIME=`file -b --mime-type $1`
if [ $MIME = application/x-gzip ]; then
	echo "processing gzipped file"
	gunzip -c $1 | sed -e '/^\/\*\!50001 VIEW/d' -e '/^\/\*\!50013/d' -e '/^\/\*\!50001 CREATE ALGORITHM/d' > $OFILE
else
	echo "processing unzipped file"
	sed -e '/^\/\*\!50001 VIEW/d' -e '/^\/\*\!50013/d' -e '/^\/\*\!50001 CREATE ALGORITHM/d' $1 > $OFILE
fi

echo "zipping $OFILE"
gzip $OFILE

echo "finished"
