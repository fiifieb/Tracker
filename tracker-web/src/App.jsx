import React, { useState } from 'react';
import Register from './components/Register';
import Login from './components/Login';
import TransactionList from './components/TransactionList';

const App = () => {
    const [authenticated, setAuthenticated] = useState(false);

    return (
        <div>
            <h1>Tracker</h1>
            {!authenticated ? (
                <div>
                    <Login setAuthenticated={setAuthenticated} />
                    <Register />
                </div>
            ) : (
                <TransactionList />
            )}
        </div>
    ); 
};

export default App;
