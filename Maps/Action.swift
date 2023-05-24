//
//  Action.swift
//  Maps
//
//  Created by hassoun on 23/05/2023.
//

import Foundation

struct Action: Identifiable{
    let id = UUID()
    let title: String
    let image: String
    let handler: () ->Void
}
