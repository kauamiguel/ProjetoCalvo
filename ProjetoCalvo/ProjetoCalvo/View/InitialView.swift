//
//  ContentView.swift
//  ProjetoCalvo
//
//  Created by Kaua Miguel on 25/03/24.
//
import SwiftUI

struct InitialView: View {
    @State var showProcessing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    Camera()
                } label: {
                    ZStack {
                        Image("CalvoButton")
                            .resizable()
                            .scaledToFit()
                        Text("Calvo Analisor")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                }
                
            }
            .padding()
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
    @State var isCalvo: Bool = true
    
    var body: some View {
        
        VStack {
            ZStack {
                Image("vegetaCalvo")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .foregroundStyle(.mint)
                if processAmount >= 100 {
                    VStack {
//                        Image(systemName: "checkmark.rectangle.stack.fill")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 50, height: 50)
//                            .foregroundStyle(.mint)
                        if isCalvo {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 120)
                                    .foregroundStyle(.green)
                                    .ignoresSafeArea()
                                
                                Circle()
                                    .frame(width: 180, height: 180)
                                    .foregroundStyle(.green)
                                    .overlay {
                                        Image("Check")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(.mint)
                                            .padding(.top, 60)
                                    }
                                    .padding(.top, 20)
                                HStack {
                                    Text("Calvo")
                                        .font(.title)
                                    Image("ARocha 1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 10)
                                }
                                .padding(.bottom, 50)
                            }
                            .ignoresSafeArea(.all)
                        }
                        Spacer()
                        if !isCalvo {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 120)
                                    .foregroundStyle(.red)
                                    .ignoresSafeArea(.all)
                                Circle()
                                    .frame(width: 180, height: 180)
                                    .foregroundStyle(.red)
                                    .overlay {
                                        Image("Check")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(.mint)
                                        //    .padding(.top, 60)
                                    }
                                    .padding(.top, 20)
                                HStack {
                                    Text("Not Calvo")
                                        .font(.title)
                                    Image("ChaveMetaleiro")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 10)
                                }
                               // .padding(.bottom, 50)
                            }
                            .ignoresSafeArea(.all)
                        }
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
        }
    }
}



