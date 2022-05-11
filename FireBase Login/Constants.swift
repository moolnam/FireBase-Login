//
//  Constants.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/09.
//

import Foundation

struct K {
    static let cellIdentifier: String = "ReusableCell"
    static let appName: String = "Chat App"
    static let loginToChat: String = "LoginToChat"
    static let registerToChat: String = "RegisterToCaht"
    static let cellNibName: String = "MessageCell"
    
    
    struct FStore {
        static let collectionName: String = "messages"
        static let senderField: String = "sender"
        static let bodyField: String = "body"
        static let dateField: String = "date"
        
    }
}
