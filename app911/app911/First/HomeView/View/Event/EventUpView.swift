//
//  EventUpView.swift
//  app911
//
//  Created by Dias Atudinov on 31.10.2024.
//

import SwiftUI

struct EventUpView: View {
    @ObservedObject var viewModel: HomeViewModel
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
                }.padding(.bottom, 33).padding(.horizontal)
                ScrollView {
                    HStack {
                        Text("Statistics")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondRed)
                            
                        }
                    }.padding(.bottom, 10)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.05))
                            .cornerRadius(16)
                        
                        VStack {
                            
                            HStack(spacing: 22) {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 299 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("300")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 599 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("600")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 899 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("900")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 1199 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("1200")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 46)
                                            .foregroundColor(.secondBg)
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 25, weight: .regular))
                                            .foregroundColor(viewModel.tasks.count * 50 > 1499 ? .mainRed : .white.opacity(0.3))
                                    }
                                    Text("1500")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                
                                
                            }.padding(.horizontal, 20)
                            VStack(spacing: 8) {
                                ProgressView(value: Float16(viewModel.tasks.count * 50), total: 1500)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .accentColor(.mainRed)
                                    .cornerRadius(15)
                                    .scaleEffect(y: 2.5, anchor: .center)
                                    .padding(.horizontal, 30)
                                HStack {
                                    Text("Points received")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                    Spacer()
                                    
                                    Text("Total points")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.black.opacity(0.5))
                                }.padding(.horizontal, 30)
                            }.padding(.bottom, 25)
                            
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 52)
                                        .foregroundColor(.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.secondRed)
                                        )
                                    
                                    HStack {
                                        Image(systemName: "rosette")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.secondRed)
                                        Text("\(viewModel.tasks.count * 50) p")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.secondRed)
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(height: 52)
                                            .foregroundColor(.mainRed)
                                            .cornerRadius(14)
                                        
                                        HStack {
                                            Image(systemName: "checkmark.seal")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(.white)
                                            Text("Discounts")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                }
                            }.padding(.horizontal, 20)
                            
                        }
                    }.frame(height: 224)
                    
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
                        
                    } else {
                        
                    }
                    
                    Spacer()
                }.padding(.horizontal)
            }
        }
    }
}

#Preview {
    EventUpView(viewModel: HomeViewModel())
}
