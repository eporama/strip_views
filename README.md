Strip Views
===========

Strips views statements out of .sql or .sql.gz files.
Outputs to a scrubbed-date.sql.gz file

Usage
-----

strip_views.sh gzip_file.sql.gz or plain_file.sql

Comments
--------

Acquia Hosting does not function well with mysql views embedded in the code.
This script will simply use sed to remove the offending lines and allow you to
have a .sql import file that will import correctly.
