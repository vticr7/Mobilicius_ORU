//
//  Home.swift
//
//  Created by Vaibhav on 18/01/24.
//
import FirebaseAuth
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Home: View {
    
    @State var currentWeek: [Date] = []
    @State var currentDay: Date = Date()
    @AppStorage("uid") var userID: String = ""
    
    
    @State var showViews: [Bool] = Array(repeating: false, count: 5)
    
    
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                Text("Current Week")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            withAnimation {
                                userID = ""  // Clearing userID on sign out
                            }
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.white)  // Set text color to match your style
                            .font(.title3)  // Set font to match your style
                    }
                
                
                    
                
            }
            .foregroundColor(.white)
            .opacity(showViews[0] ? 1 : 0)
            .offset(y: showViews[0] ? 0 : 200)
            
            // MARK: Current Week View
            HStack(spacing: 10){
                ForEach(currentWeek,id: \.self){date in
                    Text(extractDate(date: date))
                        .fontWeight(isSameDay(date1: currentDay, date2: date) ? .bold : .semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,isSameDay(date1: currentDay, date2: date) ? 6 : 0)
                        .padding(.horizontal,isSameDay(date1: currentDay, date2: date) ? 12 : 0)
                        .frame(width: isSameDay(date1: currentDay, date2: date) ? 140 : nil)
                        .background{
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)
                                .opacity(isSameDay(date1: currentDay, date2: date) ? 0.8 : 0)
                        }
                        .onTapGesture {
                            withAnimation{
                                currentDay = date
                            }
                        }
                }
            }
            .padding(.top,10)
            .opacity(showViews[1] ? 1 : 0)
            .offset(y: showViews[1] ? 0 : 250)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Steps")
                    .fontWeight(.semibold)
                
                
                Text("6,969")
                    .font(.system(size: 45, weight: .bold))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.vertical,15)
            .opacity(showViews[2] ? 1 : 0)
            .offset(y: showViews[2] ? 0 : 200)
            
            
            FitnessRingCardView()
                .opacity(showViews[3] ? 1 : 0)
                .offset(y: showViews[3] ? 0 : 250)
            
            
            FitnessStepsGraphView()
                .opacity(showViews[4] ? 1 : 0)
                .offset(y: showViews[4] ? 0 : 200)
        }
        .padding()
        .onAppear(perform: extractCurrentWeek)
        .onAppear(perform: animateViews)
    }
    
    
    func animateViews(){
        withAnimation(.easeInOut){
            showViews[0] = true
        }
        
        withAnimation(.easeInOut.delay(0.1)){
            showViews[1] = true
        }
        
        withAnimation(.easeInOut.delay(0.15)){
            showViews[2] = true
        }
        
        withAnimation(.easeInOut.delay(0.2)){
            showViews[3] = true
        }
        
        withAnimation(.easeInOut.delay(0.35)){
            showViews[4] = true
        }
    }
    
    
    func extractCurrentWeek(){
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let firstDay = week?.start else{
            return
        }
        
        (0..<7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDay){
                currentWeek.append(weekDay)
            }
        }
    }
    
    
    func extractDate(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = (isSameDay(date1: currentDay, date2: date) ? "dd MMM" : "dd")
        
        return (isDateToday(date: date) && isSameDay(date1: currentDay, date2: date) ? "Today, " : "") + formatter.string(from: date)
    }
    
    
    func isDateToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDateInToday(date)
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
