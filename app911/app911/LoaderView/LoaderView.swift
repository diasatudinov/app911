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
    @State var returnBool = false
    let urlString = "https://podlaorlf.space/DQW8QG8G"
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
                    checkURLAndDecide()
                }
                .onDisappear {
                    timer?.invalidate()
                }
                
            }
            
        } else {
            if isWithinTwoDays() {
                ReOnboardingUIView()
                
            } else if getAccess() == false {
                if returnBool {
                    ReOnboardingUIView()
                } else {
                    UsOnboardingUIView()
                }
            } else {
                ReOnboardingUIView()
            }
            
        }
    }
    
    func checkURLAndDecide() {
        
        guard let url = URL(string: urlString) else { return }
        
        // Perform the URL request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let urlResponse = response?.url?.absoluteString {
                
                if urlResponse.contains("google.") {
                    returnBool = urlResponse.contains("google.")
                } else {
                    returnBool = urlResponse.contains("google.")
                }
            }
        }.resume()
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
    
    private func getAccess () -> Bool {
        let deviceData = DeviceInfo.collectData()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        guard !deviceData.isCharging else { return true }
        guard deviceData.batteryLevel < 1 && deviceData.batteryLevel > 0 else { return true }
        guard !deviceData.isVPNActive else { return true }
        return false
    }
    
    func isWithinTwoDays() -> Bool {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 1
        dateComponents.hour = 15
        
        if let today = Calendar.current.date(from: dateComponents) {
          
            if let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: today) {
               
                return Date() <= twoDaysFromNow
            }
        }
        return false
    }
    
}

#Preview {
    LoaderView()
}
