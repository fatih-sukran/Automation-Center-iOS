//
//  TestDetailView.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import SwiftUI

struct TestDetailView: View {
    var test: TestMethod
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(test.name)
                    .font(.largeTitle)
                    .padding()

                Button {
                    print("clicked")
                } label: {
                    HStack {
                        Text("Run Test")
                        Image("run_icon")
                            .resizable()
                            .frame(width: 34, height: 34)
                    }
                }
                
                
            Spacer()
            }
        }
    }
    
    
}

#Preview {
    TestDetailView(test: TestMethod(id: 1, name: "Home Page tests"))
}
