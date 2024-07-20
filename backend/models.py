from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
import datetime

Base = declarative_base()

class User(Base, UserMixin):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    password_hash = Column(String, nullable=False)
    
    transactions = relationship('Transaction', backref='user', lazy=True)
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

class Transaction(Base):
    __tablename__ = 'transactions'
    id = Column(Integer, primary_key=True)
    description = Column(String, nullable=False)
    amount = Column(Float, nullable=False)
    date = Column(DateTime, default=datetime.datetime.utcnow)
    category = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)

DATABASE_URL = "sqlite:///database.db"
engine = create_engine(DATABASE_URL)
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
