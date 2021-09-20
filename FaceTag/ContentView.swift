//
//  ContentView.swift
//  FaceTag
//
//  Created by Andrei Korikov on 18.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var contacts = [Contact]()
    @State private var addingContact = Contact()
    
    var body: some View {
        VStack {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(
                        destination: EditContactView(contact: binding(for: contact), runMode: .edit),
                        label: {
                            ContactRow(contact: contact)
                        })
                }
                .onDelete(perform: deleteContacts)
            }
            .toolbar {
                EditButton()
            }
            
            NavigationLink(
                destination: EditContactView(contact: $addingContact, runMode: .create)
                    .onDisappear(perform: {
                        if !addingContact.isEmpty {
                            contacts.append(addingContact)
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
    
    private func binding(for contact: Contact) -> Binding<Contact> {
        guard let contactIndex = contacts.firstIndex(where: { $0.id == contact.id }) else {
            fatalError("Can't find contact in array")
        }
        return $contacts[contactIndex]
    }
    
    private func deleteContacts(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
