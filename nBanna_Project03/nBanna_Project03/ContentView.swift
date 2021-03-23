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
    @Published var keySelected: String = ""
    @Published var showingDetail = false
    
    func delete(at offset: IndexSet){
        let dKey = Array(database.keys)[offset.first!]
        self.database.removeValue(forKey: dKey)
        storageHandler.setStorage(object: database)
    }

}

struct Encrypt{
    static func translate(l: Character, trans: Int) -> Character{
        if let ascii = l.asciiValue{
            var outputInt = Int(ascii)
            if ascii >= 97 && ascii <= 122{
                outputInt = abs((Int(ascii)-97+trans)%26)+97
            }else if (ascii >= 65 && ascii <= 90){
                outputInt = abs((Int(ascii)-65+trans)%26)+65
            }
            return Character(UnicodeScalar(outputInt)!)
        }
        return Character("")
}
}

struct ViewAllPass: View {
    @EnvironmentObject var user: User
    
    var body: some View{
        List{

            ForEach(user.database.sorted(by: { $0.0 < $1.0 }), id: \.self.key){
                key, value in
                Button(
                    action: {user.showingDetail.toggle()},
                       label: {
                        
                        HStack{
                            Text(key)
//                            let encryptVal = self.user.value
//                            let strShft = 26-encryptVal.count
//                            var newValue = ""
//
//                            for c in encryptVal{
//                                newValue += String(Encrypt.translate(l: c, trans: strShft))
//                           }
                            Text(value)
                                .padding()
                        }
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
                    
            }
        }
    }

}

struct DeletePass: View{
    @EnvironmentObject var user: User
    
    var body: some View{
        List{
            ForEach(user.database.sorted(by: { $0.0 < $1.0 }), id: \.self.key){
                key, value in
                Button(
                    action: {user.showingDetail.toggle()},
                       label: {
                        Text(key)
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
            .padding()
        Button(
            action: {
                if self.user.key != "" && self.user.value != ""{
                    let encryptVal = self.user.value
                    let strShft = encryptVal.count
                    var newValue = ""
                    
                    for c in encryptVal{
                        newValue += String(Encrypt.translate(l: c, trans: strShft))
                    }
                    user.database[user.key] = newValue
                    storageHandler.setStorage(object: user.database)
                    self.user.key = ""
                    self.user.value = ""
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
            ForEach(user.database.sorted(by: { $0.0 < $1.0 }), id: \.self.key){
                key, value in
                Button(
                    action: {user.showingDetail.toggle(); user.keySelected = key},
                       label: {
                        Text(key)
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
                    .sheet(isPresented: $user.showingDetail){
                        detailView()
                    }
            }
        }
    }
}


struct detailView: View{
    @EnvironmentObject var user: User
    

    
    var body: some View{
  
        ForEach(user.database.sorted(by: { $0.0 < $1.0 }), id: \.self.key){
            key, value in
           if(user.keySelected == key){
//                let encryptVal = self.user.value
//                let strShft = 26-encryptVal.count
//                var newValue = ""
//
//                for c in encryptVal{
//                    newValue += String(Encrypt.translate(l: c, trans: strShft))
//                }
                
                Text(value)
            }
            }
        
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

