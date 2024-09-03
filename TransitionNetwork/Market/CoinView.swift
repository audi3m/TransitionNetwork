//
//  CoinView.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/3/24.
//

import SwiftUI

struct CoinView: View {
    @State private var coinList = [Coin]()
    @State private var searchText = ""
    var filteredList: [Coin] {
        if searchText.isEmpty {
            coinList
        } else {
            coinList.filter {
                $0.market.lowercased().contains(searchText.lowercased()) ||
                $0.koreanName.lowercased().contains(searchText.lowercased()) ||
                $0.englishName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                bannerView()
                listView()
            }
            .listStyle(.plain)
            .navigationTitle("My Money")
            .searchable(text: $searchText)
        }
        .task {
            do {
                let result = try await UpbitAPI.fetchMarkets()
                coinList = result
            } catch {
                print(error)
            }
        }
//        .onAppear {
//            UpbitAPI.fetchAllMarket { list in
//                coinList = list
//            }
//        }
    }
    
    func listView() -> some View {
        ForEach(filteredList, id: \.self) { coin in
            NavigationLink {
                CoinDetailView(coin: coin)
            } label: {
                CoinItemView(coin: coin)
            }
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "01497c"))
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
                    Text("오늘의 마켓")
                        .bold()
                        .foregroundStyle(.white)
                    Text(coinList.randomElement()?.market ?? "")
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
}

struct CoinDetailView: View {
    let coin: Coin
    var body: some View {
        Text(coin.market)
            .font(.title).bold()
        Text(coin.koreanName)
            .font(.title2)
        Text(coin.englishName)
            .font(.title2)
    }
}

struct CoinItemView: View {
    let coin: Coin
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(coin.koreanName)
                    .font(.title3)
                    .bold()
                Text(coin.englishName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(coin.market)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    CoinView()
}
