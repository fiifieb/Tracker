import React, { useState, useEffect } from 'react';
import TransactionForm from './TransactionForm';
import { getReport } from '../api';

const TransactionList = () => {
    const [report, setReport] = useState([]);

    useEffect(() => {
        fetchReport();
    }, []);

    const fetchReport = async () => {
        try {
            const response = await getReport();
            if (response && response.report !== undefined) {
                setReport(response.report);
            } else {
                console.error('Unexpected response structure.');
            }
        } catch (error) {
            console.error(error.message || 'Failed to fetch report.');
        }
    };

    return (
        <div>
            <TransactionForm onTransactionAdded={fetchReport} />
            <h2>Transactions</h2>
            <ul>
                {report.map((transaction) => (
                    <li key={transaction.id}>
                        {transaction.description}: ${transaction.amount} ({transaction.type})
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default TransactionList;
