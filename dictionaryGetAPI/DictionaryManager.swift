//
//  DictionaryManager.swift
//  dictionaryGetAPI
//
//  Created by ielts-vuive on 15/05/2021.
//

import Foundation

protocol DictionaryDelegate {
    
    func updateUI(dictionaryModel: DictionaryModel)
}

struct DictionaryManager {
    
    let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en_US/"
    
    var delegate: DictionaryDelegate?
    
    func getUserInput(wordInput: String) {
        let urlString = "\(baseURL)\(wordInput)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let dictionaryModel = self.parseJSON(with: safeData) {
                        self.delegate?.updateUI(dictionaryModel: dictionaryModel)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(with data: Data) -> DictionaryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([DictionaryData].self, from: data)
            let word = decodedData.first!.word
            let phoneticsText = decodedData.first!.phonetics[0].text
            let phoneticsAudio = decodedData.first!.phonetics[0].audio
            let definition = decodedData.first!.meanings[0].definitions[0].definition
            
            let dictionaryModel = DictionaryModel(word: word ?? "Not Found", phoneticsText: phoneticsText ?? "", phoneticsAudio: phoneticsAudio ?? "", definition: definition ?? "")
            
            return dictionaryModel
            
        } catch {
            print(error)
            return nil
        }
    }
}
