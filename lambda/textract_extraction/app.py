import boto3
import json
from datetime import datetime

def get_pdf_content(job_id):
    content = ''
    client = boto3.client('textract')
    response = client.get_document_text_detection(JobId = job_id)
    num_pages = response['DocumentMetadata']['Pages']
    for item in response["Blocks"]:
        if item["BlockType"] == "LINE":
            content += item["Text"] 
    return content,num_pages

def save_to_s3(filename, json_object):
    s3 = boto3.client('s3')
    s3.put_object(
        Body=json.dumps(json_object),
        Bucket='pdf-text-extraction-results',
        Key= filename
    )

def save_content(message,content,num_pages):
    document_dict = dict()
    filename = '_'.join(message['DocumentLocation']['S3ObjectName'].split('.')[:-1])
    document_dict['title'] = filename
    document_dict['text'] = content
    document_dict['extraction_date'] = str(datetime.utcnow())
    document_dict['num_pages'] = num_pages
    json_object = json.dumps(document_dict) 
    filename = filename + '.json'
    save_to_s3(filename,json_object)

def lambda_handler(event, context):
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        print('body : ',body)
        message = json.loads(body['Message'])
        print('message :',message)
        if message['Status'] == 'SUCCEEDED':
            content,num_pages = get_pdf_content(message['JobId'])
            save_content(message, content,num_pages)
            print('PDF Extraction Saved')
        else:
            print('PDF Extraction In Progress')
            
            
