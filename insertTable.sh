#!/usr/bin/bash
declare -a firstColumnData
declare -a names
declare -a datatypes
declare -a inputEl
declare -i datatypeflag=1  # correct 
declare -i flag=1         # consider that id unique


read -p "Enter Table name : " tablename
if [[ -f $tablename ]]; then
    firstColumnData=($(sed -n '3,$p' ./$tablename | cut -d" " -f1))
    names=($(sed -n '1p' ./$tablename))
    datatypes=($(sed -n '2p' ./$tablename))
     #echo "${datatypes[@]}"
    
    for ((i = 0; i < ${#names[@]}; i++)); 
    do
        read -p "Enter value of ${names[$i]}: " value
        if [[ ${datatypes[$i]} == "int" ]] ;then
              if ! [[ $value =~ ^[0-9]+$ ]] ;then
                  datatypeflag=0
                  break
                  #echo "int"
              fi
        elif [[ ${datatypes[$i]} == "string" ]] ;then
              if ! [[ $value =~ ^[a-zA-Z]+$  ]] ;then
                  datatypeflag=0
                  break
                  #echo "string"
              fi
        fi 
        if [[ $datatypeflag == 1 ]] ;then
          if [[ $i == 0 ]]; then        #for check primary
              for (( j=0; j < ${#names[@]}; j++ ));
              do
                 if [[ $value == ${firstColumnData[$j]} ]]; then #check ife primary key repeated
                       flag=0 
                      break
                 else
                    inputEl[$i]=$value;
                 fi
              done
          else
            inputEl[$i]=$value;
          fi  
        
        else
          echo "check datatype please "
        fi
        #datatypeflag=0
    done
else
    echo "This Table not Exist"
fi
for ((i=0; i <${#names[@]}; i++));
   do
      if [[ $flag == 1 && $datatypeflag == 1 ]] ;then   # if primary key unique i will enter the data in file
          echo -n ${inputEl[$i]}" " >> ./$tablename
      else
        echo "Erorr ,cant insert.."
        break
      fi 
done
if [[ $flag == 1 && $datatypeflag == 1 ]] ;then    # for move to new line in file
        echo >> ./$tablename
        echo "Done.." 
fi      