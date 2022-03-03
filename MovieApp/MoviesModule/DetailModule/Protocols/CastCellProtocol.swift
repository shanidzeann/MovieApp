//
//  CastCellProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation

protocol CastCellProtocol: AnyObject {
    func setData(profileUrl: URL?, name: String, character: String?)
}
