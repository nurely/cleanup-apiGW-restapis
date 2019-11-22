# Steps to Cleanup your AWS API Gateway Rest APIs.

As you know we can delete only one API per minute. Here is a cute little technique to cleanup your rest-apis not needed anymore.

- Create a new IAM User with Custom Policy:
  - You can set different restrictions based on your apigateway arn. I am playing safe for one region.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "apigateway:*"
            ],
            "Resource": "arn:aws:apigateway:<your_region>::/*"
        }
    ]
}
```

- Once a user is created, copy its AWS_ACCESS_ID and AWS_SECRET_ACCESS_KEY

- In cli configure your aws-cli

```
>> aws configure
AWS Access Key ID [****************XXX]: <AWS_ACCESS_ID>
AWS Secret Access Key [****************XXX]: AWS_SECRET_ACCESS_KEY
Default region name [eu-west-1]:
Default output format [json]:
```

- Now run this script, with your rest-api ids added in the array

```
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
```
