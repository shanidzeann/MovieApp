//
//  MovieCellProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation

protocol MovieCellProtocol: AnyObject {
    func setData(title: String, releaseDate: String, imageURL: URL?)
}
