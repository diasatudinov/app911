//
//  EventCell.swift
//  app911
//
//  Created by Dias Atudinov on 10.10.2024.
//

import SwiftUI

struct EventCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var category: Category
    @State var event: Event
    @State private var showTicket = false
    let onEdit: () -> Void
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Text(event.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        onEdit()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.mainRed)
                    }
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading, spacing: 11) {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 16, weight: .regular))
                        Text(formattedDate(date: event.date))
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    
                    HStack {
                        Image("image-geo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 13)
                        Text(event.location)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .regular))
                        Text(event.status)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                    }
                }.padding(.bottom, 10)
                
                HStack(alignment: .bottom) {
                    Spacer()
                    Button {
                        showTicket = true
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 102, height: 36)
                                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .bottomRight]))
                                .foregroundColor(.mainRed)
                            HStack(spacing: 5) {
                                Text("Ticket")
                                    .font(.system(size: 15, weight: .semibold))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16))
                            }.foregroundColor(.white)
                        }.padding(.trailing, -16)
                    }
                }
            }.padding(.horizontal).padding(.top)
        }.frame(maxWidth: .infinity).overlay(
        RoundedRectangle(cornerRadius: 14)
            .stroke(lineWidth: 1).foregroundColor(.secondRed)
        )
        .sheet(isPresented: $showTicket) {
            TicketUIView(viewModel: viewModel, ticket: event.ticket, category: category, event: event)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    EventCell(viewModel: HomeViewModel(), category: Category(name: "sadasd", events: []), event: Event(name: "Chase Atlantic", date: Date(), location: "The Pavilion At Toyota Music Factory", status: "Used", ticket: nil), onEdit: {})
}
