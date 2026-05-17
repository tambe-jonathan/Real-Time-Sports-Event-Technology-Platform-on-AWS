import json
import boto3
from datetime import datetime

dynamodb=boto3.resource('dynamodb')

table=dynamodb.Table(
    os.environ['TABLE_NAME']
)


def lambda_handler(event,context):

    data={

        "athlete":event["athlete"],
        "score":event["score"],
        "timestamp":str(datetime.now())

    }

    table.put_item(Item=data)

    return {

        "statusCode":200,
        "body":json.dumps(data)

    }
