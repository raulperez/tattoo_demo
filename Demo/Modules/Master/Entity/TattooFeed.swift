//
//  TattooFeed.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

struct Pagination: Codable {
    var total: UInt?
    var count: UInt?
    var per_page: UInt?
    var current_page: UInt?
    var total_pages: UInt?
    var links: Dictionary<String, String>?
}

struct Meta: Codable {
    var pagination: Pagination?
}

struct TattooFeed: Codable {
    var data: [Tattoo]?
    var meta: Meta?
}
