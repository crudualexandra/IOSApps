//
//  ContentView.swift
//  SkyPulse
//
//  Created by adm on 15.06.2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel
    @Namespace private var cardNamespace

    var body: some View {
        NavigationStack {
            CityListView(namespace: cardNamespace)
                .navigationDestination(for: City.self) { city in
                    CityDetailView(city: city, namespace: cardNamespace)
                }
        }
        .tint(.white)
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherViewModel())
}
