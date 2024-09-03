//
//  MoneyView.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/3/24.
//

import SwiftUI

struct MoneyView: View {
    @State private var money = [Money]()
    @State private var banner = Banner()
    
    var body: some View {
        NavigationView {
            List {
                bannerView(banner: banner)
                listView()
            }
            .listStyle(.plain)
            .navigationTitle("My Money")
            .refreshable {
                money = Dummy.money.shuffled()
            }
        }
        .onAppear {
            money = Dummy.money.shuffled()
        }
    }
    
    func listView() -> some View {
        ForEach(money) { item in
            rowView(item)
                .swipeActions {
                    
                }
        }
    }
    
    func bannerView(banner: Banner) -> some View {
        ZStack {
            Rectangle()
                .fill(banner.color)
                .frame(height: 170)
                .overlay(alignment: .leading) {
                    Circle()
                        .foregroundStyle(.black.opacity(0.4))
                        .scaleEffect(CGSize(width: 1.8, height: 1.8))
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("나의 소비내역")
                        .bold()
                        .foregroundStyle(.white)
                    Text(banner.totalFormat) 
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                .shadow(radius: 5)
                
                Spacer()
                Image("mastercard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 30)
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listRowSeparator(.hidden)
    }
    
    func rowView(_ item: Money) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.product)
                    .font(.title3)
                    .bold()
                Text(item.category.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.amountFormat)
                .fontWeight(.semibold)
        }
    }
}


#Preview {
    MoneyView()
}
