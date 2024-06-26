//
//  ContentView.swift
//  ProjetoCalvo
//
//  Created by Kaua Miguel on 25/03/24.
//
import SwiftUI

struct InitialView: View {
    @State var showProcessing: Bool = false
    @State var openCamera = false
    @State var image = UIImage()
    @State var coreMLResult = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: ProcessingView(image: $image),
                    isActive: $showProcessing,
                    label: { EmptyView() }
                )
                
                Button(action: {
                    openCamera.toggle()
                }, label: {
                    ZStack {
                        Image("CalvoButton")
                            .resizable()
                            .scaledToFit()
                        Text("Calvo Analisor")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                })
            }
            .padding()
            .fullScreenCover(isPresented: $openCamera, content: {
                ImagePicker(sourceType: .camera, selectedImage: $image, showProcessing: $showProcessing, coreMlResult: $coreMLResult)
            })
        }
    }
}

#Preview {
    InitialView()
}

struct ProcessingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var processAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var isCalvo: Bool = false
    @Binding var image : UIImage
    
    var body: some View {
        
        VStack {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .foregroundStyle(.mint)
                if processAmount >= 100 {
                    VStack {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 120)
                                    .foregroundStyle(isCalvo ? .green : .red)
                                    .ignoresSafeArea()
                                
                                Circle()
                                    .frame(width: 180, height: 180)
                                    .foregroundStyle(isCalvo ? .green : .red)
                                    .overlay {
                                        Image(isCalvo ? "Check" : "XMark")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                          //  .foregroundStyle(.mint)
                                            .padding(.top, 60)
                                    }
                                    .padding(.top, 20)
                                HStack {
                                    Text(isCalvo ? "Calvo" : "Not Calvo")
                                        .font(.title)
                                    Image(isCalvo ? "ARocha 1" : "ChaveMetaleiro")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 10)
                                }
                                .padding(.bottom, 50)
                            }
                            .ignoresSafeArea(.all)
                        Spacer()
                    }
                } else {
                    ProgressView("Processing...", value: processAmount, total: 100)
                        .scaledToFill()
                        .frame(width: 500, height: 500)
                        .onReceive(timer) { _ in
                            withAnimation {
                                processAmount += 10
                            }
                        }
                        .progressViewStyle(.circular)
                        .frame(width: 500, height: 500)
                }
            }
        }.onAppear(perform: {
            let model =  try! CalvoModel()
            
            func coreMLResult(forImage image : UIImage) -> String?{
                    
                    if let pixelImage = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
                        guard let scene = try? model.prediction(image: pixelImage) else {fatalError()}
                        return scene.target
                    }
                    
                    return nil
                }
            
            guard let result = coreMLResult(forImage: image) else {return}
            print(result)
            if result == "Bald"{
                isCalvo = true
            }else{
                isCalvo = false
            }
         
        })
        
    }
}



