#!/usr/bin/bash
export LC_COLLATE=C      
shopt -s extglob 

select choice in CreateTable ListTable DropTable InsertTable SelectFromTable UpdateTable DeleteFromTable Exit
do
 case $choice in 
            CreateTable )
              createTable.sh
             ;;
            ListTable )
              listTable.sh
             ;;
            DropTable )
              dropTable.sh 
             ;;
            InsertTable )
              insertTable.sh
             ;;
            SelectFromTable )
              selectFromTable.sh
             ;;
            UpdateTable )
              updateTable.sh
             ;;
            DeleteFromTable )
              deleteFromTable.sh
             ;;
            Exit )
            echo "I am out from Database now "

            break
            ;;
            * )
             echo "Enter correct choice"

    esac        
done



              