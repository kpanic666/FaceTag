//
//  EditContactView.swift
//  FaceTag
//
//  Created by Andrei Korikov on 19.09.2021.
//

import SwiftUI

enum EditViewRunMode {
  case create, edit
}

struct EditContactView: View {
  @Environment(\.presentationMode) private var presentationMode
  
  @Binding var contact: Contact
  var runMode: EditViewRunMode
  
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var image: Image?
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var company = ""
  
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        ZStack {
          Rectangle()
            .fill(image == nil ? Color.blue.opacity(0.75) : Color.secondary.opacity(0.2))
            .cornerRadius(50.0, antialiased: true)

          if image != nil {
            image?
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap to add a Photo")
              .font(.title2)
              .foregroundColor(Color.white)
          }
        }
        .frame(maxHeight: geo.size.height * 0.5)
        .padding([.top, .leading, .trailing])
        .onTapGesture {
          showingImagePicker = true
        }
        
        Form {
          TextField("First Name", text: $firstName)
          TextField("Last Name", text: $lastName)
          TextField("Company", text: $company)
        }
        .disableAutocorrection(true)
      }
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
        ImagePicker(image: $inputImage)
      })
      .navigationBarTitle(runMode == .create ? "Add Contact" : "Edit Contact")
      .navigationBarItems(trailing: Button("Save", action: save)
                            .disabled(firstName.isEmpty && lastName.isEmpty && company.isEmpty))
      .onAppear(perform: fillViewFieldsFromContact)
    }
  }
  
  func fillContactFromViewFields() {
    contact.firstName = firstName
    contact.lastName = lastName
    contact.company = company
    
    if let inputImage = inputImage {
      contact.image = inputImage
    }
  }
  
  func fillViewFieldsFromContact() {
    if runMode == .edit {
      firstName = contact.firstName
      lastName = contact.lastName
      company = contact.company
      
      if let uiImage = contact.image {
        image = Image(uiImage: uiImage)
      }
    } else {
      contact = Contact()
    }
  }
  
  func save() {
    fillContactFromViewFields()
    presentationMode.wrappedValue.dismiss()
  }
  
  func loadImage() {
    guard let inputImage = inputImage else {
      return
    }
    image = Image(uiImage: inputImage)
  }
}

struct EditContactView_Previews: PreviewProvider {
  static var previews: some View {
    EditContactView(contact: .constant(Contact(firstName: "Garic", lastName: "Harlamov", company: "Comedy Club", image: UIImage(systemName: "plus.app"))), runMode: .edit)
  }
}
