//
//  FormItem.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 09/10/2024.
//

import SwiftUI

class FormItem<T>: ObservableObject {
    var name: LocalizedStringKey
    @Published var value: T
    
    init(name: LocalizedStringKey, value: T) {
        self.name = name
        self.value = value
    }
}

class TextItem: FormItem<String>, Identifiable {
    var id: ID
    enum ID: Int {
        case firstName = 1, lastName = 2, email = 3
        var next: ID? {
            ID(rawValue: self.rawValue + 1)
        }
    }
    init(name: LocalizedStringKey, value: String, id: ID) {
        self.id = id
        super.init(name: name, value: value)
    }
}

class DateItem: FormItem<Date> {
    convenience init(name: LocalizedStringKey, date: Date = .now) {
        self.init(name: name, value: date)
    }
}

class CheckItem: FormItem<Bool> {}

