//
//  PasswordGeneratorView.swift
//  Password_Manager
//
//  Created by Jigar on 30/09/23.
//

import SwiftUI

struct PasswordGeneratorView: View {

    @State private var passwordLength: Int = 12
    @State private var includeLowercase = true
    @State private var includeUppercase = true
    @State private var includeNumbers = true
    @State private var includeSymbols = true
    @State private var generatedPassword: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Settings")) {
                    Stepper(value: $passwordLength, in: 8...20) {
                        Text("Password length: \(passwordLength)")
                    }
                    Toggle("Include lowercase letters", isOn: $includeLowercase)
                    Toggle("Include uppercase letters", isOn: $includeUppercase)
                    Toggle("Include numbers", isOn: $includeNumbers)
                    Toggle("Include symbols", isOn: $includeSymbols)
                }

                Section {
                    Button(action: generatePassword) {
                        Text("Generate Password")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }

                Section(header: Text("Generated Password")) {
                    Text(generatedPassword)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }

                Section {
                    Button(action: copyToClipboard) {
                        Text("Copy Password")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle("Password Generator")
        }
    }

    private func generatePassword() {
        generatedPassword = generateRandomPassword()
    }

    private func generateRandomPassword() -> String {
        let allCharacters = (
            (includeLowercase ? "abcdefghijklmnopqrstuvwxyz" : "") +
            (includeUppercase ? "ABCDEFGHIJKLMNOPQRSTUVWXYZ" : "") +
            (includeNumbers ? "0123456789" : "") +
            (includeSymbols ? "!@#$%^&*()-+" : "")
        )

        var password = ""

        if allCharacters.isEmpty {
            return "Please select at least one character type."
        }

        if passwordLength < 8 {
            return "Password length must be at least 8."
        }

        for _ in 0..<passwordLength {
            let randomIndex = Int.random(in: 0..<allCharacters.count)
            let character = allCharacters[allCharacters.index(allCharacters.startIndex, offsetBy: randomIndex)]
            password.append(character)
        }

        return password
    }

    private func copyToClipboard() {
        UIPasteboard.general.string = generatedPassword
    }
}

struct PasswordGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordGeneratorView()
    }
}
