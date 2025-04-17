//
//  TodayJournalCardView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftUI

struct TodayJournalCardView:View{
    var img:String
    var title:String
    var desc:String
    var body : some View{
        VStack(spacing:0){
            Image("\(img)")
                .resizable()
                .frame(width:353,height:138)
            HStack{
                VStack(alignment:.leading){
                    Text(title)
                        .font(.system(size:17,weight:.regular))
                    Text(desc)
                        .font(.system(size:15,weight:.regular))
                        .foregroundColor(Color.primaryColorGray)
                        .opacity(0.6)

                }
                Spacer()
                Image(systemName:"chevron.right")
                    .font(.system(size:17,weight:.semibold))
                    .foregroundColor(Color.assetButton)

            }
            .frame(height:60)
            .padding([.leading,.trailing],16)
        }
        .frame(width:353,height:198)
        .background(.calendarBackground)
        .cornerRadius(10)
    }
    

}

#Preview {
    TodayJournalCardView(img:"kategoriThought",title:"End of the Day Reflection",desc:"Think, Learned, and Do Better Tomorrow")
}

