export LC_COLLATE=C      
shopt -s extglob
#declare -a firstColumnData
declare -i flag_for_value=0 #not found 
declare -i flag_for_column=0 #not found 
declare -a ColumnNames
declare -a ColumnData


read -p "Enter Table name : " tablename
if [[ -f $tablename ]]; then 
    echo "You are in $tablename table"
      ColumnNames=($(sed -n '1p' ./$tablename))
      #echo ${#ColumnNames[@]}
       echo "columns of table : ${ColumnNames[@]}"
    select choice in select_all select_row select_column  Exit
     do
       case $choice in 
         select_all )  ########option 1
           sed -n '1p' $tablename
           sed -n '3,$p' $tablename 
          ;;
         select_row )  #########option 2
            read -p "Enter column name : " ColumnName
            for (( i=0;i<${#ColumnNames[@]};i++ ))
            do
                if [[ ${ColumnNames[$i]} == $ColumnName ]];then
                   flag_for_column=1;
                   break
                fi
            done
            for (( i=0; i<${#ColumnNames[@]}; i++ ))
            do
                  if [[ $flag_for_column == 0 ]] ;then
                    echo "coulmn not found.."
                    break;
                  fi  
                      if [[ $ColumnName == ${ColumnNames[$i]} ]] ;then
                        flag_for_column=1;
                            (( x=$i+1 ))
                            ColumnData=($(sed -n '3,$p' ./$tablename | cut -d" " -f$x ))
                            echo "Data of column : " "${ColumnData[@]}"
                            echo "number column : " "${#ColumnData[@]}"
                            read -p "Enter value of $ColumnName : " value #merna

                             for (( j=0; j<${#ColumnData[@]}; j++ ))
                              do
                                  if [[ ${ColumnData[$j]} == $value ]] ;then
                                      (( y=$j+3 ))
                                      sed -n "$y p" ./$tablename
                                      flag_for_value=1
                                     # break
                                  fi
                              done
                            if [[ $flag_for_value == 0 ]] ;then
                                echo "record not found "  
                            fi              
                      fi
            done
       ;;
       select_column )    ################################optin3 
        read -p "Enter column name : " ColumnName
            for (( i=0;i<${#ColumnNames[@]};i++ ))
            do
                if [[ ${ColumnNames[$i]} == $ColumnName ]] ;then
                   flag_for_column=1;
                   (( x=$i+1 ))
                   break
                fi  
            done    
            if [[ $flag_for_column == 1 ]] ;then
                echo "column found.."
                  ColumnData=($(sed -n '3,$p' ./$tablename | cut -d" " -f$x ))
                  echo "${ColumnData[@]}"
                
            else
                 echo "This coulmn not found" 
            fi 
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