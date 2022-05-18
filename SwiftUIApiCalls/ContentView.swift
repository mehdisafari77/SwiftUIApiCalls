//
//  ContentView.swift
//  SwiftUIApiCalls
//
//  Created by Mehdi MMS on 18/05/2022.
//

import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    @Published var courses: [Course] = []
    
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [ weak self ] data, _,
        error in
            guard let data = data, error == nil else {
                return
            }
            // Convert to JSON
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }
            catch {
                print(error)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Courses")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
