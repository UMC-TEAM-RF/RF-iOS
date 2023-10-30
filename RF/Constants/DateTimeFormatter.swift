//
//  DateTimeFormatter.swift
//  RF
//
//  Created by 이정동 on 2023/08/09.
//

import Foundation

enum DateExpression: String {
    /// "HH:mm"
    case time = "HH:mm"
    /// "MM월 dd일"
    case day = "MM월 dd일"
    /// "yyyy. MM. dd."
    case year = "yyyy. MM. dd."
}

class DateTimeFormatter {
    static let shared = DateTimeFormatter()
    private init() {}
    
    /// 서버로부터 받은 시간을 표현하길 원하는 날짜, 시간 문자열로 변환
    /// - Parameters:
    ///   - dateString: 서버로부터 전달받은 Date Time String
    ///   - isCompareCurrentTime: 현재 시간과 비교하여 날짜, 시간을 표시할건지 여부
    ///                           (true: 시간, 월/일, 년/월/일 중 하나로 표기됨 / false: 시간으로 표기됨)
    /// - Returns: 문자열
    func convertStringToDateTime(_ dateString: String?, isCompareCurrentTime: Bool) -> String? {
        guard let string = dateString,
            let date = convertJavaLocalDateTimeStringToDate(string) else { return nil }
        
        if isCompareCurrentTime {
            let dateExpression = compareToTodayDate(date)
            return convertToTime(date, expression: dateExpression.rawValue)
        } else {
            return convertToTime(date, expression: "HH:mm")
        }
    }
    
    /// 서버에서 생성한 시간(Java Local Date Time) 문자열을 Swift Date 타입으로 변환
    /// - Parameter dateString: 서버로부터 전달받은 Date Time String
    /// - Returns: Date 타입
    private func convertJavaLocalDateTimeStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateString)
    }
    
    /// 현재 시간과 비교하여 시간 표현 방식을 결정
    /// - Parameter target: 현재 시간과 비교할 Date 객체
    /// - Returns: Date 표현 방식 (시간, 월/일, 년/월/일 중 하나)
    private func compareToTodayDate(_ target: Date) -> DateExpression {
        let calendar = Calendar.current
        let today = Date()
        
        // day가 같음 == 시,분,초가 다름
        if calendar.isDate(target, equalTo: today, toGranularity: .day) { return .time }
        
        // year이 같음 == 월 또는 일이 다름
        if calendar.isDate(target, equalTo: today, toGranularity: .year) { return .day }
        return .year
    }
    
    /// Date 객체를 표현 하고 싶은 문자열로 변환
    /// - Parameters:
    ///   - date: 문자열로 변환할 Date 객체
    ///   - expression: Date 표현 방식 (DateExpression)
    /// - Returns: 날짜, 시간 문자열
    func convertToTime(_ date: Date, expression: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone.current // == TimeZone(identifier: Asia/Seoul)
        formatter.dateFormat = expression
        return formatter.string(from: date)
    }
}
