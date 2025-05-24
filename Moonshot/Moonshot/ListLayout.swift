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
                        .accessibilityHidden(true)
                        
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .accessibilityLabel(Text(" \(mission.displayName) mission"))
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                            .accessibilityLabel(Text(" Launch date: \(mission.formattedLaunchDate)"))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
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
            .accessibilityLabel("List of moon missions")
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
