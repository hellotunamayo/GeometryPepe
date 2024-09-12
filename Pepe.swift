//
//  Pepe.swift
//  GeometryPepe
//
//  Created by Minyoung Yoo on 9/10/24.
//

import SwiftUI

extension Color {
    static var pepeColor: Color {
        let color = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1)
        return Color(uiColor: color)
    }
    
    static var pepeMouth: Color {
        let color = UIColor(red: 0.75, green: 0.25, blue: 0, alpha: 1)
        return Color(uiColor: color)
    }
    
    static var pepeCloth: Color {
        let color = UIColor(red: 0, green: 0.4, blue: 1, alpha: 1)
        return Color(uiColor: color)
    }
}

struct Pepe: View {
    
    @State private var frameSize: CGFloat = 300
    @State private var eyeHorizontalConstant: CGFloat = 18
    @State private var eyeVerticalConstant: CGFloat = 0
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                eyeHorizontalConstant += value.velocity.width * 0.005
                eyeVerticalConstant += value.velocity.height * 0.005
            }
            .onEnded { value in
                withAnimation(.smooth(extraBounce: 0.7).delay(0.2)) {
                    resetEyePosition()
                }
            }
    }
    
    var body: some View {
        GeometryReader { geometry0 in
            VStack {
                GeometryReader { geometry1 in
                    
                    //Eyes
                    GeometryReader { geometry2 in
                        Rectangle()
                            .fill(.black)
                            .frame(
                                width: geometry2.size.height * 1.3,
                                height: geometry2.size.height
                            )
                            .position(
                                x: geometry2.size.width / 1.5 + eyeHorizontalConstant,
                                y: geometry2.size.height / 2 + eyeVerticalConstant
                            )
                        
                        Rectangle()
                            .fill(.black)
                            .frame(
                                width: geometry2.size.height * 1.3,
                                height: geometry2.size.height
                            )
                            .position(
                                x: geometry2.size.width / 9.5 + eyeHorizontalConstant,
                                y: geometry2.size.height / 2 + eyeVerticalConstant
                            )
                    }
                    .background(.white)
                    .clipped()
                    .frame(
                        width: geometry1.size.width / 2,
                        height: geometry1.size.height / 12
                    )
                    .position(
                        x: geometry1.frame(in: .local).midX,
                        y: geometry1.size.height * 0.27
                    )
                    .zIndex(0.5)
                    
                    //Mouth
                    Rectangle()
                        .fill(Color.pepeMouth)
                        .frame(
                            width: geometry1.size.width / 2.1,
                            height: geometry1.size.height / 12
                        )
                        .position(
                            x: geometry1.frame(in: .local).minX + geometry1.size.width / 1.85,
                            y: geometry1.frame(in: .local).midY - geometry1.size.height / 12
                        )
                        .zIndex(1)
                    
                    //Eyelid
                    HStack(spacing: geometry1.size.width / 16) {
                        Rectangle()
                            .fill(Color.pepeColor)
                            .frame(width: geometry1.size.width / 4,
                                   height: geometry1.size.width / 8)
                        Rectangle()
                            .fill(Color.pepeColor)
                            .frame(width: geometry1.size.width / 4,
                                   height: geometry1.size.width / 8)
                    }
                    .position(
                        x: geometry1.frame(in: .local).midX,
                        y: geometry1.frame(in: .local).minY + geometry1.size.height / 10
                    )
                    
                    //Facebox1
                    Rectangle()
                        .fill(Color.pepeColor)
                        .frame(width: geometry1.size.width * 0.7,
                               height: geometry1.size.width / 4)
                        .position(
                            x: geometry1.frame(in: .local).midX,
                            y: geometry1.size.width / 4
                        )
                    
                    //Facebox2
                    Rectangle()
                        .fill(Color.pepeColor)
                        .frame(width: geometry1.size.width / 1.5,
                               height: geometry1.size.width / 4)
                        .position(
                            x: geometry1.frame(in: .local).midX - geometry1.size.width * 0.1,
                            y: geometry1.size.width / 3
                        )
                    
                    //Facebox3
                    Rectangle()
                        .fill(Color.pepeColor)
                        .frame(width: geometry1.size.width / 1.5,
                               height: geometry1.size.width / 5)
                        .position(
                            x: geometry1.frame(in: .local).minX + geometry1.size.width / 2.7,
                            y: geometry1.size.width / 2.3
                        )
                    
                    //Cloth
                    Rectangle()
                        .fill(Color.pepeCloth)
                        .frame(width: geometry1.size.width / 1.5,
                               height: geometry1.size.width / 2)
                        .position(
                            x: geometry1.frame(in: .local).minX + geometry1.size.width / 2.7,
                            y: geometry1.frame(in: .local).midY + geometry1.size.width / 4
                        )
                }
                .frame(width: frameSize, height: frameSize)
            }
            .frame(minHeight: geometry0.size.width)
            .position(
                x: geometry0.frame(in: .local).midX,
                y: geometry0.frame(in: .local).midY
            )
            .clipped()
            .gesture(dragGesture)
        }
    }
    
    func resetEyePosition() {
        eyeHorizontalConstant = 18
        eyeVerticalConstant = 0
    }
}

#Preview {
    Pepe()
}
