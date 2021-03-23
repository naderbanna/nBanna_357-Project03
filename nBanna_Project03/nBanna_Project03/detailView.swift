//
//  detailView.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import SwiftUI

struct detailView: View {
    @EnvironmentObject var user: User

    
    static func getPass() -> String{
        
        
    }
    
    
    var body: some View {
        
        
        ForEach(user.database.sorted(by: { $0.0 < $1.0 }), id: \.self.key){
            key, value in
            Button(
                action: {user.showingDetail.toggle()},
                   label: {
                    Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
            })
                .sheet(isPresented: $user.showingDetail){
                    //detailView()
                }
        }
        
        
        
    }
}

struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        detailView()
    }
}
