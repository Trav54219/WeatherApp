//
//  ContentView.swift
//  WeatherAppFinal
//
//  Created by Travis Heurtelou on 3/2/21.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack{
            Text("Los Angeles")
                .font(.largeTitle)
                .padding()
            Text("25°")
                .font(.system(size: 70))
                .bold()
            Text("☁️")
                .font(.largeTitle)
                .padding()
            Text("Clear Sky")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView() 
    }
}
