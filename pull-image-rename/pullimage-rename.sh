#for file in $(ls); do  newfile=$(echo $file | awk -F : '{print $2".tag"}');  mv $file $newfile; done  

for file in $(ls); 
do  
	newfile=$(echo $file | awk -F : '{print $2".tag"}');  
	mv $file $newfile; 
done