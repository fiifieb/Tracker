import axios from 'axios';

const API_URL = 'http://127.0.0.1:5000';

export const login = async (credentials) => {
    const response = await axios.post(`${API_URL}/login`, credentials);
    return response.data;
};

export const register = async (user) => {
    const response = await axios.post(`${API_URL}/register`, user);
    return response.data;
};

export const addTransaction = async (transaction) => {
    const response = await axios.post(`${API_URL}/transactions`, transaction);
    return response.data;
};

export const getBalance = async () => {
    const response = await axios.get(`${API_URL}/balance`);
    return response.data;
};

export const getReport = async () => {
    const response = await axios.get(`${API_URL}/report`);
    return response.data;
};
