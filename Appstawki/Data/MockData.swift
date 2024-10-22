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
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static func genAppetizer(id: Int, name: String) -> AppetizerModel {
        return AppetizerModel(id: id,
                              name: name,
                              description: "This is the description for my appetizer. It's yummy.",
                              price: .random(in: 1...9.9),
                              imageURL: URL(string: "https://")!,
                              calories: .random(in: 99...300),
                              protein: .random(in: 99...200),
                              carbs: .random(in: 99...599))
    }
    
    static let orderItemOne     = genAppetizer(id: 0001, name: "Test Appetizer One")
    static let orderItemTwo     = genAppetizer(id: 0002, name: "Test Appetizer Two")
    static let orderItemThree   = genAppetizer(id: 0003, name: "Test Appetizer Three")
    
    static let orderItems       = [orderItemOne, orderItemTwo, orderItemThree]
}
