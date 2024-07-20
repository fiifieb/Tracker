import React, { useState } from 'react';
import { addTransaction } from '../api';

const TransactionForm = ({ onTransactionAdded }) => {
    const [amount, setAmount] = useState('');
    const [description, setDescription] = useState('');
    const [type, setType] = useState('expense');
    const [message, setMessage] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await addTransaction({ amount, description, type });
            if (response && response.message) {
                setMessage(response.message);
                onTransactionAdded();
            } else {
                setMessage('Unexpected response structure.');
            }
        } catch (error) {
            setMessage(error.message || 'Transaction addition failed. Please try again.');
        }
    };

    return (
        <div>
            <h2>Add Transaction</h2>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    placeholder="Amount"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                />
                <input
                    type="text"
                    placeholder="Description"
                    value={description}
                    onChange={(e) => setDescription(e.target.value)}
                />
                <select value={type} onChange={(e) => setType(e.target.value)}>
                    <option value="expense">Expense</option>
                    <option value="income">Income</option>
                </select>
                <button type="submit">Add</button>
            </form>
            {message && <p>{message}</p>}
        </div>
    );
};

export default TransactionForm;
