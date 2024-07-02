//
//  Movie.swift
//  Domain
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public struct Movie {
    public let id: Int?
    public let title: String?
    public let releaseDate: String?
    public let posterURL: URL?
    
    public init(id: Int?, title: String?, releaseDate: String?, posterURL: URL?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterURL = posterURL
    }
}
