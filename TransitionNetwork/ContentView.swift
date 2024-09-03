//
//  ContentView.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/2/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var showSheet = false
    @State private var showFullScreen = false
    @State private var random = 10
    
    // 반환타입 여러가지 불가 -> @ViewBuilder 붙이면 가능
    // AnyView(View)로 두면 가능
    @ViewBuilder
    var star: some View {
        switch random {
        case 1..<30: Text("작은 숫자")
        case 30..<60: Image(systemName: "airplane")
        case 60..<100: Image(systemName: "scooter")
        default: Image(systemName: "ferry")
        }
    }
    
    // @ViewBuilder 생략되어 있음
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                star
                Button("랜덤 숫자 \(random)") {
                    random = Int.random(in: 1..<100)
                }
                NavigationLink("Navigation Push") {
                    
                }
                Button("Sheet Present") {
                    showSheet.toggle()
                }
                Button("FullScreen Present") {
                    showFullScreen.toggle()
                }
            }
            .padding()
            .navigationTitle("화면전환 테스트")
            .sheet(isPresented: $showSheet) {
                TransitionView()
            }
            .fullScreenCover(isPresented: $showFullScreen) {
                TransitionView()
            }
            .onChange(of: showSheet, perform: { value in
                print(value)
            })
            .onChange(of: showFullScreen, perform: { value in
                print(value)
            })
            .onAppear {
                print("ContentView onAppear")
            }
            .onDisappear {
                print("ContentView onDisappear")
            }
        }
        
    }
}

#Preview {
    ContentView()
}

struct TransitionView: View {
    
    // 네트워크 통신, 데이터베이스 필터링, 더미데이터 작업
    @Environment(\.dismiss) private var dismiss
    
    init() {
        print("TransitionView init")
    }
    
    var body: some View {
        NavigationView {
            Text("화면전환 테스트")
                .onAppear {
                    print("TransitionView onAppear")
                }
                .onDisappear {
                    print("TransitionView onDisappear")
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("닫기") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

// UIKit
final class TestViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UIKit 코드 내에서 SwiftUI 코드 활용
        // UIHostingController
        let vc = UIHostingController(rootView: ContentView())
        present(vc, animated: true)
    }
    
    
    
}
