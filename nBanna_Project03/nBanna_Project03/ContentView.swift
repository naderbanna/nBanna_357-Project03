//
//  ContentView.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var words = storageHandler.getStorage()
    @State private var word: String = ""
    @State private var showingDetail = false
    @State private var showAll = false
    @State private var showSingle = false
    @State private var addPass = false
    @State private var deletePass = false
    
    
    var body: some View {
        VStack {
            Text("Welcome to your Password Manager")
                .font(.title2)
                .padding(.vertical, 5)
            Text("Click on a task to perform")
                .foregroundColor(.secondary)
            
            Divider().padding()
            
            HStack{
                Button(
                    action: {showAll.toggle()},
                    label: {
                        Text("View all Passwords")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .border(Color.black, width: 1)
                            .foregroundColor(.black)
                })
                .sheet(isPresented: $showAll){
                        viewAllPasswords()
                    }
               
                Button(
                    action: {showSingle.toggle()},
                    label: {
                    Text("View a single Password")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .border(Color.black, width: 1)
                        .foregroundColor(.black)
        
                })
                    .sheet(isPresented: $showSingle){
                        viewSinglePassword()
                    }
                }
            
                HStack{
                    Button(
                        action: {addPass.toggle()},
                        label: {
                        Text("Add a single Password")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .border(Color.black, width: 1)
                            .foregroundColor(.black)
            
                    })
                        .sheet(isPresented: $addPass){
                            addPassword()
                        }
                    Button(
                        action: {deletePass.toggle()},
                        label: {
                        Text("Delete a Password")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .border(Color.black, width: 1)
                            .foregroundColor(.black)
            
                    })
                        .sheet(isPresented: $deletePass){
                            deletePassword()
                        }
                }
            
            
            TextField("Enter a word", text: $word)
                .padding()
            Button(
                action: {
                    if self.word != ""{
                        words.append(self.word)
                        storageHandler.setStoraage(input: words)
                        self.word = ""
                    }
                },
                label: {
                Text("Add task")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .border(Color.black, width: 1)
                    .foregroundColor(.black)
                    
            })
            
            //list of items in words
            List{
                ForEach(self.words, id: \.self){
                    item in
                    Button(
                        action: {showingDetail.toggle()},
                        label: {
                            Text(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    })
                    .sheet(isPresented: $showingDetail){
                            detailView()
                        }
                }
                .onDelete(perform: delete)
            }
            
            
        }
    }
    func delete(at offsets: IndexSet){
        words.remove(atOffsets: offsets)
        storageHandler.setStoraage(input: words)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

