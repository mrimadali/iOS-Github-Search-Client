//
//  Constants.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import Foundation
import UIKit

struct AppFont {
    static let regular = "AvenirNext-Regular"
    static let medium  = "AvenirNext-Medium"
    static let italic  = "AvenirNext-Italic"
    static let bold    = "AvenirNext-Bold"
}


struct Device {
   
   static let device     = UIScreen.main.bounds
   static let width      = UIScreen.main.bounds.size.width
   static let height     = UIScreen.main.bounds.size.height
   static let iosVersion = UIDevice.current.systemVersion
}

struct Constants {
    static let likeNotifications      = "like_Notifications"
    static let dislikeNotifications   = "dislike_Notifications"
    static let githubSearchRepo       = "Github Search Repo"
    static let searchGithubRepo       = "Search Github Repo..."
    static let emptySearchMessage     = "Search keyword must be at least 3 characters in length"
    static let navBackButtonTitle     = "Back"
    static let likeButtonTitle        = "👍 Like"
    static let dislikeButtonTitle     = "👎 Dislike"
}
