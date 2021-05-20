//
//  DictionaryData.swift
//  dictionaryGetAPI
//
//  Created by ielts-vuive on 15/05/2021.
//

import Foundation

struct DictionaryData: Codable {
    let word: String?
    let phonetics: [Phonetics]
    let meanings: [Meanings]
}

struct Phonetics: Codable {
    let text: String?
    let audio: String?
}

struct Meanings: Codable {
    let definitions: [Definitions]
}

struct Definitions: Codable {
    let definition: String?
}
