## Backups

This directory provides backup xml files that can be used to restore the geoconnex PID server database using "import" command of the PIDsvc API described in the [IoW-PIDsvc repository](https://github.com/internetofwater/IoW-PIDsvc). Beginning July 2020, backup files are split up ito xml files containing 500 or fewer mappings to reduce backup and restore timeout errors. The most current backups are in the "backup_current" directory. 

The ```backup_restore.sh``` schell script can be used to restore the PIDsvc database from this folder within the cloned repository on the host server. It can also be run locally, by changing ```curl http://localhost:8095``` to ```curl --user username:password https://geoconnex.us```
