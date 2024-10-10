//
//  HomeCell.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

struct HomeCell: View {
    @State var category: Category
    @ObservedObject var viewModel: HomeViewModel
    @State private var showingAlert = false
    
    let onEdit: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                
                HStack {
                    Text(category.name)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    Menu {
                        Button(action: {
                            onEdit()
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(action: {
                            showingAlert = true
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.black)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("A selection of events"),
                            message: Text("This selection will be permanently deleted"),
                            primaryButton: .destructive(Text("Delete")) {
                                withAnimation {
                                    viewModel.deleteCategory(category)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }.padding(.horizontal).padding(.top, 12)
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    NavigationLink {
                        EventsUIView(viewModel: viewModel, category: category)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 121, height: 31)
                                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .bottomRight]))
                                .foregroundColor(.mainRed)
                            HStack(spacing: 5) {
                                Text("Go to events")
                                    .font(.system(size: 13))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16))
                            }.foregroundColor(.white)
                        }
                    }
                }
                
            }
            
        }.frame(height: 85).cornerRadius(10).shadow(radius: 1)
    }
}

#Preview {
    HomeCell(category: Category(name: "Concerts", events: []), viewModel: HomeViewModel(), onEdit: {})
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
