//
//  EventsUIView.swift
//  app911
//
//  Created by Dias Atudinov on 10.10.2024.
//

import SwiftUI

enum Tab {
    case concerts, story
}

struct EventsUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    @State private var selectedTab: Tab = .concerts
    @State private var editEventShow = false
    @State private var createEventShow = false
    
    @State var selectedEvent: Event? = nil
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                ZStack {
                    
                    HStack {
                        Text("Events")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Label")
                            }.foregroundColor(.mainRed)
                                .font(.system(size: 17, weight: .regular))
                            
                            
                        }
                        Spacer()
                        Button {
                            createEventShow = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.mainRed)
                                .font(.system(size: 17, weight: .regular))
                            
                            
                        }
                    }
                }.padding(.bottom, 20)
                
                Picker("Select a tab", selection: $selectedTab) {
                    Text("Concerts").tag(Tab.concerts)
                    Text("Story").tag(Tab.story)
                }.frame(height: 35).pickerStyle(SegmentedPickerStyle()).cornerRadius(7)
                    .onAppear {
                        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.mainRed]
                        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
                        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
                        UISegmentedControl.appearance().backgroundColor = UIColor(Color.pickerOffGray.opacity(0.24))
                        UISegmentedControl.appearance().selectedSegmentTintColor = .white
                    }
                
               
                    
                    if selectedTab == .concerts {
                        if category.events.filter({ $0.isArchive == false }).isEmpty {
                            VStack(spacing: 10) {
                                Text("This selection is empty")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                Text("Create an event card \nand attach your ticket")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 15)
                                
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.black.opacity(0.05))
                                    .font(.system(size: 100, weight: .regular))
                            }.padding(.bottom, 25).padding(.top, 50)
                        } else {
                            ScrollView(showsIndicators: false){
                                VStack {
                                    ForEach(category.events.filter({ $0.isArchive == false }), id: \.self) { event in
                                        EventCell(viewModel: viewModel, category: category, event: event, onEdit: {
                                            selectedEvent = event
                                            editEventShow = true
                                        })
                                    }
                                }.padding()
                            }.padding(.horizontal, -16)
                        }
                    } else {
                        if category.events.filter({ $0.isArchive == true }).isEmpty {
                            VStack(spacing: 10) {
                                Text("This selection is empty")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                Text("Create an event card \nand attach your ticket")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 15)
                                
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.black.opacity(0.05))
                                    .font(.system(size: 100, weight: .regular))
                            }.padding(.bottom, 25).padding(.top, 50)
                        } else {
                            ScrollView(showsIndicators: false){
                                VStack {
                                    ForEach(category.events.filter({ $0.isArchive == true }), id: \.self) { event in
                                        EventCell(viewModel: viewModel, category: category, event: event, onEdit: {
                                            selectedEvent = event
                                            editEventShow = true
                                        })
                                    }
                                }.padding()
                            }.padding(.horizontal, -16)
                        }
                    }
                
            Spacer()
            }.padding(.horizontal)
            
            if createEventShow {
                CreateEvent(editOrderShow: $createEventShow, viewModel: viewModel, category: category)
            }
            
            if editEventShow {
                if let event = selectedEvent {
                    EditEvent(editOrderShow: $editEventShow, viewModel: viewModel, category: category, event: event)
                }
            }
        }
    }
}

#Preview {
    EventsUIView(viewModel: HomeViewModel(), category: Category(name: "Concerts", events: [Event(name: "Chase Atlantic", date: Date(), location: "The Pavilion At Toyota Music Factory", status: "Used", ticket: nil)]))
}


struct CreateEvent: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    
    @State var name = ""
    @State var date = Date()
    @State var location = ""
    @State var status = ""
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
    var body: some View {
        
        VStack {
            
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(13)
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        
                        HStack {
                            Button {
                                editOrderShow = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Event")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                if !name.isEmpty, !location.isEmpty, !status.isEmpty {
                                    let event = Event(name: name, date: date, location: location, status: status)
                                    viewModel.addEvent(category, event)
                                    editOrderShow = false
                                }
                            } label: {
                                Text("Create")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }.padding(.horizontal)
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                        .padding(.bottom, 25)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Name", text: $name)
                            .padding(11).padding(.horizontal, 5)
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        
                        Text(formattedDate(date: date))
                            .padding(11).padding(.horizontal, 5)
                            .onTapGesture {
                                withAnimation {
                                    datePickerShow.toggle()
                                }
                            }
                        if datePickerShow {
                            
                            DatePicker(
                                "Choose your date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .background(Color.clear)
                            
                        }
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        TextField("Location", text: $location)
                            .padding(11).padding(.horizontal, 5)
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        
                        TextField("Status", text: $status)
                            .padding(11).padding(.horizontal, 5)
                    }.background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                       
                    
                    
                    
                    
                    
                }
            }.frame(height: UIScreen.main.bounds.width * 0.9)
                .padding(.bottom, isKeyboardVisible ? 0 : -35)
            
            
        
        }
        
        .onAppear {
            // Подписываемся на уведомления о клавиатуре
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = false
            }
        }
        .onDisappear {
            // Отписываемся от уведомлений, чтобы избежать утечек памяти
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}


struct EditEvent: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    @State var event: Event
    @State var name = ""
    @State var date = Date()
    @State var location = ""
    @State var status = ""
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
    var body: some View {
        
        VStack {
            
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(13)
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondRed)
                            .frame(height: 50)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                        
                        HStack {
                            Button {
                                editOrderShow = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Event")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                if !name.isEmpty, !location.isEmpty, !status.isEmpty {
                                    
                                    viewModel.editEvent(category, event, name: name, date: date, location: location, status: status)
                                    
                                    editOrderShow = false
                                }
                            } label: {
                                Text("Edit")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }.padding(.horizontal)
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                        .padding(.bottom, 25)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Name", text: $name)
                            .padding(11).padding(.horizontal, 5)
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        
                        Text(formattedDate(date: date))
                            .padding(11).padding(.horizontal, 5)
                            .onTapGesture {
                                withAnimation {
                                    datePickerShow.toggle()
                                }
                            }
                        if datePickerShow {
                            
                            DatePicker(
                                "Choose your date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .background(Color.clear)
                            
                        }
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        TextField("Location", text: $location)
                            .padding(11).padding(.horizontal, 5)
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(.black.opacity(0.36))
                            .padding(.leading)
                        
                        TextField("Status", text: $status)
                            .padding(11).padding(.horizontal, 5)
                    }.background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                       
                    
                    
                    
                    
                    
                }
            }.frame(height: UIScreen.main.bounds.width * 0.9)
                .padding(.bottom, isKeyboardVisible ? 0 : -35)
                
            
            
        
        }
        
        .onAppear {
            
            name = event.name
            date = event.date
            location = event.location
            status = event.status
            
            
            // Подписываемся на уведомления о клавиатуре
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                isKeyboardVisible = false
            }
        }
        .onDisappear {
            // Отписываемся от уведомлений, чтобы избежать утечек памяти
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}
