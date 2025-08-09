import psycopg2
from psycopg2.extras import RealDictCursor

class Database:
    def __init__(self):
        self.connection = None
        self.connect()
    
    def connect(self):
        try:
            self.connection = psycopg2.connect(
                host="sneaker-database",
                port="5432",
                database="logs_db",
                user="admin",
                password="admin123"
            )
            print("Connected to logs database")
        except Exception as e:
            print(f"Error connecting to database: {e}")
    
    def get_cursor(self):
        return self.connection.cursor(cursor_factory=RealDictCursor)
    
    def close(self):
        if self.connection:
            self.connection.close()

db = Database()