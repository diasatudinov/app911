//
//  TaskCell.swift
//  app911
//
//  Created by Dias Atudinov on 01.11.2024.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var task: Task
    @State private var showTicket = false
    let onEdit: () -> Void
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Text(task.name)
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
                }
                
                Text(task.description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black.opacity(0.7))
                    .frame(maxHeight: 63)
                    
                VStack(alignment: .leading, spacing: 11) {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 16, weight: .regular))
                        Text(formattedDate(date: task.date))
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                        Spacer()
                    }
                    
                    HStack {
                        Image("image-geo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 16)
                            
                        Text(task.location)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    
                    HStack {
                        Image(systemName: "rosette")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.secondRed)
                        Text("+ 50")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    
                }.padding(.bottom, 10)
                
            }.padding(.horizontal).padding(.top).padding(.bottom)
        }.frame(maxWidth: .infinity).overlay(
        RoundedRectangle(cornerRadius: 14)
            .stroke(lineWidth: 1).foregroundColor(.secondRed)
        )
        
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TaskCell(viewModel: HomeViewModel(), task: Task(name: "Concert", location: "The Pavilion At Toyota Music Factory", date: Date(), description: "Go to an event concert with 10 friends. Buy tickets in advance and arrange transportation to the venue."), onEdit: {})
}
