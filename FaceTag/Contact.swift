//
//  Contact.swift
//  FaceTag
//
//  Created by Andrei Korikov on 18.09.2021.
//

import Foundation
import UIKit

struct Contact: Identifiable {
  let id: UUID
  var firstName = ""
  var lastName = ""
  var company = ""
  var image: UIImage?
  
  var isEmpty: Bool {
    firstName.isEmpty && lastName.isEmpty && company.isEmpty
  }
  
  init() {
    id = UUID()
  }
  
  init(firstName: String, lastName: String, company: String, image: UIImage?) {
    self.id = UUID()
    self.firstName = firstName
    self.lastName = lastName
    self.company = company
    self.image = image
  }
}
