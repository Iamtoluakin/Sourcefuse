import argparse
import boto3

def list_s3_files(bucket_name):
    s3 = boto3.resource('s3')
    bucket = s3.Bucket(bucket_name)
    files = []
    
    for obj in bucket.objects.all():
        files.append(obj.key)
    
    return files

def list_ecs_task_definition_versions(service_name):
    ecs = boto3.client('ecs')
    response = ecs.list_task_definition_families(familyPrefix=service_name)
    versions = response['families']
    
    return versions

def list_s3_files_command(args):
    files = list_s3_files(args.bucket_name)
    
    if files:
        print("Files in S3 bucket:")
        for file in files:
            print(file)
    else:
        print("No files found in the S3 bucket.")

def list_ecs_task_definition_versions_command(args):
    versions = list_ecs_task_definition_versions(args.service_name)
    
    if versions:
        print("Versions of ECS task definition for the service:")
        for version in versions:
            print(version)
    else:
        print("No versions found for the ECS task definition.")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="CLI for interacting with S3 and ECS")
    subparsers = parser.add_subparsers()

    # Command to list files in S3 bucket
    s3_files_parser = subparsers.add_parser('list-s3-files', help='List files in S3 bucket')
    s3_files_parser.add_argument('bucket_name', type=str, help='nginx-logs-bucket-2023-tolu')
    s3_files_parser.set_defaults(func=list_s3_files_command)

    # Command to list versions of ECS task definition
    ecs_versions_parser = subparsers.add_parser('list-ecs-versions', help='List versions of ECS task definition')
    ecs_versions_parser.add_argument('service_name', type=str, help='nginx-service')
    ecs_versions_parser.set_defaults(func=list_ecs_task_definition_versions_command)

    args = parser.parse_args()
if __name__ == '__main__':
    args = parser.parse_args()

    if 'func' in args:
        args.func(args)
    else:
        parser.print_help()