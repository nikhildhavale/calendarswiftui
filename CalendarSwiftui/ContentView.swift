//
//  ContentView.swift
//  CalendarSwiftui
//
//  Created by Nikhil on 08/09/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var calendarModel:CalendarModel
    var body: some View {
        VStack
            {
                HStack{
                    Button<Image>(action: {
                        let date  = self.calendarModel.date
                        self.calendarModel.navigationDirection = .reverse
                        self.calendarModel.date = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? date
                    }, label: {
                        Image(systemName: "chevron.left.circle")
                    })
                    Text(calendarModel.monthString).frame(minWidth: 0,
                     maxWidth: .infinity,
                     minHeight: 0,
                     maxHeight: 20)
                    Button<Image>(action: {
                        let date  = self.calendarModel.date
                        self.calendarModel.navigationDirection = .forward
                        self.calendarModel.date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? date

                    }, label: {
                        Image(systemName: "chevron.right.circle")
                    })
                }.padding([.leading,.trailing], 20)
                
                PageView(
                    List
                        {
                            ForEach(0..<calendarModel.numberOfRows)
                            {
                                index in
                                HStack
                                    {
                                        
                                        ForEach(self.calendarModel.dayArry[index]!)
                                        { dayItem in
                                            Text(dayItem.tileString).frame(minWidth: 0,
                                                                           maxWidth: .infinity,
                                                                           minHeight: 0,
                                                                           maxHeight: .infinity)
                                        }
                                        
                                }
                            }
                }, navigationDirection: calendarModel.navigationDirection)
                
               
        } .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(calendarModel: CalendarModel(date: Date()))
    }
}
