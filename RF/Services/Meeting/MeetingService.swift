//
//  MeetingService.swift
//  RF
//
//  Created by 정호진 on 2023/08/07.
//

import Foundation
import Alamofire
import RxSwift

final class MeetingService {
    
    func createMeeting(meeting: Meeting, image: Data) -> Observable<Void> {
        let url = "\(Domain.restApi)\(SocketPath.createMeeting)"
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        return Observable.create { observer in
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
            .responseDecodable(of: Response<Meeting>.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    observer.onNext(())
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    /// 모임 정보 API
    func requestMeetingInfo() -> Observable<Meeting> {
        let url = "\(Domain.restApi)\(SocketPath.createMeeting)/179"
        
        return Observable.create { observer in
            AF.request(url, method: .get)
                .validate(statusCode: 200..<201)
                .responseDecodable(of: MeetingData.self) { response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        observer.onNext(data.result)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    /// 모임 리스트 API
    func requestMeetingList(userId: Int) -> Observable<[Meeting]> {
        let url = "\(Domain.restApi)\(SocketPath.meetingList)/\(userId)"
        
        return Observable.create { observer in
            AF.request(url, method: .get)
                .validate(statusCode: 200..<201)
                .responseDecodable(of: MeetingListData.self) { response in
                    print(response)
                    switch response.result {
                    case .success(let data):
                        print(data)
                        observer.onNext(data.result)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}


