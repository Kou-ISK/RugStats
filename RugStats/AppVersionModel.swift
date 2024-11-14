//
//  AppVersionModel.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/13.
//

import Foundation
import Combine

// TODO: 自動アップデートの実装 https://qiita.com/0ba/items/6dcc14a5057a982971f5
class AppVersionModel: BaseModelProtcol {
    let host = "itunes.apple.com"
    let basePath = "/"
    var cancellables = Set<AnyCancellable>()
    let params = ["id": "6736402104"]
    let lastCheckedDateKey = "last_checked_date_key"
    
    private func getAppStoreVersion() -> AnyPublisher<Double, Error>{
        return self.resumePublisher(path: "lookup", method: .get, params: params, responseType: AppStoreResponse.self).map{$0.results.isEmpty ? 0.0: NSString(string: $0.results[0].version).doubleValue}
            .eraseToAnyPublisher()
    }
    
    struct AppStoreResponse: Codable {
        let results: [Results]
        
        struct Results: Codable {
            let version: String
        }
    }
    
    /*
     アップデートを促した日を保存する
     */
    func setLastCheckedDate(){
        UserDefaults.standard.set(self.getCurrentDate(), forKey: lastCheckedDateKey)
    }
    
    func getLastCheckedDate() -> Int{
        UserDefaults.standard.integer(forKey: lastCheckedDateKey)
    }
    
    func getCurrentDate() -> Int {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = .current
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: Date())) ?? 0
    }
    
    /*
     アップデートを促すべきならtrueをパブリッシュするメソッド
    */
    func shouldRequestUpdate() -> AnyPublisher<Bool, Never>{
        let lastCheckDate = getLastCheckedDate()
        let currentDate = getCurrentDate()
        
        self.setLastCheckedDate()
        
        /*
         最後に確認した日が今日と同じならアップデートは促さない
        */
        if lastCheckDate == currentDate {
            return Future { promise in
                promise(.success(false))
                return
            }.eraseToAnyPublisher()
        }
        
        return self.getAppStoreVersion()
            .replaceError(with: 0)
            .map{ return $0 > Bundle.appVersion }
            .eraseToAnyPublisher()
    }
}

extension Bundle {
    static var appVersion: Double{
        guard let infoDictionary = Bundle.main.infoDictionary else{
            return 9999.9
        }
        let version = infoDictionary["CFBundleShortVersionString"] as? NSString
        guard let version = version else {
            return 9999.9
        }
        return version.doubleValue
    }
}
