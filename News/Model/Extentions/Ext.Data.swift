//
//  Ext.Data.swift
//  Ext.Data
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import Foundation

typealias JSON = [String: Any]

extension Data {
    
    func toJSON() -> JSON {
        
        var json: [String: Any] = [:]
        
        do {
            if let jsonObjc = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON {
                json = jsonObjc
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
