export LC_COLLATE=C      
shopt -s extglob
declare -a firstColumnData
declare -i flag=0 #not found primarykey


read -p "Enter Table name : " tablename
if [[ -f $tablename ]]; then 
    echo "You are in $tablename table"
    select choice in Delete_all Delete_row Exit
     do
       case $choice in 
         Delete_all )
           sed -i '3,$d' $tablename 
           echo "Table is empty now.."
          ;;
         Delete_row )
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
                  sed -i "/$primarykey/d" $tablename
                  echo "Done,record deleted.."
                else
                  echo "invalid value.."        
                fi
                flag=0
          ;;  
         Exit )
         break
         ;;
         * )
          echo "invalid choice.."
          ;;
            
          
     esac
     done 
fi    