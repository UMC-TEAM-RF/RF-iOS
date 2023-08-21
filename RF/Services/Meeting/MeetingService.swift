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
    
    /// 내가 속한 모임 리스트
    func getMyMeetingList(page: Int, size: Int) -> Observable<[Meeting]> {
        let url = "\(Domain.restApi)\(MeetingPath.meetingList)/{userId}/belong??page=\(page)&size=\(size)&sort=id,{desc|asc}"
        
        return Observable.create { observer in
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<MeetingList>.self) { response in
                switch response.result {
                case .success(let data):
                    if let data = data.result?.content {
                        print("getMeetingList\n\(data)")
                        observer.onNext(data)
                    }
                case .failure(let error):
                    observer.onError(error)
                    print("getMeetingList error! \n\(error)")
                }
                
            }
            return Disposables.create()
        }
    }
    
    
    /// 모든 모임 조회
    func getMeetingList(page: Int, size: Int) -> Observable<[Meeting]> {
        let url = "\(Domain.restApi)\(MeetingPath.meetingList)/{userId}/search?page=\(page)&size=\(size)&sort=id,{desc|asc}"
        
        return Observable.create { observer in
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<MeetingList>.self) { response in
                switch response.result {
                case .success(let data):
                    if let data = data.result?.content {
                        print("getMeetingList\n\(data)")
                        observer.onNext(data)
                    }
                case .failure(let error):
                    observer.onError(error)
                    print("getMeetingList error! \n\(error)")
                }
                
            }
        
            return Disposables.create()
        }
    }
    
    /// 모임 생성
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
    func requestMeetingInfo(id: Int) -> Observable<Meeting> {
        let url = "\(Domain.restApi)\(MeetingPath.createMeeting)/\(id)"
        
        return Observable.create { observer in
            AF.request(url, method: .get)
                .validate(statusCode: 200..<201)
                .responseDecodable(of: Response<Meeting>.self) { response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        if var meeting = data.result {
                            let file = EnumFile.enumfile.enumList.value
                            meeting.preferAges = file.preferAges?.filter{$0.key ?? "" == meeting.preferAges ?? ""}.first?.value
                            meeting.language = file.language?.filter{$0.key ?? "" == meeting.language ?? ""}.first?.value
                            observer.onNext(meeting)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    
    /// 사용자가 차단한 모임을 제외한 리스트를 불러옴
    /// - Parameters:
    ///   - userId: 사용자 ID
    ///   - page: Page 번호 (default: 0)
    ///   - size: 가져올 모임 개수 (default: 3)
    func requestMeetingList(userId: Int, page: Int = 0, size: Int = 3, completion: @escaping ([Meeting]?)->()) {
        let path = MeetingPath.meetingList.replacingOccurrences(of: ":userId", with: "1")
        let url = "\(Domain.restApi)\(path)"
        let param: Parameters = ["page": page, "size": size]
        
        AF.request(url, method: .get, parameters: param)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<Page>.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data.result?.content)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// JSON To String
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


