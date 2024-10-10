//
//  HomeUIView.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

struct HomeUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var activeEvent = ""
    @State var activeEventShow = false
    
    @State var totalEvent = ""
    @State var totalEventShow = false
    
    @State var pastEvent = ""
    @State var pastEventShow = false
    
    @State var moneySpent = ""
    @State var moneySpentShow = false
    
    @State var categoryName = ""
    @State var categoryNameShow = false
    @State var categoryNameEditShow = false
    @State var selectedCategory: Category? = nil
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Home")
                            .font(.system(size: 34, weight: .bold))
                        Spacer()
                    }.padding(.bottom, 18)
                        
                    VStack {
                        HStack {
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.secondBg)
                                    .cornerRadius(14)
                                VStack(alignment: .leading) {
                                    Text("Active events")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("\(viewModel.activeEvent)")
                                        .foregroundColor(.secondRed)
                                        .font(.system(size: 34, weight: .bold))
                                    Button {
                                        activeEventShow = true
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                            .padding(4).padding(.horizontal)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.mainRed)
                                            )
                                    }
                                }
                                
                            }.frame(height: 147)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.secondBg)
                                    .cornerRadius(14)
                                VStack(alignment: .leading) {
                                    Text("Total events")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("\(viewModel.totalEvent)")
                                        .foregroundColor(.secondRed)
                                        .font(.system(size: 34, weight: .bold))
                                    Button {
                                        totalEventShow = true
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                            .padding(4).padding(.horizontal)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.mainRed)
                                            )
                                    }
                                }
                                
                            }.frame(height: 147)
                        }
                        
                        HStack {
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.secondBg)
                                    .cornerRadius(14)
                                VStack(alignment: .leading) {
                                    Text("Past events")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("\(viewModel.pastEvent)")
                                        .foregroundColor(.secondRed)
                                        .font(.system(size: 34, weight: .bold))
                                    Button {
                                        pastEventShow = true
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                            .padding(4).padding(.horizontal)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.mainRed)
                                            )
                                    }
                                }
                                
                            }.frame(height: 147)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.secondBg)
                                    .cornerRadius(14)
                                VStack(alignment: .leading) {
                                    Text("Money spent")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("$\(String(format: "%.2f",viewModel.moneySpent))")
                                        .foregroundColor(.secondRed)
                                        .font(.system(size: 34, weight: .bold))
                                    Button {
                                        moneySpentShow = true
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                            .padding(4).padding(.horizontal)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.mainRed)
                                            )
                                    }
                                }
                                
                            }.frame(height: 147)
                        }
                    }.padding(.bottom,25)
                    
                    HStack {
                        Text("A selection of events")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                        Button {
                            categoryNameShow = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.mainRed)
                                .font(.system(size: 20, weight: .regular))
                        }
                    }.padding(.bottom)
                    
                    if viewModel.categories.isEmpty {
                        VStack(spacing: 10) {
                            Text("The subfolder is empty")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                            Text("Add a category to make it even \neasier to track your progress")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black.opacity(0.5))
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 15)
                            
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.black.opacity(0.05))
                                .font(.system(size: 100, weight: .regular))
                        }.padding(.bottom, 25).padding(.top, 50)
                    } else {
                        VStack(spacing: 10) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                HomeCell(category: category, viewModel: viewModel, onEdit: {
                                    selectedCategory = category
                                    categoryNameEditShow = true
                                })
                            }
                        }.padding(.bottom, 25)
                        
                    }
                    
                    HStack {
                        Text("More")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }.padding(.bottom)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            Button {
                                
                            } label: {
                                ZStack(alignment: .top) {
                                    Rectangle()
                                        .foregroundColor(.secondBg)
                                        .cornerRadius(14)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Usage Policy")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        Image(systemName: "doc.text.magnifyingglass")
                                            .font(.system(size: 35, weight: .regular))
                                            .foregroundColor(.secondRed)
                                            .padding(15)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(lineWidth: 2).foregroundColor(.white)
                                            )
                                    }.padding(.top, 15)
                                    
                                }.frame(width: 180, height: 145)
                            }
                            
                            Button {
                                
                            } label: {
                                ZStack(alignment: .top) {
                                    Rectangle()
                                        .foregroundColor(.secondBg)
                                        .cornerRadius(14)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Rate our app")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        Image(systemName: "heart")
                                            .font(.system(size: 35, weight: .regular))
                                            .foregroundColor(.secondRed)
                                            .padding(15)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(lineWidth: 2).foregroundColor(.white)
                                            )
                                    }.padding(.top, 15)
                                    
                                }.frame(width: 180, height: 145)
                            }
                            
                            Button {
                                
                            } label: {
                                ZStack(alignment: .top) {
                                    Rectangle()
                                        .foregroundColor(.secondBg)
                                        .cornerRadius(14)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Share our app")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        Image(systemName: "square.and.arrow.up")
                                            .font(.system(size: 35, weight: .regular))
                                            .foregroundColor(.secondRed)
                                            .padding(15)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(lineWidth: 2).foregroundColor(.white)
                                            )
                                    }.padding(.top, 15)
                                    
                                }.frame(width: 180, height: 145)
                            }
                            
                        }.padding(.horizontal)
                    }.padding(.horizontal, -16)
                    
                    Spacer()
                }.padding(.horizontal).padding(.top, 40)
            }
            
            if activeEventShow {
                
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            activeEventShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("Active events")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Add new data to your progress")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("15", text: $activeEvent)
                                    .keyboardType(.numberPad)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                        activeEventShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Add") {
                                        if let activeEvent = Int(activeEvent) {
                                            viewModel.editActiveEvent(activeEvent)
                                            activeEventShow = false
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
                
            }
            
            if totalEventShow {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            totalEventShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("Total events")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Add new data to your progress")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("34", text: $totalEvent)
                                    .keyboardType(.numberPad)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                       totalEventShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Add") {
                                        if let totalEvent = Int(totalEvent) {
                                            viewModel.editTotalEvent(totalEvent)
                                            totalEventShow = false
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
                
            }
            
            if pastEventShow {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            pastEventShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("Past events")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Add new data to your progress")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("34", text: $pastEvent)
                                    .keyboardType(.numberPad)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                        pastEventShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Add") {
                                        if let pastEvent = Int(pastEvent) {
                                            viewModel.editPastEvent(pastEvent)
                                            pastEventShow = false
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
                
            }
            
            if moneySpentShow {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            moneySpentShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("Money spent")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Add new data to your progress")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("$1000.0", text: $moneySpent)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                        moneySpentShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Add") {
                                        if let moneySpent = Double(moneySpent) {
                                            viewModel.editMoneySpent(moneySpent)
                                            moneySpentShow = false
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
                
            }
            
            if categoryNameShow {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            categoryNameShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("A selection of events")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Add a new category to your list")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("Concerts", text: $categoryName)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                        categoryNameShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Add") {
                                        if !categoryName.isEmpty {
                                            let category = Category(name: categoryName, events: [])
                                            viewModel.addCategory(category)
                                            categoryNameShow = false
                                            categoryName = ""
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
            }
            
            if categoryNameEditShow {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.5))
                        .onTapGesture {
                            categoryNameEditShow = false
                        }
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.alertBg)
                                .cornerRadius(14)
                                
                                
                            
                            VStack {
                                Text("A selection of events")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Edit category to your list")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 5)
                                TextField("Concerts", text: $categoryName)
                                    .padding(.horizontal, 5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5).foregroundColor(.black.opacity(0.3))
                                    )
                                    .onAppear {
                                        if let category = selectedCategory {
                                            categoryName = category.name
                                        }
                                    }
                                Spacer()
                                HStack(spacing: 0.5) {
                                    Button("Cancel") {
                                        categoryNameEditShow = false
                                    }
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                    Button("Edit") {
                                        if let category = selectedCategory,!categoryName.isEmpty {
                                            viewModel.editCategory(category, name: categoryName)
                                            categoryNameEditShow = false
                                            categoryName = ""
                                        }
                                    }
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(11)
                                    .background(Color.alertBg)
                                    .foregroundColor(.blue)
                                    .padding(.top, 0.5)
                                    
                                }.background(Color.black.opacity(0.3)).clipShape(RoundedCorner(radius: 14, corners: [.bottomRight, .bottomLeft])).padding(.horizontal, -16)
                            }.padding(.horizontal).padding(.top, 20)
                        }.padding(.horizontal, 60)
                            .frame(height: 160)
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeUIView(viewModel: HomeViewModel())
}
