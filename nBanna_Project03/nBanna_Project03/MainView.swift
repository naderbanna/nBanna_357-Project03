//
//  MainView.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/20/21.
//

import SwiftUI

class User: ObservableObject{
    @Published var database: [String] = storageHandler.getStorage()

}

struct ChangeView: View {
    @EnvironmentObject var user: User
    
    var body: some View{
        Text("Hello")
    }

}

struct MainView: View {
    var body: some View {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
