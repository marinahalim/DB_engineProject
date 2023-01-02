export LC_COLLATE=C      
shopt -s extglob
declare -a firstColumnData
declare -i flag=0 #not found primarykey


read -p "Enter Table name : " tablename
if [[ -f $tablename ]]; then 
    echo "You are in $tablename table"
    select choice in select_all select_row select_record Exit
     do
       case $choice in 
         select_all )
           sed -n '1p' $tablename
           sed -n '3,$p' $tablename 
          ;;
         select_row ) 
            read -p "Enter primary key : " primarykey
               firstColumnData=($(sed -n '3,$p' ./$tablename | cut -d" " -f1))
               for (( j=0; j < ${#firstColumnData[@]}; j++ ));
                do
                      if [[ $primarykey == ${firstColumnData[$j]} ]] ;then 
                           flag=1
                            break
                        fi      
                    
                done
                if [[ $flag == 1 ]] ;then
                  sed -n "/$primarykey/p" $tablename
                else
                  echo "invalid value"        
                fi
                flag=0
       ;;
       select_record )

       ;;
       Exit )
        echo " i am exit from table $tablename"
         break
       ;;
       * )
       echo "invalid choice.."
      esac
     done
else
 echo "This table not found"
fi