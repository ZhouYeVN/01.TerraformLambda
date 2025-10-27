import json
import boto3
import os

# Initialize SQS client (boto3 is pre-installed in Lambda)
sqs = boto3.client('sqs')

print("🚀 MODULE INITIALIZED")  # Cold start log

# Read queue URLs from environment variables (set by Terraform)
MAIN_QUEUE_URL = os.environ['MAIN_QUEUE_URL']
DLQ_QUEUE_URL = os.environ['DLQ_QUEUE_URL']

def lambda_handler(event, context):
    print("🚀 HANDLER INITIALIZED")  # Cold start log
    
    try:
        # Parse the request body (API Gateway sends it as a string)
        body = json.loads(event['body'])
        number = body.get('number')

        # Validate input
        if not isinstance(number, (int, float)):
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'Field "number" must be a number'})
            }

        # Decide which queue to use
        if number >= 0:
            queue_url = MAIN_QUEUE_URL
            status = "sent to main queue"
        else:
            queue_url = DLQ_QUEUE_URL
            status = "sent to DLQ"

        # Send message to SQS
        sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps({'number': number}),
            MessageGroupId='number-group'  # Required for FIFO queues (if used) | SQS can also be config to create MessageGroupId automatically 
        )

        # Return success response
        return {
            'statusCode': 200,
            'body': json.dumps({
                'status': status,
                'number': number
            })
        }

    except Exception as e:
        # Log error to CloudWatch
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Internal server error'})
        }