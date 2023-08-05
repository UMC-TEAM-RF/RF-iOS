//
//  SendEmail.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation

struct MailData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MailRounding
}

struct MailRounding: Codable{
    let mail: Mail
}

// MARK: - Mail
struct Mail: Codable {
    let code, mailAddress, university: String?
    let isAuth: Bool?
    
}

struct MailBody: Codable{
    let mail: String?
    let university: String?
    let code: String?   
}
