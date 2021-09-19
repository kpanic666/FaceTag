//
//  ContentView.swift
//  FaceTag
//
//  Created by Andrei Korikov on 18.09.2021.
//

import SwiftUI

struct ContentView: View {
  @State private var contacts = [Contact]()
  @State private var currentContact = Contact()
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(contacts) { contact in
            ContactRow(contact: contact)
          }
          .onDelete(perform: deleteContacts)
        }
        .toolbar {
          EditButton()
        }

        NavigationLink(
          destination: EditContactView(contact: $currentContact, runMode: .create)
                          .onDisappear(perform: {
                            if !currentContact.isEmpty {
                              contacts.append(currentContact)
                            }
                          })
        ) {
          Image(systemName: "plus")
            .padding()
            .background(Color.blue.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
        }
      }
      .navigationBarTitle("Face Tag")
    }
  }
  
  func deleteContacts(at offsets: IndexSet) {
    contacts.remove(atOffsets: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
