import unittest
from unittest.mock import patch
from io import StringIO
import Python_scripts.cli as cli

class TestCLI(unittest.TestCase):
    def test_list_s3_files_command(self):
        with patch('sys.stdout', new=StringIO()) as fake_out:
            cli.list_s3_files_command(cli.argparse.Namespace(bucket_name='my-bucket'))
            output = fake_out.getvalue().strip()
            self.assertEqual(output, 'No files found in the S3 bucket.')

    def test_list_ecs_task_definition_versions_command(self):
        with patch('sys.stdout', new=StringIO()) as fake_out:
            cli.list_ecs_task_definition_versions_command(cli.argparse.Namespace(service_name='my-service'))
            output = fake_out.getvalue().strip()
            self
