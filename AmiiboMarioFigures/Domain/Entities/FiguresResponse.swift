//
//  FiguresResponse.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

//MARK: - Response container
struct FiguresResponse: Codable {
    let amiibo: [Figure]
}

//MARK: - Figure response struct
struct Figure: Codable, Equatable {
    
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let imageUrl: String
    let name: String
    let type: String
    let release: ReleaseDates
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
        case amiiboSeries, character, gameSeries, name, release, type
    }
    
    init(amiiboSeries: String, character: String, gameSeries: String, imageUrl: String, name: String, release: ReleaseDates, type: String) {
        self.amiiboSeries = amiiboSeries
        self.character = character
        self.gameSeries = gameSeries
        self.imageUrl = imageUrl
        self.name = name
        self.release = release
        self.type = type
    }
    
    static func == (lhs: Figure, rhs: Figure) -> Bool {
        lhs.amiiboSeries == rhs.amiiboSeries &&
        lhs.character == rhs.character &&
        lhs.gameSeries == rhs.gameSeries &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type
    }
}

struct ReleaseDates: Codable {
    let au: String
    let eu, jp: String?
    let na: String
    
    init(au: String, eu: String, jp: String, na: String) {
        self.au = au
        self.eu = eu
        self.jp = jp
        self.na = na
    }
}
