#!/usr/bin/bash
export LC_COLLATE=C      
shopt -s extglob
echo "I will crate table now..  "
read -p "Enter Table name : " tablename
if [[ -f $tablename ]] ;then
    echo "This Table already exist"

else
    if [[ ${tablename} =~ ^[a-zA-Z]+ ]] ;then   
         touch $tablename
         read -p "Enter number of columns:" num_col
           if [[ $num_col =~ [0-9]+ ]] ;then
                declare -i flag=1
                for((i=0;i<$num_col;i++))
                   do
                        read -p "Enter name of column:" cal_name
                           if [[ ${cal_name} =~ ^[a-zA-Z]+ ]] ;then 
                              echo -n $cal_name" ">> $tablename
                            else
                               flag=0
                               echo "Syntax error"  
                               break
                            fi
                   done
               if [[ $flag == 1 ]] ;then 
                 echo "" >> $tablename
                 for ((i=0;i<$num_col;i++))
                   do
                        read -p "Enter datatype of $i : " col_datatype
                        if [[ $col_datatype == "int"||$col_datatype == "string" ]] ;then
                           echo -n $col_datatype" " >> $tablename
                        else
                           echo "Renter valid datatype "
                            i=($i-1)

                        fi

         
                    done

        
                fi   
                  

            else 
                echo "Enter numbers only"
            fi
         
    else
         echo "Table name should begin with char only "
    fi     
fi                   
          


                    
                         
                          
