//
//  Meeting.swift
//  RF
//
//  Created by 이정동 on 2023/08/02.
//

import Foundation

struct MeetingData: Codable {
    var result: Meeting
}

struct Meeting: Codable {
    var name: String?   // 모임 명
    var memberCount: Int?   // 모임 인원
    var nativeCount: Int?    // 자국인 멤버 수
    var interests: [String]? // 관심사
    var content: String?    // 소개글
    var rule: [String]?  // 규칙
    var preferAges: String? // 선호 연령대
    var language: String?   // 사용 언어
    var location: String?   // 활동 장소
    var tag: String?    // 태그
    var ownerId: Int?   // 모임 장
    var imageFilePath: String?  // 이미지 주소
}

struct ResponseData: Codable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
}


// MARK: - Test
import Alamofire
import UIKit

class MeetingService {
    
    func createMeeting(meeting: Meeting, image: Data, completion: @escaping ()->()) {
        let url = "\(Bundle.main.REST_API_URL)/party"
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(meeting.name!.data(using: .utf8)!, withName: "name")   // 모임 명
            multipartFormData.append("\(meeting.memberCount!)".data(using: .utf8)!, withName: "memberCount")   // 모임 인원
            multipartFormData.append("\(meeting.nativeCount!)".data(using: .utf8)!, withName: "nativeCount")   // 한국인 멤버 수
            multipartFormData.append(meeting.content!.data(using: .utf8)!, withName: "content")   // 소개글
            multipartFormData.append(meeting.preferAges!.data(using: .utf8)!, withName: "preferAges")   // 선호 연령대
            multipartFormData.append(meeting.language!.data(using: .utf8)!, withName: "language")   // 사용 언어
            multipartFormData.append(meeting.location!.data(using: .utf8)!, withName: "location")   // 활동 장소
            multipartFormData.append("\(meeting.ownerId!)".data(using: .utf8)!, withName: "ownerId")   // 모임 장
            
            // 관심사
            for (key, value) in meeting.interests!.enumerated() {
                multipartFormData.append(value.data(using: .utf8)!, withName: "interests[\(key)]")
            }
            
            // 규칙
            for (key, value) in meeting.rule!.enumerated() {
                multipartFormData.append(value.data(using: .utf8)!, withName: "rule[\(key)]")
            }
            
            // 이미지
            multipartFormData.append(image, withName: "image", fileName: "\(image).jpeg", mimeType: "multipart/form-data")
            
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMeetingInfo(completion: @escaping (Meeting)->()) {
        let url = "\(Bundle.main.REST_API_URL)/party/179"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: MeetingData.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    completion(data.result)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
