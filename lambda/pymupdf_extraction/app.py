import json
import boto3
import csv
import fitz

def lambda_handler(event, context):
    print(event)
    s3_client = boto3.client('s3')
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        for record in json.loads(body['Message'])['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            response = s3_client.get_object(Bucket = bucket, Key = key)
            pdf_object = response['Body']
            doc = fitz.open(pdf_object)
            print('Doc :',doc)



