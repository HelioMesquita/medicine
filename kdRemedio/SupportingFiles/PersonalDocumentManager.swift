//
//  PersonalDocumentManager.swift
//  kdRemedio
//
//  Created by Hélio Mesquita on 05/11/18.
//  Copyright © 2018 callidus. All rights reserved.
//

import Foundation

class PersonalDocumentManager {

  var hasDocument: Bool {
    return (get() != nil) ? true : false
  }

  func get() -> String? {
    return UserDefaults.standard.string(forKey: "document")
  }

  func save(document: String) {
    UserDefaults.standard.set(document, forKey: "document")
  }

  func isValid(document: String) -> Bool {
    return document.count >= 10
  }

  func remove() {
    UserDefaults.standard.set(nil, forKey: "document")
  }
}
