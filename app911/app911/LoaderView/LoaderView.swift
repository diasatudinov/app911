//
//  LoaderView.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

struct LoaderView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    

    var body: some View {
        if isLoadingView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo911")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 64)
                        .padding(.top, UIScreen.main.bounds.height / 10)
                    Spacer()
                    ZStack {
                        
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .accentColor(.mainRed)
                            .cornerRadius(15)
                            .scaleEffect(y: 2.5, anchor: .center)
                            .padding(.horizontal, 92)
                            
                    }
                    HStack {
                        Text("Loading")
                        Text("\(Int(progress))%")
                    }
                    .font(.system(size: 17, weight: .regular))
                  
                    .foregroundColor(.black)
                    .padding(14)
                    .padding(.bottom, UIScreen.main.bounds.height / 6)
                }
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    timer?.invalidate()
                }
                
            }
            
        } else {
            if true {
                
            } else {
                
            }
            
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
    
}

#Preview {
    LoaderView()
}
