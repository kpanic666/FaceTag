//
//  ContactRow.swift
//  FaceTag
//
//  Created by Andrei Korikov on 18.09.2021.
//

import SwiftUI

struct ContactRow: View {
  let contact: Contact
  
  var body: some View {
    HStack {
      Image(uiImage: contact.image ?? UIImage(systemName: "person.circle")!)
        .resizable()
        .frame(width: 50, height: 50)
        .scaledToFit()
        .clipShape(Circle())
        .padding(2)
        .overlay(
            Circle()
            .stroke(Color.blue, lineWidth: 2)
        )
      
      VStack(alignment: .leading) {
        Text("\(contact.firstName) \(contact.lastName)")
          .font(.headline)
        Text(contact.company)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct ContactRow_Previews: PreviewProvider {
  static var previews: some View {
    ContactRow(contact: Contact(firstName: "Garic", lastName: "Harlamov", company: "Comedy Club", image: UIImage(systemName: "plus.app")))
  }
}
