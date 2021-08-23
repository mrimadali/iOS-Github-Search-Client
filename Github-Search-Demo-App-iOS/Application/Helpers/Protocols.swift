//
//  Protocols.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import Foundation

protocol SearchDelegate {
    func didSelectItem(at row: Int, item: Item)
}

protocol UserPrefDelegate {
    func likeAction(_ index: Int)
    func dislikeAction(_ index: Int)
}
