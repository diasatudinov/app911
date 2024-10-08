//
//  ReOnboardingUIView.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

struct ReOnboardingUIView: View {
    @State private var pageNum: Int = 1
    @State private var showSheet = false
    @AppStorage("signedUP") var signedUP: Bool = false
    
    var body: some View {
        if !signedUP {
            ZStack {
                Color.onboardingBG
                    .ignoresSafeArea()
                Image("img-onboardingBG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        switch pageNum {
                        case 1: Image("app911Screen1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                            
                        case 2: Image("app911Screen2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                        case 3: Image("app911Screen3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                        default:
                            Image("appScreen3")
                                .resizable()
                                .frame(height: 549)
                                .ignoresSafeArea()
                        }
                        
                    }
                    
                    
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Rectangle()
                                .fill(pageNum == 1 ? Color.white : Color.white.opacity(0.5))
                                .frame(width: pageNum == 1 ? 16 : 8, height: 8)
                                .cornerRadius(50)
                            
                            Rectangle()
                                .fill(pageNum == 2 ? Color.white : Color.white.opacity(0.5))
                                .frame(width: pageNum == 2 ? 16 : 8, height: 8)
                                .cornerRadius(19)
                            
                            Rectangle()
                                .fill(pageNum == 3 ? Color.white : Color.white.opacity(0.5))
                                .frame(width: pageNum == 3 ? 16 : 8, height: 8)
                                .cornerRadius(19)
                            Spacer()
                        }.padding(.horizontal)
                        HStack(alignment: .top) {
                            switch pageNum {
                            case 1:
                                VStack(spacing: 12) {
                                    Text("Create a list of \nscheduled \nevents and \ntrack progress")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.leading)
                                    
                                }.foregroundColor(.white)
                            case 2:
                                VStack(spacing: 12) {
                                    Text("Keep an archive \nof your events \nto remember \nthe highlights")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.leading)
                                    
                                }.foregroundColor(.white)
                            case 3:
                                VStack(spacing: 12) {
                                    Text("Scan and store \nall your electronic \nand paper \ntickets in the app")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.leading)
                                    
                                }.foregroundColor(.white)
                            default:
                                Text("Save information about \nyour favorite routes")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .frame(height: 70)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                
                            }
                            Spacer()
                            Button {
                                if pageNum < 3 {
                                    pageNum += 1
                                } else {
                                    signedUP = true
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundColor(.black)
                                    
                            }.frame(width: UIScreen.main.bounds.width / 4.6, height: UIScreen.main.bounds.width / 4.6).background(Color.white)
                                .cornerRadius(20).padding(.horizontal, 14)
                        }.padding()
                        
                        
                    }.padding(.bottom, 32)
                    
                    
                }
            }
            
        } else {
            // TabUIView()
        }
    }
}

#Preview {
    ReOnboardingUIView()
}
