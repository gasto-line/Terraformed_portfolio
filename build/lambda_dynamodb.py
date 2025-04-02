import boto3
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.environ["TABLE_NAME"]
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    key = {"id": "visits"}

    # Fetch the item first
    response = table.get_item(Key=key)
    item = response.get("Item", {})

    # Initialize total_count if missing
    if not item:
        table.put_item(Item={"id": "visits", "total_count": 1})
        return {
            "statusCode": 200,
            "body": "Counter initialized to 1"
        }

    table.update_item(
        Key=key,
        UpdateExpression="ADD total_count :incr",
        ExpressionAttributeValues={":incr": 1},
        ReturnValues="UPDATED_NEW"
    )
