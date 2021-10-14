//
//  Helper.swift
//  Athan
//
//  Created by Khalid Alhazmi on 10/10/2021.
//

import Foundation

class Helper{
    
    func loadJson<T:Codable>(fileName: String) -> T? {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {return nil}
        let url = URL(fileURLWithPath: path)
        do{
            let JsonData = try Data(contentsOf: url)
            
            guard let data = try? decoder.decode(T.self, from: JsonData) else{
                return nil
            }
            
            return data
        }catch{
            print("Error Happen")
            return nil
        }
        
    }
}
