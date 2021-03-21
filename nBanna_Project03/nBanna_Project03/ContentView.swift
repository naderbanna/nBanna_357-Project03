//
//  ContentView.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import SwiftUI

class User: ObservableObject{
    @Published var database: [String: String] = storageHandler.getStorage()
    @Published var key: String = ""
    @Published var value: String = ""
    @Published var showingDetail = false

    func delete(at offsets: IndexSet){
        database.remove(atOffsets: offsets)
        storageHandler.setStorage(input: database)
    }

}

struct ViewAllPass: View {
    @EnvironmentObject var user: User
    
    var body: some View{
        List{
            ForEach(self.user.database, id: \.self){
                item in
                Button(
                    action: {user.showingDetail.toggle()},
                    label: {
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                })
                    .sheet(isPresented: $user.showingDetail){
                        detailView()
                }
            }
            
        }
    }

}

struct DeletePass: View{
    @EnvironmentObject var user: User
    
    var body: some View{
        List{
            ForEach(self.user.database, id: \.self){
                item in
                Button(
                    action: {user.showingDetail.toggle()},
                    label: {
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                })
                    .sheet(isPresented: $user.showingDetail){
                        detailView()
                    }
                }
                .onDelete(perform: user.delete)
            }
        }
    }

struct AddPass: View{
    @EnvironmentObject var user: User
    
    var body: some View{
        TextField("Enter password name", text: $user.key)
            .padding()
        TextField("Enter the password", text: $user.value)
        Button(
            action: {
                if self.user.key != ""{
                    user.database[user.key] = user.value
                    storageHandler.setStorage(input: user.database)
                    self.user.key = ""
                }
            },
            label: {
            Text("Add task")
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .border(Color.black, width: 1)
                .foregroundColor(.black)
                
        })
    }
}

struct ViewPass: View{
    @EnvironmentObject var user: User
    
    var body: some View{
        Text("Click on account to view Password")
        List{
            ForEach(self.user.database, id: \.self){
                item in
                Button(
                    action: {user.showingDetail.toggle()},
                    label: {
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                })
                    .sheet(isPresented: $user.showingDetail){
                        detailView()
                }
            }
        }
    }
}

struct PassDetail: View{
    @EnvironmentObject var user: User
    
    var body: some View{
        
    }
    
}


struct ContentView: View {
    @ObservedObject var user = User()
    @State var words = storageHandler.getStorage()
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Welcome to your Password Manager")
                    .font(.title2)
                    .padding(.vertical, 1)
                Text("Click on a task to perform")
                    .foregroundColor(.secondary)
                
                Divider().padding()
                
                VStack(spacing: 30){
                    NavigationLink(destination: ViewAllPass()){
                        Text("View all Passwords")
                    }
                    
                    NavigationLink(destination: DeletePass()){
                        Text("Delete a Password")
                    }
                    
                    NavigationLink(destination: AddPass()){
                        Text("Add a Password")
                    }
                    
                    NavigationLink(destination: ViewPass()){
                        Text("View a single Password")
                    }
                }
            }
            .navigationBarTitle("Home")
        }
        .environmentObject(user)
    }

}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

