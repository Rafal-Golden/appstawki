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

class TextItem: FormItem<String> {}

class DateItem: FormItem<Date> {
    convenience init(name: LocalizedStringKey, date: Date = .now) {
        self.init(name: name, value: date)
    }
}

class CheckItem: FormItem<Bool> {}

