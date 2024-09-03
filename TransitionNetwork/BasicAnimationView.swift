//
//  BasicAnimationView.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/2/24.
//

import SwiftUI

struct CardModel: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let idx: CGFloat
}

struct BasicAnimationView: View {
    
    @State private var showAnimation = false
    let list = [CardModel(name: "신한카드", color: "012a4a", idx: 0),
                CardModel(name: "우리카드", color: "01497c", idx: 1),
                CardModel(name: "KB 국민카드", color: "2a6f97", idx: 2),
                CardModel(name: "현대카드", color: "468faf", idx: 3),
                CardModel(name: "Toss 뱅크", color: "89c2d9", idx: 4)]
    
    
    var body: some View {
        topTitle()
        
        cardView()
            .padding()
        
        Spacer()
        Button("\(showAnimation ? "OFF" : "ON")") {
            withAnimation(.bouncy(duration: 0.5)) {
                showAnimation.toggle()
            }
        }
        .font(.largeTitle)
    }
    
    func cardView() -> some View {
        ScrollView(showsIndicators: false) {
            ForEach(list) { item in
                let a = (item.idx)/(CGFloat(list.count) * 10)
                card(card: item)
                    .offset(y: showAnimation ? 0 : -110 * item.idx)
                    .scaleEffect( CGSize(width: showAnimation ? 1 : (0.9 + a), height: 1.0))
            }
        }
    }
    
    func card(card: CardModel) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(Color(hex: card.color))
            .frame(height: 130)
            .overlay(alignment: .topLeading) {
                Text(card.name)
                    .font(.title3).bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .offset(y: 0)
            .shadow(radius: 2)
    }
    
    func topTitle() -> some View {
        HStack {
            Text("My Cards")
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity, alignment: showAnimation ? .leading : .center)
                .padding()
            
            if showAnimation {
                Button {
                    withAnimation(.bouncy) {
                        showAnimation = false
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.largeTitle)
                        .foregroundStyle(.blackWhite)
                        .padding()
                }
            }
        }
    }
    
}

#Preview {
    BasicAnimationView()
}
