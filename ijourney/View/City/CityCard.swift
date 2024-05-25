//
//  CityCard.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CityCard: View {
  
  @EnvironmentObject var cityViewModel: CityViewModel

  @State private var dominantColor: Color = Color(UIColor.systemFill)
  
  var city: City
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        HStack(alignment: .top) {
          VStack(alignment: .leading) {
            Text(city.name)
              .font(.system(.title, design: .serif))
              .fontWeight(.bold)
            Text(city.countryName)
              .foregroundStyle(.secondary)
          }
          
          Spacer()
        }
        .padding([.leading, .trailing])
        
        Image(city.name)
          .resizable()
          .scaledToFill()
          .frame(width: (UIScreen.main.bounds.width - 65), height: 130)
          .clipShape(.rect(cornerRadius: 10))
          .onAppear {
            sampleColorFromImage(imageName: city.name)
          }
      }
      
    }
    .frame(width: (UIScreen.main.bounds.width - 40), height: 220)
    .clipShape(.rect(cornerRadius: 20))
    .background(
      GradientBackground(color: dominantColor)
        .blur(radius: 1)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 7)
    )
  }
  
  func sampleColorFromImage(imageName: String) {
    guard let uiImage = UIImage(named: imageName) else { return }
    let ciImage = CIImage(image: uiImage)
    
    let context = CIContext()
    let filter = CIFilter(name: "CIAreaAverage")!
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    filter.setValue(CIVector(cgRect: ciImage!.extent), forKey: kCIInputExtentKey)
    
    if let outputImage = filter.outputImage {
      var bitmap = [UInt8](repeating: 0, count: 4)
      context.render(outputImage,
                     toBitmap: &bitmap,
                     rowBytes: 4,
                     bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                     format: .RGBA8,
                     colorSpace: CGColorSpaceCreateDeviceRGB())
      
      let red = Double(bitmap[0]) / 255.0
      let green = Double(bitmap[1]) / 255.0
      let blue = Double(bitmap[2]) / 255.0
      let alpha = Double(bitmap[3]) / 255.0
      
      let adjustmentFactor = 0.5
      let saturationFactor = 2.0
      let darkRed = (red * adjustmentFactor * saturationFactor).clamped(to: 0.0...1.0)
      let darkGreen = (green * adjustmentFactor * saturationFactor).clamped(to: 0.0...1.0)
      let darkBlue = (blue * adjustmentFactor * saturationFactor).clamped(to: 0.0...1.0)
      
      dominantColor = Color(red: darkRed, green: darkGreen, blue: darkBlue, opacity: alpha)
    }
  }
}

struct GradientBackground: View {
  let color: Color
  
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.5), color.opacity(0.4), color.opacity(0.3)]),
                   startPoint: .bottomTrailing,
                   endPoint: .topLeading)
    .edgesIgnoringSafeArea(.all)
  }
}

#Preview {
  CityCard(city: City.sampleData[0])
}
