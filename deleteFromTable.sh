export LC_COLLATE=C      
shopt -s extglob
declare -a firstColumnData
declare -i flag_for_value=0
declare -i flag_for_column=0;
declare -i y=0;
declare -a ColumnNames
declare -a ColumnData

read -p "Enter Table name : " tablename
if [[ -f $tablename ]]; then 
    ColumnNames=($(sed -n '1p' ./$tablename))
    echo "You are in $tablename table"
    select choice in Delete_all Delete_row Delete_column Exit
     do
       case $choice in 
         Delete_all )                                   #option1
           sed -i '3,$d' $tablename 
           echo "Table is empty now.."
          ;;
         Delete_row )                                   #option2
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
                echo "column found"
                read -p "Enter value : " value
                              
                ColumnData=($(sed -n '3,$p' ./$tablename | cut -d" " -f$x ))
                #echo "${ColumnData[@]}"

                for (( j=0;j<${#ColumnData[@]};j++ ))
                do
                    if [[ ${ColumnData[$j]} == $value ]] ;then
                          flag_for_value=1 # found 
                          (( y=$j+ 3)) 
                          echo "i will delete.. "
                          echo "$y"
                          sed -i "$y d" ./$tablename
                          break
                   fi 
                done  
                if [[ $flag_for_value == 0 ]] ;then
                    echo "This value not exist.."
                fi     
            else
                 echo "This coulmn not found" 
            fi      
           ;;
         Delete_column )           #option 3
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
                  #echo "${ColumnData[@]}"
                  for (( j=0;j<${#ColumnData[@]};j++ ))
                  do
                   space=" "
                   sed -i  "s/${ColumnData[$j]}/$space/g" ./$tablename
                  done
            else
                 echo "This coulmn not found" 
            fi 
            
          ;; 
         Exit )
         break
         ;;
         * )
          echo "invalid choice.."
        esac
      done    
else
    echo "this table not exist.."
fi              
            
          
