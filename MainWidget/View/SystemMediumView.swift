//
//  SystemMediumView.swift
//  Open
//
//  Created by Arrick Russell Adinoto on 16/07/24.
//

import SwiftUI
import WidgetKit
struct SystemMediumView: View {    
    //var entry:Provider.Entry
    var text:String
    var body : some View{
        GeometryReader{geom in
            ZStack{
                BackgroundView()
                
                Image("WidgetExtraLarge")
                    .resizable()
                    .frame(width:geom.size.width,height:geom.size.height)
                    
                HStack{
                    Spacer()
                    Text(text)
                        .font(.system(size:13))
                        .fontWeight(.bold)
                        .padding(.trailing,15)
                }
                .frame(width:geom.size.width,height:geom.size.height)

            }           .containerBackground(.background,for:.widget)
                .edgesIgnoringSafeArea(.all)
            
        }
        .widgetURL(URL(string: "OpenApp://HomeView")!) .containerBackground(.background,for:.widget)
    }
}

#Preview {
    SystemMediumView(text:"Helo")
}
