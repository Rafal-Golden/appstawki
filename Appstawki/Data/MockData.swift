//
//  MockData.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 08/10/2024.
//

import Foundation


struct MockData {
    
    static let sampleAppetizer = AppetizerModel(id: 0001,
                                           name: "Test Appetizer",
                                           description: "This is the description for my appetizer. It's yummy.",
                                           price: 9.99,
                                           imageURL: URL(string: "https://")!,
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let sampleDetailsViewModel = AppetizerDetailsViewModel(model: MockData.sampleAppetizer)
    
    static let appetizers       = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static let orderItemOne     = AppetizerModel(id: 0001,
                                           name: "Test Appetizer One",
                                           description: "This is the description for my appetizer. It's yummy.",
                                           price: 9.99,
                                           imageURL: URL(string: "https://")!,
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItemTwo     = AppetizerModel(id: 0002,
                                           name: "Test Appetizer Two",
                                           description: "This is the description for my appetizer. It's yummy.",
                                           price: 9.99,
                                           imageURL: URL(string: "https://")!,
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItemThree   = AppetizerModel(id: 0003,
                                           name: "Test Appetizer Three",
                                           description: "This is the description for my appetizer. It's yummy.",
                                           price: 9.99,
                                           imageURL: URL(string: "https://")!,
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItems       = [orderItemOne, orderItemTwo, orderItemThree]

}
