
# Auto LAP vagrant script

### Simply clone then run `script.sh` to behold its magic

I did not create customized error messages for 3 reasons:
- Bash standard errors are plenty clear enough as it is.
- The errors I could have created would not have been localized, whereas Bash's are.
- Bash error management is, depending on the point of view, somewhere between a weird and unusual syntax and a huge pain in the a** to do. (I tend to think closer to the latest option.)

<hr>

> I realy don't know how to make the script stop with ctrl + c  so... Sorry it doesn't work.
This is actually quite lame.

LAP stands for Linux Apache2 PHP. This is a variation on the famous LAMP server, 
without Mysql... Because I tend to think more recent and open source options are
available and should be used preferably. Also, provisioning a vagrant with Mysql
and a variable password is next to impossible.  
