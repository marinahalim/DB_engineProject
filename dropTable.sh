read -p "Enter table name :" tablename
if [[ -f $tablename ]] ;then
      read -p "Are you sure that you want delete this table? : " confirm 
          if [[ $confirm == "y" ]] ;then
               rm $tablename
               echo "Done"
                
          else
              echo "Continue.."

          fi
else
    echo "This table not exist"

fi
