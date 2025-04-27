import unittest
from unittest import mock
import sqlite3

class TestDBConfig(unittest.TestCase):

    def test_db_connection(self):
        with mock.patch('sqlite3.connect') as mock_connect:
            mock_db = mock.MagicMock()
            mock_connect.return_value = mock_db
            conn = sqlite3.connect('test.db')
            self.assertIsNotNone(conn)
            mock_connect.assert_called_once_with('test.db')

    def test_db_cursor(self):
        with mock.patch('sqlite3.connect') as mock_connect:
            mock_db = mock.MagicMock()
            mock_cursor = mock.MagicMock()
            mock_db.cursor.return_value = mock_cursor
            mock_connect.return_value = mock_db
            conn = sqlite3.connect('test.db')
            cursor = conn.cursor()
            self.assertIsNotNone(cursor)
            mock_db.cursor.assert_called_once()

if __name__ == '__main__':
    unittest.main()
