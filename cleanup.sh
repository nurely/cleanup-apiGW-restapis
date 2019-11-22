echo "Kill the USELESS APIS"
restApiIds=("XXXXXXXX" "XXXXXXX2"
counter=0

for id in "${restApiIds[@]}" 
do  
    counter=$((counter + 1))
	echo "deleting" "$id" "$counter"

	aws apigateway delete-rest-api --region <your_region> --rest-api-id "$id"

	echo "deleted now waiting 1 minute"
	sleep 60s #You can delete only one api per minute :/
done
