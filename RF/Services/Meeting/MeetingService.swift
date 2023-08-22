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
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        let path = MeetingPath.myMeetingList.replacingOccurrences(of: ":userId", with: userId)
        let url = "\(Domain.restApi)\(path)?page=\(page)&size=\(size)&sort=id"
        
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
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        let path = MeetingPath.meetingList.replacingOccurrences(of: ":userId", with: userId)
        let url = "\(Domain.restApi)\(path)?page=\(page)&size=\(size)&sort=id"
        
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
    func createMeeting(meeting: Meeting, image: UIImage) -> Observable<Bool> {
        let url = "\(Domain.restApi)\(MeetingPath.createMeeting)"
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        let jsonString = convertMeetingToJSONString(meeting: meeting) ?? ""
        let imageData = image.jpegData(compressionQuality: 0.5)!
        
        print("jsonString \n\(jsonString)")
        
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
                    observer.onNext(data.isSuccess ?? false)
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
    
    /// 사용자 기반 추천 모임 리스트 불러오기
    /// - Parameters:
    ///   - filter: 개인 모임: "Personal" / 단체 모임: "Group"
    ///   - completion: 추천 모임 리스트 반환
    func requestRecommandPartyList(_ filter: String, completion: @escaping ([Meeting]?)->()) {
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        var url = "\(Domain.restApi)"
        switch filter {
        case "Personal":
            url = "\(url)\(MeetingPath.recommendPersonalMeeting.replacingOccurrences(of: ":userId", with: userId))"
        case "Group":
            url = "\(url)\(MeetingPath.recommendGroupMeeting.replacingOccurrences(of: ":userId", with: userId))"
        default:
            return
        }
        let param: Parameters = ["page": 1, "size": 3]
        
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


