//
//  FavoritePlayersView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/29/26.
//

import SwiftUI

struct FavoritePlayersView: View {
    @Environment(FavoriteBatters.self) var favoriteBatters
    @State private var activeBatterColumn = "ops"
    @State private var batterSortOrder = [
        SortDescriptor(\BatterSeason.stat.ops, order: .reverse)
    ]

    @Environment(FavoritePitchers.self) var favoritePitchers
    @State private var activePitcherColumn = "era"
    @State private var pitcherSortOrder = [
        SortDescriptor(\PitcherSeason.stat.era, order: .forward)
    ]

    var body: some View {
        NavigationStack {
            if favoriteBatters.batters.isEmpty && favoritePitchers.pitchers.isEmpty {
                ContentUnavailableView("Add Favorites", systemImage: "person.fill.badge.plus")
                    .navigationTitle("Favorites")
            } else {
                Group {
                    if favoriteBatters.batters.isEmpty == false {
                        ScrollView {
                            HStack(spacing: 0) {
                                BattersView(players: favoriteBatters.batters)
                                
                                ScrollViewReader { proxy in
                                    BatterStatScrollView(
                                        players: favoriteBatters.batters,
                                        activeColumn: activeBatterColumn
                                    )
                                    .onChange(of: activeBatterColumn) { _, newValue in
                                        withAnimation {
                                            proxy.scrollTo(newValue, anchor: .leading)
                                        }
                                        
                                        batterSortOrder = BatterStatAbbreviation.setSortOrder(newValue)
                                    }
                                    .onAppear {
                                        proxy.scrollTo(
                                            activeBatterColumn,
                                            anchor: .leading
                                        )
                                        
                                        batterSortOrder = BatterStatAbbreviation.setSortOrder(activeBatterColumn)
                                    }
                                }
                            }
                        }
                    }
                    if favoritePitchers.pitchers.isEmpty == false {
                        ScrollView {
                            HStack(spacing: 0) {
                                PitchersView(players: favoritePitchers.pitchers)
                                
                                ScrollViewReader { proxy in
                                    PitcherStatScrollView(
                                        players: favoritePitchers.pitchers,
                                        activeColumn: activePitcherColumn
                                    )
                                    .onChange(of: activePitcherColumn) { _, newValue in
                                        withAnimation {
                                            proxy.scrollTo(newValue, anchor: .leading)
                                        }
                                        
                                        pitcherSortOrder = PitcherStatAbbreviation.setSortOrder(newValue)
                                    }
                                    .onAppear {
                                        proxy.scrollTo(activePitcherColumn, anchor: .leading)
                                        
                                        pitcherSortOrder = PitcherStatAbbreviation.setSortOrder(activePitcherColumn)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Favorites")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Batting", selection: $activeBatterColumn) {
                                ForEach(
                                    BatterStatAbbreviation.collection,
                                    id: \.self
                                ) { stat in
                                    Text(
                                        BatterStatAbbreviation.abbreviate(stat)
                                    )
                                    .tag(stat)
                                }
                            }
                            
                            Picker("Pitching", selection: $activePitcherColumn)
                            {
                                ForEach(
                                    PitcherStatAbbreviation.collection,
                                    id: \.self
                                ) { stat in
                                    Text(
                                        PitcherStatAbbreviation.abbreviate(stat)
                                    )
                                    .tag(stat)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritePlayersView()
}
