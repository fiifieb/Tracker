from flask import Flask, request, jsonify, redirect, url_for
from flask_login import LoginManager, login_user, login_required, logout_user, current_user
from backend.models import Session, User, Transaction

app = Flask(__name__)
app.secret_key = 'your_secret_key'
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(user_id):
    session = Session()
    user = session.query(User).get(user_id)
    session.close()
    return user

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    session = Session()
    if session.query(User).filter_by(username=data['username']).first():
        session.close()
        return jsonify({'message': 'Username already exists'}), 400
    new_user = User(username=data['username'], email=data['email'])
    new_user.set_password(data['password'])
    session.add(new_user)
    session.commit()
    session.close()
    return jsonify({'message': 'User registered successfully!'})

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    session = Session()
    user = session.query(User).filter_by(username=data['username']).first()
    if user is None or not user.check_password(data['password']):
        session.close()
        return jsonify({'message': 'Invalid username or password'}), 401
    login_user(user)
    session.close()
    return jsonify({'message': 'Logged in successfully!'})

@app.route('/logout', methods=['POST'])
@login_required
def logout():
    logout_user()
    return jsonify({'message': 'Logged out successfully!'})

@app.route('/add_transaction', methods=['POST'])
@login_required
def add_transaction():
    session = Session()
    data = request.get_json()
    new_transaction = Transaction(
        description=data['description'],
        amount=data['amount'],
        category=data['category'],
        user_id=current_user.id
    )
    session.add(new_transaction)
    session.commit()
    session.close()
    return jsonify({'message': 'Transaction added successfully!'})

@app.route('/get_transactions', methods=['GET'])
@login_required
def get_transactions():
    session = Session()
    transactions = session.query(Transaction).filter_by(user_id=current_user.id).all()
    results = [
        {
            "id": transaction.id,
            "description": transaction.description,
            "amount": transaction.amount,
            "date": transaction.date,
            "category": transaction.category
        } for transaction in transactions]
    session.close()
    return jsonify(results)

@app.route('/get_balance', methods=['GET'])
@login_required
def get_balance():
    session = Session()
    transactions = session.query(Transaction).filter_by(user_id=current_user.id).all()
    balance = sum(transaction.amount for transaction in transactions)
    session.close()
    return jsonify({'balance': balance})

@app.route('/get_report', methods=['GET'])
@login_required
def get_report():
    session = Session()
    transactions = session.query(Transaction).filter_by(user_id=current_user.id).all()
    report = {}
    for transaction in transactions:
        if transaction.category not in report:
            report[transaction.category] = 0
        report[transaction.category] += transaction.amount
    session.close()
    return jsonify(report)

if __name__ == '__main__':
    app.run(debug=True)
