//
//  Tattoo.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

struct TattooDetail: Codable {
    var data: Tattoo?
}

struct Tattoo: Codable {
    var id: UInt?
    var description: String?
    var image: ImageData?
    var counts: TattooCounts?
    var created_at: String?
    var updated_at: String?
    var share_url: String?
    var artist: Artist?
}

struct ImageData: Codable {
    var url: String?
    var width: Float?
    var height: Float?
}

struct Artist: Codable {
    var id: UInt?
    var name: String?
    var image_url: String?
}

struct TattooCounts: Codable {
    var likes: UInt?
    var comments: UInt?
    var pins: UInt?
}
