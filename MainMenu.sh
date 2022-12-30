#!/usr/bin/bash
export LC_COLLATE=C      
shopt -s extglob  

if [ -d ~/DataBases ] ;then
    cd ~/DataBases
else
    mkdir ~/DataBases
    cd ~/DataBases
fi    

select choice in CreateDB ListDB DropDB connectDB Exit
do
 case $choice in
             CreateDB )
                     read -p "enter name of Database :" name
                     if [ -e $name ] ;then
                         echo "This database already exist :"
                         
                     else 
                          if [[ ${name} =~ ^[a-zA-Z]+ ]] ;then   
                          mkdir $name
                          else
                          echo "Database name should begin with char only"
                          fi
                     fi         
             ;;
             ListDB )
                x=`ls -F | grep "/" `
                     if [[ $x == "" ]] ;then
                         echo "There is no Database"
                     else 
                        echo $x 
                    fi 
                         

             ;;
             DropDB )
                    #  cd ~/DataBases
                     read -p "Enter DataBase Name that you want delete it : " name
                     if [ -d $name ] ;then
                          rm -r $name;
                          echo "Done.."
                     else
                          echo "This DataBase not found" 
                     fi 
             ;;
             connectDB )
                    # cd ~/DataBases
                    read -p "Enter Database Name : " name
                    if [ -d $name ] ;then
                        cd $name
                         echo "you are in $name Database"
                        connectToDatabase.sh
    
                    else
                        echo "Error,cant connect"
                    fi     
              ;;
             Exit )
                echo "Exit from Database mode.."
                break
              ;;
              * )
              echo "Incorrect choice "  
             
 esac
done






       

