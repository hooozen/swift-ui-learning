//
//  ContentView.swift
//  Shared
//
//  Created by Hozen on 2021/7/6.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Text("Hello World")
            .titleStyle()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Title: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
