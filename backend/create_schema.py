import sqlite3

def create_schema():
    connection = sqlite3.connect('finance_tracker.db')  # Use your actual database path
    cursor = connection.cursor()
    
    # Create 'users' table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
    )
    ''')
    
    # Create 'transactions' table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        amount REAL NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
    )
    ''')
    
    connection.commit()
    connection.close()

if __name__ == '__main__':
    create_schema()
