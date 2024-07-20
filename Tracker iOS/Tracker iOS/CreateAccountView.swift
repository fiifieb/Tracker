//
//  CreateAccountView.swift
//  Tracker iOS
//
//  Created by Fiifi Botchway on 7/19/24.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                NetworkManager.shared.register(username: username, email: email, password: password) { result in
                    switch result {
                    case .success(let msg):
                        message = msg
                    case .failure(let error):
                        message = error.localizedDescription
                    }
                }
            }) {
                Text("Create Account")
            }
            .padding()
            Text(message)
                .padding()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
