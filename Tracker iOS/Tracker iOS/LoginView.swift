//
//  LoginView.swift
//  Tracker iOS
//
//  Created by Fiifi Botchway on 7/19/24.
//


import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    @State private var accessToken = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                NetworkManager.shared.login(username: username, password: password) { result in
                    switch result {
                    case .success(let token):
                        accessToken = token
                        message = "Login successful"
                    case .failure(let error):
                        message = error.localizedDescription
                    }
                }
            }) {
                Text("Login")
            }
            .padding()
            Text(message)
                .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
