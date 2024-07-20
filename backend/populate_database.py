import sqlite3

def populate_database():
    connection = sqlite3.connect('finance_tracker.db')  # Use your actual database path
    cursor = connection.cursor()
    
    # Example of inserting data into 'users' table
    cursor.execute('''
    INSERT INTO users (username, email, password)
    VALUES ('testuser', 'testuser@example.com', 'password123')
    ''')
    
    # Example of inserting data into 'transactions' table
    cursor.execute('''
    INSERT INTO transactions (user_id, amount, description, date)
    VALUES (1, 100.0, 'Test transaction', '2024-07-19')
    ''')
    
    connection.commit()
    connection.close()

if __name__ == '__main__':
    populate_database()
