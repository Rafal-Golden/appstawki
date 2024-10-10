//
//  String+Extension.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 09/10/2024.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegExp)
        return emailPredicate.evaluate(with: self)
    }
}
