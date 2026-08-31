//
//  PlayerView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/25/26.
//

import SwiftUI

struct PlayerView: View {
    var player: Player
    
    @State private var isFavorite: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("\(player.firstName) \(player.lastName)")
                        .resizable()
                        .frame(width: 200, height: 150)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(player.firstName) \(player.lastName)")
                            .font(.title.bold())
                            .fontDesign(.rounded)
                            .padding(.trailing, 20)
                        Text("Position #00")
                        Text("Birthplace")
                        Text("Team")
                    }
                    .padding(.top, 10)
                }
                
                Text("2026 Stats")
                    .font(.headline)
                    .padding(20)
                
                HStack {
                    ForEach(player.stats, id: \.self.name) { stat in
                        VStack {
                            Text("\(stat.name)")
                                .font(.headline)
                            Text("\(stat.value)")
                        }
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                
                Text("Other Season Stats")
                    .font(.headline)
                    .padding(20)
                
                Spacer()
            }
            .toolbar {
                Button {
                    isFavorite.toggle()
                } label: {
                    Text("Favorite")
                        .foregroundStyle(.white)
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
                
            }
            .background(.black)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    PlayerView(
        player:
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
            )
    )
}
