//
//  ItemModel.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import Foundation
import SwiftyJSON

// MARK: - Root
class ItemRoot {
    var totalCount: Int!
    var items = [Item]()
    
    func copyDO(_ value: JSON) {
        totalCount = value["total_count"].intValue
        
        let itemArray = value["items"].arrayValue
        
        for item_obj in itemArray {
            let item = Item()
            item.copyItemDO(item_obj)
            items.append(item)
        }
    }
}

// MARK: - Item
class Item {
    var name: String!
    var language: String?
    var starCount: Int?
    var creationDate: String?
    var description: String?
    var userPref: UserPref = .none
    var owner = Owner()
    
    func copyItemDO(_ value: JSON) {
        name          = value["name"].stringValue
        language      = value["language"].stringValue
        starCount     = value["stargazers_count"].intValue
        creationDate  = value["created_at"].stringValue
        description   = value["description"].stringValue
        let owner_obj = value["owner"]
        owner.copyOwnerDO(owner_obj)
    }
}


// MARK: - Owner

class Owner {
    var loginName: String!
    var avatarURL: String?
    
    func copyOwnerDO(_ value: JSON) {
        loginName = value["login"].stringValue
        avatarURL = value["avatar_url"].stringValue
    }
}

// MARK: - Enum User Pref
enum UserPref {
    case like, dislike, none
}
