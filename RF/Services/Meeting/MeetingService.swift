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
    
    func createMeeting(meeting: Meeting, image: UIImage) -> Observable<Void> {
        let url = "\(Domain.restApi)\(MeetingPath.createMeeting)"
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        let jsonString = convertMeetingToJSONString(meeting: meeting) ?? ""
        let imageData = image.jpegData(compressionQuality: 0.5)!
        
        return Observable.create { observer in
            AF.upload(multipartFormData: { multipartFormData in
                
                // JSON String
                multipartFormData.append(jsonString.data(using: .utf8)!, withName: "postPartyReq", mimeType: "application/json")
                
                // 이미지
                multipartFormData.append(imageData, withName: "file", fileName: "test.png", mimeType: "multipart/form-data")
                
            }, to: url, method: .post, headers: headers)
            .responseDecodable(of: Response<Meeting>.self) { response in
                print(response)
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
        let url = "\(Domain.restApi)\(MeetingPath.createMeeting)/179"
        
        return Observable.create { observer in
            AF.request(url, method: .get)
                .validate(statusCode: 200..<201)
                .responseDecodable(of: Response<Meeting>.self) { response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        if let meeting = data.result {
                            observer.onNext(meeting)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    /// 모임 리스트 API
    func requestMeetingList(userId: Int) -> Observable<[Meeting]> {
        let url = "\(Domain.restApi)\(MeetingPath.meetingList)/\(userId)"
        
        return Observable.create { observer in
            AF.request(url, method: .get)
                .validate(statusCode: 200..<201)
                .responseDecodable(of: Response<[Meeting]>.self) { response in
                    print(response)
                    switch response.result {
                    case .success(let data):
                        print(data)
                        if let meetings = data.result {
                            observer.onNext(meetings)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func convertMeetingToJSONString(meeting: Meeting) -> String? {
        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(meeting)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("JSON 변환 실패: \(error)")
            return nil
        }
    }
}


