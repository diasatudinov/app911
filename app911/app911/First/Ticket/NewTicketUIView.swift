//
//  NewTicketUIView.swift
//  app911
//
//  Created by Dias Atudinov on 14.10.2024.
//

import SwiftUI

struct NewTicketUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    @State var event: Event
    @Binding var ticket: Ticket?
    @State private var selectedImage: UIImage?
    
    @State var name = ""
    @State var date = ""
    @State var location = ""
    @State var position = ""
    @State var price = ""
    @State private var isShowingImagePicker = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea(edges: .bottom)
                .cornerRadius(13)
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        ZStack {
                            HStack {
                                Spacer()
                                Text("Ticket")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            HStack {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                
                                Button {
                                    if !name.isEmpty, !date.isEmpty, !location.isEmpty, !position.isEmpty, !price.isEmpty {
                                        if let image = selectedImage {
                                            let ticket = Ticket(imageData: image.jpegData(compressionQuality: 1.0),name: name, date: date, location: location, rowPosition: position, price: price)
                                            viewModel.createTicket(category, event, ticket)
                                            
                                        } else {
                                            let ticket = Ticket(name: name, date: date, location: location, rowPosition: position, price: price)
                                            viewModel.createTicket(category, event, ticket)
                                           
                                        }
                                        ticket = viewModel.getTicket(category, event)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                } label: {
                                    Text("Create")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                        }.padding(.horizontal)
                    }
                    
                    
                }.frame(height: 50)
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.bottom, 25)
                
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 238, height: 238)
                        .scaledToFill()
                        .padding(.bottom)
                } else {
                    Rectangle()
                        .frame(width: 238, height: 238)
                        .foregroundColor(.black.opacity(0.1))
                        .padding(.bottom)
                }
                
                Text("Select a photo")
                    .foregroundColor(.black)
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
                    .padding(.bottom, 20)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    TextField("Event", text: $name)
                        .padding(.bottom, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Start date and time", text: $date)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Location", text: $location)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Row position", text: $position)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Ticket price", text: $price)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                
                
                Spacer()
            }
            .onDisappear {
                
            }
            
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
}
#Preview {
    NewTicketUIView(viewModel: HomeViewModel(), category: Category(name: "sd", events: []), event: Event(name: "", date: Date(), location: "", status: ""), ticket: .constant(nil))
}

struct EditTicketUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    @State var event: Event
    @Binding var ticket: Ticket?
    @State private var selectedImage: UIImage?
    
    @State var name = ""
    @State var date = ""
    @State var location = ""
    @State var position = ""
    @State var price = ""
    @State private var isShowingImagePicker = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea(edges: .bottom)
                .cornerRadius(13)
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        ZStack {
                            HStack {
                                Spacer()
                                Text("Ticket")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            HStack {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                
                                Button {
                                    if !name.isEmpty, !date.isEmpty, !location.isEmpty, !position.isEmpty, !price.isEmpty {
                                        viewModel.editTicket(category, event, image: selectedImage, name: name, date: date, location: location, position: position, price: price)
                                        
                                        ticket = viewModel.getTicket(category, event)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                } label: {
                                    Text("Edit")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                        }.padding(.horizontal)
                    }
                    
                    
                }.frame(height: 50)
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.bottom, 25)
                
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 238, height: 238)
                        .scaledToFill()
                        .padding(.bottom)
                } else {
                    Rectangle()
                        .frame(width: 238, height: 238)
                        .foregroundColor(.black.opacity(0.1))
                        .padding(.bottom)
                }
                
                Text("Select a photo")
                    .foregroundColor(.black)
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
                    .padding(.bottom, 20)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    TextField("Event", text: $name)
                        .padding(.bottom, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Start date and time", text: $date)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Location", text: $location)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Row position", text: $position)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                    TextField("Ticket price", text: $price)
                        .padding(.vertical, 11)
                    Rectangle()
                        .frame(height: 0.34)
                        .foregroundColor(.black.opacity(0.33))
                        .padding(.trailing, -16)
                    
                }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                
                
                Spacer()
            }
            .onAppear {
                if let ticket = ticket {
                    selectedImage = ticket.image
                    name = ticket.name
                    date = ticket.date
                    location = ticket.location
                    position = ticket.rowPosition
                    price = ticket.price
                }
            }
            
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
}
