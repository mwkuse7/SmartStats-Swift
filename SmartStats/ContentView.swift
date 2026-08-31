//
//  ContentView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/15/26.
//

import SwiftUI

struct Stat {
    let name: String
    let value: String
}

class Player: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let stats: [Stat]

    init(firstName: String, lastName: String, stats: [Stat]) {
        self.firstName = firstName
        self.lastName = lastName
        self.stats = stats
    }
}

struct ContentView: View {
    @State private var showingPlayerView = false
    @State private var activePlayer: Player? = nil

    var players: [Player] = [
        Player(
            firstName: "Julio",
            lastName: "Rodriguez",
            stats: [
                Stat(name: "BA", value: ".257"),
                Stat(name: "HR", value: "19"),
                Stat(name: "RBI", value: "52"),
                Stat(name: "SLG", value: ".427"),
                Stat(name: "OBP", value: ".324"),
            ]
        ),
        Player(
            firstName: "Cal",
            lastName: "Raleigh",
            stats: [
                Stat(name: "BA", value: ".158"),
                Stat(name: "HR", value: "12"),
                Stat(name: "RBI", value: "43"),
                Stat(name: "SLG", value: ".295"),
                Stat(name: "OBP", value: ".269"),
            ]
        ),
        Player(
            firstName: "Josh",
            lastName: "Naylor",
            stats: [
                Stat(name: "BA", value: ".266"),
                Stat(name: "HR", value: "10"),
                Stat(name: "RBI", value: "44"),
                Stat(name: "SLG", value: ".375"),
                Stat(name: "OBP", value: ".331"),
            ]
        ),
        Player(
            firstName: "Cole",
            lastName: "Young",
            stats: [
                Stat(name: "BA", value: ".262"),
                Stat(name: "HR", value: "15"),
                Stat(name: "RBI", value: "56"),
                Stat(name: "SLG", value: ".407"),
                Stat(name: "OBP", value: ".319"),
            ]
        ),
        Player(
            firstName: "Dominic",
            lastName: "Canzone",
            stats: [
                Stat(name: "BA", value: ".257"),
                Stat(name: "HR", value: "19"),
                Stat(name: "RBI", value: "51"),
                Stat(name: "SLG", value: ".492"),
                Stat(name: "OBP", value: ".332"),
            ]
        ),
        Player(
            firstName: "Randy",
            lastName: "Arozarena",
            stats: [
                Stat(name: "BA", value: ".275"),
                Stat(name: "HR", value: "16"),
                Stat(name: "RBI", value: "52"),
                Stat(name: "SLG", value: ".450"),
                Stat(name: "OBP", value: ".368"),
            ]
        ),
        Player(
            firstName: "J.P.",
            lastName: "Crawford",
            stats: [
                Stat(name: "BA", value: ".212"),
                Stat(name: "HR", value: "10"),
                Stat(name: "RBI", value: "30"),
                Stat(name: "SLG", value: ".345"),
                Stat(name: "OBP", value: ".330"),
            ]
        ),
        Player(
            firstName: "Brendan",
            lastName: "Donovan",
            stats: [
                Stat(name: "BA", value: ".263"),
                Stat(name: "HR", value: "3"),
                Stat(name: "RBI", value: "12"),
                Stat(name: "SLG", value: ".398"),
                Stat(name: "OBP", value: ".353"),
            ]
        ),
        Player(
            firstName: "Brock",
            lastName: "Rodden",
            stats: [
                Stat(name: "BA", value: ".250"),
                Stat(name: "HR", value: "0"),
                Stat(name: "RBI", value: "3"),
                Stat(name: "SLG", value: ".500"),
                Stat(name: "OBP", value: ".200"),
            ]
        ),
        Player(
            firstName: "Victor",
            lastName: "Robles",
            stats: [
                Stat(name: "BA", value: ".264"),
                Stat(name: "HR", value: "0"),
                Stat(name: "RBI", value: "9"),
                Stat(name: "SLG", value: ".320"),
                Stat(name: "OBP", value: ".311"),
            ]
        ),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.teal, .blue],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Button {

                        } label: {
                            Image(systemName: "magnifyingglass.circle")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 25)
                        .padding(.bottom, -25)
                        Spacer()
                        Button {

                        } label: {
                            Image(systemName: "slider.horizontal.2.square")
                                .font(.title)
                                .foregroundColor(.black)

                        }
                        .padding(.trailing, 25)
                        .padding(.bottom, -25)
                    }
                    ScrollView(.vertical) {
                        HStack {
                            VStack {
                                ForEach(players, id: \.id) { player in
                                    HStack {
                                        Button {
                                            // Slide in separate view to show player data
                                            activePlayer = player
                                            showingPlayerView = true
                                        } label: {
                                            Image(
                                                "\(player.firstName) \(player.lastName)"
                                            )
                                            .resizable()
                                            .frame(width: 70, height: 50)
                                            Text(
                                                "\(String(player.firstName.first ?? " ")). \(player.lastName)"
                                            )
                                            .foregroundStyle(.black)
                                        }

                                        Spacer()
                                    }
                                }
                            }
                            .padding(.leading, 10)

                            ScrollView(.horizontal) {
                                VStack(spacing: 25) {
                                    ForEach(players, id: \.id) { player in

                                        HStack {
                                            // ForEach stat in stats
                                            ForEach(player.stats, id: \.name) {
                                                stat in
                                                VStack {
                                                    Text(stat.name)
                                                        .font(
                                                            .footnote.italic()
                                                        )
                                                    Text("\(stat.value)")
                                                        .font(
                                                            .subheadline.bold()
                                                        )
                                                }
                                                .frame(width: 35)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.grouped)
                    .padding(.top, 30)

                    Spacer()

                    VStack {
                        HStack {
                            Button {

                            } label: {
                                Image(systemName: "figure.baseball")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Button {

                            } label: {
                                Image(systemName: "star.fill")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Button {

                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 30)
                        .background(.ultraThinMaterial)
                    }
                }
                .padding(.top, -25)
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .navigationTitle("SmartStats")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(item: $activePlayer) { player in
            PlayerView(player: player)
        }
    }
}

#Preview {
    ContentView()
}
