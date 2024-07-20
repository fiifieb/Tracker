//
//  NetworkManager.swift
//  Tracker iOS
//
//  Created by Fiifi Botchway on 7/19/24.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://127.0.0.1:5000"
    
    private init() {}

    // Register User
    func register(username: String, email: String, password: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]

        AF.request("\(baseURL)/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let registerResponse):
                    completion(.success(registerResponse.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // Login User
    func login(username: String, password: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        AF.request("\(baseURL)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    completion(.success(loginResponse.accessToken))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // Fetch Transactions
    func fetchTransactions(userId: Int, completion: @escaping (Result<[Transaction], AFError>) -> Void) {
        AF.request("\(baseURL)/transactions/\(userId)", method: .get)
            .responseDecodable(of: [Transaction].self) { response in
                switch response.result {
                case .success(let transactions):
                    completion(.success(transactions))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // Add Transaction
    func addTransaction(userId: Int, description: String, amount: Double, date: String, category: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "user_id": userId,
            "description": description,
            "amount": amount,
            "date": date,
            "category": category
        ]

        AF.request("\(baseURL)/transactions", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: AddTransactionResponse.self) { response in
                switch response.result {
                case .success(let addTransactionResponse):
                    completion(.success(addTransactionResponse.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

// Define the response structures
struct RegisterResponse: Decodable {
    let message: String
}

struct LoginResponse: Decodable {
    let accessToken: String
}

struct AddTransactionResponse: Decodable {
    let message: String
}
