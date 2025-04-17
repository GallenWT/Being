//
//  SystemSmallView.swift
//  Open
//
//  Created by Arrick Russell Adinoto on 16/07/24.
//

import SwiftUI
import WidgetKit

struct SystemSmallView: View {
    var entry: Provider.Entry
    var body: some View {
        GeometryReader{geom in
            ZStack{
                BackgroundView()
                Image(entry.img)
                    .resizable()
                    .frame(width:geom.size.width,height:geom.size.height)
                VStack(alignment:.center){
                    Text(entry.title)
                        .font(.system(size:10)).multilineTextAlignment(.center)
                        .offset(y:25)
                        .fontWeight(.bold)
                    Text(entry.desc)
                        .font(.system(size:8)).multilineTextAlignment(.center)
                        .padding(.top,20)
                        .fontWeight(.regular)
                    Spacer()
                }
            }
            .frame(width:geom.size.width,height:geom.size.height)
        }
    }
}

