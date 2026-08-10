import json
import boto3
import time
import csv
from datetime import datetime


def lambda_handler(event, context):

    event_params = event["Records"][0]

    bucket = event_params["s3"]["bucket"]["name"]
    key = event_params["s3"]["object"]["key"]

    print("here")
    print(bucket, key)

    s3_resource = boto3.resource('s3')
    s3_object = s3_resource.Object(bucket, key)

    data = s3_object.get()['Body'].read().decode('utf-8').splitlines()

    lines = csv.reader(data)
    print(lines)
    headers = next(lines)
    print('headers: %s' %(headers))

    list_data = list(lines)

    print(list_data)


    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
