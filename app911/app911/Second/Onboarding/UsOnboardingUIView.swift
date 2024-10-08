//
//  UsOnboardingUIView.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI
import StoreKit

struct UsOnboardingUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isNotificationView: Bool = true
    @State private var pageNum: Int = 1
    @AppStorage("onboardingShowed") var onboardingShowed: Bool = false
    
    var body: some View {
        if !onboardingShowed {
            if pageNum < 3 {
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
                            case 1:
                                VStack {
                                    
                                    Image("firstScreen911")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width)
                                    
                                }
                            case 2: Image("ratings911")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width)
                            default:
                                Image("notifications911")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 500)
                                    .ignoresSafeArea()
                            }
                        }
                        
                        VStack {
                            Spacer()
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(pageNum == 1 ? Color.white : Color.white.opacity(0.5))
                                    .frame(width: pageNum == 1 ? 16 : 8, height: 8)
                                    .cornerRadius(19)
                                
                                Rectangle()
                                    .fill(pageNum == 2 ? Color.white : Color.white.opacity(0.5))
                                    .frame(width: pageNum == 2 ? 16: 8, height: 8)
                                    .cornerRadius(19)
                                Spacer()
                            }.padding(.horizontal)
                            HStack(alignment: .top) {
                                switch pageNum {
                                case 1:
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Start now and earn more")
                                            .font(.system(size: 28, weight: .bold))
                                            .multilineTextAlignment(.leading)
                                        Text("A proven way to make easy money")
                                            .font(.system(size: 16, weight: .regular))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                    }.foregroundColor(.white)
                                    
                                case 2:
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Rate our app \nin the AppStore")
                                            .font(.system(size: 28, weight: .bold))
                                            .multilineTextAlignment(.leading)
                                        Text("Help make the app \neven better")
                                            .font(.system(size: 16, weight: .regular))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                    }.foregroundColor(.white)
                                        .onAppear{
                                            rateApp()
                                        }
                                default:
                                    Text("Don’t miss anything")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                    Text("Don’t miss the most userful information")
                                        .foregroundColor(.white).opacity(0.7)
                                    
                                }
                                Spacer()
                                Button {
                                    if pageNum < 3 {
                                        pageNum += 1
                                    } else {
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
                if isNotificationView {
                    ZStack {
                        Color.onboardingBG
                            .ignoresSafeArea()
                        Image("img-onboardingBG")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                        
                        ZStack {
                            VStack(spacing: 0) {
                                HStack {
                                    Spacer()
                                    Button {
                                        isNotificationView = false
                                    } label : {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30 ,height: 30)
                                                .foregroundColor(.black.opacity(0.2))
                                            Image(systemName: "xmark")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }.padding(.horizontal).padding(.top)
                                Spacer()
                                Image("notifications911")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width)
                                
                                
                            }
                            
                            
                            
                            VStack {
                                Spacer()
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Don’t miss anything")
                                            .font(.system(size: 28, weight: .bold))
                                            .multilineTextAlignment(.leading)
                                        Text("Don’t miss the most userful information")
                                            .font(.system(size: 16, weight: .regular))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                    }.foregroundColor(.white)
                                    
                                    Spacer()
                                    Button {
                                        isNotificationView = false
                                        onboardingShowed = true
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
                    //WebUIView()
                }
            }
        } else {
            // WebUIView()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
}

#Preview {
    UsOnboardingUIView()
}
