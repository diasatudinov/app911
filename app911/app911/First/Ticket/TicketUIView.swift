//
//  TicketUIView.swift
//  app911
//
//  Created by Dias Atudinov on 11.10.2024.
//

import SwiftUI

struct TicketUIView: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    @State var ticket: Ticket
    
    @State var name = ""
    @State var date = Date()
    @State var location = ""
    @State var status = ""
    
    @State var datePickerShow = false
    @State private var isKeyboardVisible = false
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
                                    editOrderShow = false
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button {
                                    if !name.isEmpty, !location.isEmpty, !status.isEmpty {
                                        
                                        
                                        editOrderShow = false
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }.padding(.horizontal)
                        }
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                        .padding(.bottom, 25)
                    
                    if let image = ticket.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 238, height: 238)
                            .padding(.bottom)
                    } else {
                        Rectangle()
                            .frame(width: 238, height: 238)
                            .foregroundColor(.black.opacity(0.1))
                            .padding(.bottom)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Event")
                                .foregroundColor(.black.opacity(0.5))
                            Text(ticket.name)
                                .foregroundColor(.secondRed)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Start date and time")
                                .foregroundColor(.black.opacity(0.5))
                            Text(ticket.date)
                                .foregroundColor(.black)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Location")
                                .foregroundColor(.black.opacity(0.5))
                            Text(ticket.location)
                                .foregroundColor(.secondRed)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Row position")
                                .foregroundColor(.black.opacity(0.5))
                            Text(ticket.rowPosition)
                                .foregroundColor(.black)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Ticket price")
                                .foregroundColor(.black.opacity(0.5))
                            Text(ticket.price)
                        }
                    }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)
                       
                    
                    
                    
                    
                    Spacer()
                }
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

#Preview {
    TicketUIView(editOrderShow: .constant(true), viewModel: HomeViewModel(), ticket: Ticket(name: "Сoncert Chase Atlantic", date: "Oct 16, 2024 at 7:00 PM CDT ", location: "The Pavilion At Toyota Music Factory, 300 Las Colinas Blvd W, Irving, TX 75039", rowPosition: "Row 7, seat 23", price: "$219,33"))
}
