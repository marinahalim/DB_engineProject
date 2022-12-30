x=`ls -F | grep -v "/" `
if [[ $x == "" ]] ;then
    echo "There is no Table"
else 
    echo $x    
fi 
