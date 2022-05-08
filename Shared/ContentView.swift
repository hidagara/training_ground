//
//  ContentView.swift
//  Shared
//
//  Created by Роман on 07.05.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("The Training Polygon").font(.largeTitle).bold()
                NavigationLink(destination: ThemeListView(), label: {
                    Text("Themes")
                })
                FlipCardView(isFaceUp: false)
                
                HStack {
                    Button(action: {
                        print("action")
                    }, label: {
                        Text("Next Card")
                            .font(.title3)
                            .bold()
                            .padding()
                            .foregroundColor(Color(hex: "EE6C4D"))
                            .background(Color(hex: "293241"))
                            .cornerRadius(30.0)
                    })
                    Button(action: {
                        print("action")
                    }, label: {
                        Text("Previous Card")
                            .font(.title3)
                            .bold()
                            .padding()
                            .foregroundColor(Color(hex: "EE6C4D"))
                            .background(Color(hex: "293241"))
                            .cornerRadius(30.0)
                    })
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var imageName = "variables_sample"
    var title = "How To Set Variable"
    var axis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.97, green: 0.85, blue: 0.55))
                .shadow(radius: 5)
            Text(title).font(.title3).bold()
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "square.fill").font(.caption)
                    Spacer()
                    Text(imageName.capitalized)
                        .font(.caption)
                        .foregroundColor(Color(red: 0.09, green: 0, blue: 0.30))
                        .padding(5)
                        .padding(.horizontal, 10)
                        .background(Color(red: 0.97, green: 0.85, blue: 0.55).opacity(0.5))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .cardFlip(isFaceUp: isFaceUp, axis: axis,imgName: imageName)
    }
}

struct FlipCardView: View {
    @State var isFaceUp = false
    @State var imageIndex = 0
    @State var dirIndex = 0
    
    let images = ["variables_sample"]
    let directions: [(CGFloat, CGFloat, CGFloat)] = [(0,1,0), (1,0,0), (1,1,0)]
    
    private func flip() {
        if !isFaceUp {
            imageIndex = (imageIndex + 1) % images.count
            dirIndex = (dirIndex + 1) % directions.count
        }
        isFaceUp.toggle()
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height:80)
            VStack {
                CardView(isFaceUp: isFaceUp,
                         imageName: images[imageIndex],
                         axis: directions[dirIndex])
                    .frame(width:300, height:300)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            flip()
                        }
                    }
            }
            Spacer()
        }
    }
}


struct CardFlip: AnimatableModifier {
    private var rotationAngle: Double
    private var axis:(CGFloat, CGFloat, CGFloat)
    private var imgName: String
    private var isFaceUp: Bool
    
    init(isFaceUp: Bool, axis:(CGFloat, CGFloat, CGFloat), imgName: String) {
        self.isFaceUp = isFaceUp
        rotationAngle = isFaceUp ? 180 : 0
        self.axis = axis
        self.imgName = imgName
    }
    
    var animatableData: Double {
        get { rotationAngle }
        set { rotationAngle = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "E0FBFC")
//                    .opacity(rotationAngle < 90 ? 0.0 : 1.0)
                )
            if isFaceUp {
                Image(imgName)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(15.0)
                    .padding(10)
                    .rotation3DEffect(
                        Angle.degrees(rotationAngle),
                        axis: (self.axis),
                        perspective: 0.3
                    )
                    .onTapGesture {
                        print("TAPPED")
                    }
            } else {
                content
//                    .opacity(rotationAngle < 90 ? 1.0 : 0.0)
            }
            
        }
        .rotation3DEffect(
            Angle.degrees(rotationAngle),
            axis: (self.axis),
            perspective: 0.3
        )
    }
}

extension View {
    func cardFlip(isFaceUp: Bool, axis:(CGFloat, CGFloat, CGFloat), imgName: String) -> some View {
        modifier(CardFlip(isFaceUp: isFaceUp, axis: axis, imgName: imgName))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
