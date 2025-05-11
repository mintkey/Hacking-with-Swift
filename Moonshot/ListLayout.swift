//
//  ListLayout.swift
//  Moonshot
//
//  Created by Helen Dempsey on 4/27/25.
//

import SwiftUI

struct ListLayout: View {
    @State private var selectedMission: Mission?
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        NavigationStack {
            List(missions) { mission in
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .listRowBackground(Color.darkBackground)
                .onTapGesture {
                    selectedMission = mission
                }
            }
            .listStyle(.plain)
            .padding([.horizontal, .bottom])
        }
        .navigationDestination(item: $selectedMission) { mission in
                MissionView(mission: mission, astronauts: astronauts)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    ListLayout(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
