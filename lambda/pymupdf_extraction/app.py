import json
import boto3
import csv
import fitz
from datetime import datetime

def trigger_textract_text_detection(bucket,key):
    print('Triggered Textract')
    textract_client = boto3.client('textract')
    response = textract_client.start_document_text_detection(
        DocumentLocation={
            'S3Object': {
                'Bucket': bucket,
                'Name': key
            }
        },
        NotificationChannel={
            'SNSTopicArn': 'arn:aws:sns:ap-southeast-2:464866296249:AmazonTextract-sns',
            'RoleArn': 'arn:aws:iam::464866296249:role/iam-textract-pdf-extraction'
        }
    )
    print('Request Textract Done')

def save_to_s3(filename, json_object):
    s3 = boto3.client('s3')
    s3.put_object(
        Body=json.dumps(json_object),
        Bucket='pdf-text-extraction-results',
        Key= filename
    )

def save_content(document,content):
    document_dict = dict()
    filename = document.metadata['title']+'.json'
    document_dict['title'] = document.metadata['title']
    document_dict['text'] = content
    document_dict['extraction_date'] = str(datetime.utcnow())
    document_dict['num_pages'] = document.pageCount
    json_object = json.dumps(document_dict) 
    save_to_s3(filename,json_object)
     


def is_pymupdf_extractable(document,content):
    acceptable_creator = ['Springer','Pages']
    words_threshold = 20
    if (document.metadata['creator'] in acceptable_creator) and (len(content) > words_threshold):
        return True
    else:
        return False

def get_pdf_content(document):
    content = ""
    for page in document:
        content += page.get_text()
    return content

def lambda_handler(event, context):
    print(event)
    s3_client = boto3.client('s3')
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        for record in body['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            response = s3_client.get_object(Bucket = bucket, Key = key)
            pdf_object = response['Body']
            document = fitz.open( stream = pdf_object.read(), filetype="pdf")
            content = get_pdf_content(document)
            if is_pymupdf_extractable(document,content):
                save_content(document,content)
            else:
                trigger_textract_text_detection(bucket,key)



