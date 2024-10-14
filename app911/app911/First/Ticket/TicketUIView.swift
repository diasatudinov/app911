//
//  TicketUIView.swift
//  app911
//
//  Created by Dias Atudinov on 11.10.2024.
//

import SwiftUI

struct TicketUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var ticket: Ticket?
    @State var category: Category
    @State var event: Event
    @State var name = ""
    @State var date = Date()
    @State var location = ""
    @State var status = ""
    
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
    
    @State private var showCreateTicket = false
    @State private var showEdit = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea(edges: .bottom)
                .cornerRadius(13)
            
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
                            if ticket == nil {
                                Button {
                                    showCreateTicket = true
                                } label: {
                                    HStack(spacing: 2) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text("Create")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                }
                            } else {
                                Menu {
                                    Button(action: {
                                        // Действие для редактирования
                                        showEdit = true
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    
                                    Button(action: {
                                        // Действие для удаления
                                        withAnimation {
                                            viewModel.deleteTicket(category, event)
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
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
                
                if let ticket = ticket {
                    if let image = ticket.image {
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
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Event")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(ticket.name)
                                    .foregroundColor(.secondRed)
                            }
                            Spacer()
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Start date and time")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(ticket.date)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Location")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(ticket.location)
                                    .foregroundColor(.secondRed)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Row position")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(ticket.rowPosition)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Ticket price")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(ticket.price)
                            }
                            Spacer()
                        }
                    }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                    
                    
                } else {
                    
                    VStack(spacing: 10) {
                        Text("No valid tickets")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Text("Add a ticket to your \nevent if you have one")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 15)
                        
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black.opacity(0.05))
                            .font(.system(size: 100, weight: .regular))
                    }.padding(.bottom, 25).padding(.top, 50)
                    
                }
                
                
                Spacer()
            }
        }
        .sheet(isPresented: $showCreateTicket) {
            NewTicketUIView(viewModel: viewModel, category: category, event: event, ticket: $ticket)
        }
        
        .sheet(isPresented: $showEdit) {
            EditTicketUIView(viewModel: viewModel, category: category, event: event, ticket: $ticket)
        }
        
        .onAppear {
            //ticket = viewModel.getTicket(category, event)
            print("APPEARS")
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

#Preview {
    TicketUIView(viewModel: HomeViewModel(), ticket: nil, category: Category(name: "sadsad", events: []), event: Event(name: "", date: Date(), location: "", status: ""))
}
/*Ticket(name: "Сoncert Chase Atlantic", date: "Oct 16, 2024 at 7:00 PM CDT ", location: "The Pavilion At Toyota Music Factory, 300 Las Colinas Blvd W, Irving, TX 75039", rowPosition: "Row 7, seat 23", price: "$219,33")*/
//viewModel: HomeViewModel(), ticket: nil
