//
//  DiscountsView.swift
//  app911
//
//  Created by Dias Atudinov on 01.11.2024.
//

import SwiftUI


enum DiscountTab {
    case allDiscounts, received
}


struct DiscountsView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedTab: DiscountTab = .allDiscounts
    @State private var createDiscount = false
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
                            }.foregroundColor(.mainRed)
                                .font(.system(size: 17, weight: .regular))
                            
                            
                        }
                        Spacer()
                        
                    }
                }.padding(.bottom, 20).padding(.horizontal)
                HStack {
                    Text("Event")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        withAnimation {
                            createDiscount = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.secondRed)
                    }
                }.padding(.bottom, 33).padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    
                    Picker("Select a tab", selection: $selectedTab) {
                        Text("All discounts").tag(DiscountTab.allDiscounts)
                        Text("Received").tag(DiscountTab.received)
                    }.frame(height: 35).pickerStyle(SegmentedPickerStyle()).cornerRadius(7)
                        .onAppear {
                            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                            let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.mainRed]
                            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
                            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
                            UISegmentedControl.appearance().backgroundColor = UIColor(Color.pickerOffGray.opacity(0.24))
                            UISegmentedControl.appearance().selectedSegmentTintColor = .white
                        }
                    
                    
                    
                    if selectedTab == .allDiscounts {
                        ScrollView(showsIndicators: false){
                            VStack {
                                ForEach(viewModel.discounts.filter({ $0.isArchive == false }), id: \.self) { discount in
                                    DiscountCell(viewModel: viewModel, discount: discount)
                                }
                            }.padding()
                        }.padding(.horizontal, -16)
                    } else {
                        ScrollView(showsIndicators: false){
                            VStack {
                                ForEach(viewModel.discounts.filter({ $0.isArchive == true }), id: \.self) { discount in
                                    DiscountCell(viewModel: viewModel, discount: discount)
                                }
                            }.padding()
                        }.padding(.horizontal, -16)
                    }
                    
                    Spacer()
                }.padding(.horizontal)
            }
            
            if createDiscount {
                VStack {
                    Spacer()
                    AddDiscountView(editOrderShow: $createDiscount, viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    DiscountsView(viewModel: HomeViewModel())
}

struct AddDiscountView: View {
    @Binding var editOrderShow: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State var name = ""
    @State var description = ""
    
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
                        
                        HStack {
                            Button {
                                editOrderShow = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Add a task")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Text("Cancel")
                                .foregroundColor(.clear)
                            
                        }.padding(.horizontal)
                    }.frame(height: 50)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray.opacity(0.3))
                   
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        
                        TextField("Name", text: $name)
                            .padding(.bottom, 11)
                        Rectangle()
                            .frame(height: 0.34)
                            .foregroundColor(.black.opacity(0.33))
                            .padding(.trailing, -16)
                        
                        
                        
                        TextField("Description", text: $description)
                            .padding(.vertical, 11)

                        
                    }.padding(20).frame(maxWidth: .infinity).background(Color.black.opacity(0.05)).cornerRadius(10).padding(.horizontal)


                    Spacer()
                    
                    Button {
                        if !name.isEmpty && !description.isEmpty {
                            let discount = Discount(name: name, description: description)
                            viewModel.addDiscount(discount)
                            editOrderShow = false
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 52)
                                .cornerRadius(14)
                                .padding(.horizontal)
                                .foregroundColor(.mainRed)
                            Text("Add")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                
                        }
                    }
                    
                    Spacer()
                    
                    
                }
            }.frame(height: UIScreen.main.bounds.height * 0.4)
                .padding(.bottom, isKeyboardVisible ? 0 : -35)
        
        
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
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    
}
