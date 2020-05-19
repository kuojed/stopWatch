//
//  ContentView.swift
//  stopWatch
//
//  Created by 郭冠杰 on 2020/5/16.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var startTime: Date?
    @State var isTrigger = false
    @State var components = DateComponents(minute: 0, second: 0)
    
    @State var initialTime = DateComponents(minute: 0, second: 0)
    @State var totalTime = DateComponents(minute: 0, second: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var resetStatus = true
    
    var body: some View {
        
        
        
        
        
        VStack{
            
            //            Text((components.minute ?? 0) < 10 ? "0\(components.minute!)" : "\(components.minute!)")
            //                .font(.largeTitle) +
            //
            //                Text(":")
            //                    .font(.largeTitle) +
            //
            //                Text((components.second ?? 0) < 10 ? "0\(components.second!)" : "\(components.second!)")
            //                    .font(.largeTitle)
            
            Text((totalTime.minute ?? 0) < 10 ? "0\(totalTime.minute!)" : "\(totalTime.minute!)")
                .font(.system(size: 80)) +
                
                Text(":")
                    .font(.system(size: 80)) +
                
                Text((totalTime.second ?? 0) < 10 ? "0\(totalTime.second!)" : "\(totalTime.second!)")
                    .font(.system(size: 80))
            
            
            HStack(spacing: 80){
                
                Button(action: {
                    
                    self.initialTime = DateComponents(minute: 0, second: 0)
                    self.totalTime = DateComponents(minute: 0, second: 0)
                    self.resetStatus = true
                    
                }){
                    
                    
                    Circle()
                        .fill(resetStatus == true ? Color.gray : Color.green)
                        .overlay(
                            
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                                .padding(4)
                            
                    )
                        .overlay(
                            Text("reset")
                                .foregroundColor(.white)
                            
                    )
                        .frame(width: 75, height: 75)
                    
                    
                }
                .disabled(resetStatus)
                
                Button(action: {
                    
                    self.isTrigger.toggle()
                    
                    if self.isTrigger == true {
                        
                        self.startTime = Date()
                        if self.resetStatus == false {
                            self.resetStatus = true
                        }
                        
                    } else {
                        
                        self.startTime = nil
                        self.initialTime = self.totalTime
                        self.resetStatus = false
                        
                    }
                    
                }){
                    
                    
                    Circle()
                        .fill(isTrigger == true ? Color.red : Color.green)
                        .overlay(
                            
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                                .padding(4)
                            
                    )
                        .overlay(
                            Text(isTrigger == true ? "stop" : "start")
                                .foregroundColor(.white)
                            //                                .background(Color.green)
                    )
                        .frame(width: 75, height: 75)
                    
                    
                }
            }
            .padding()
        }
        .onReceive(timer) { (value) in
            if let startTime = self.startTime {
                
                self.components = Calendar.current.dateComponents([.minute, .second], from: startTime, to: value)
                
                self.totalTime.second! = self.initialTime.second! + self.components.second!
                
                self.totalTime.minute! = self.initialTime.minute! + self.components.minute!
                
                
                if self.totalTime.second! >= 60 {
                    self.totalTime.second! = self.totalTime.second! % 60
                    self.totalTime.minute! = self.totalTime.minute! + 1
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
