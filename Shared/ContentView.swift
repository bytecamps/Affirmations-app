//
//  ContentView.swift
//  Shared
//
//  Created by Rosalie Wessels on 7/16/22.
//

import SwiftUI

struct ContentView: View {
    @State var affirmation = ""
    var body: some View {
        VStack {
            Spacer()
            Text("\(affirmation)")
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .onAppear(perform: {
                    getAffirmation()
            })
            Spacer()
            Button(action: {getAffirmation()}) {
                Text("Get another")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(20)
            Spacer()
            
        }
        .padding(.horizontal)
    }

    
    func getAffirmation() {
        loadData { (receivedAffirmation) in
            affirmation = receivedAffirmation.affirmation
        }
    }
    
    func loadData(completion: @escaping (Affirmation) ->  ()) {
        
        guard let url = URL(string: "https://www.affirmations.dev") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result = try! JSONDecoder().decode(Affirmation.self, from: data!)
            
            DispatchQueue.main.async {
                print(result)
                completion(result)
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Affirmation : Codable {
    var affirmation : String
}
