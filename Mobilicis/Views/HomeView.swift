import SwiftUI
import AVFoundation

struct DeviceInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Device Model: \(UIDevice.current.model)")
            Text("iOS Version: \(UIDevice.current.systemVersion)")
            Text("Battery Level: \(Int(UIDevice.current.batteryLevel * 100))%")
            // Further device information can be added here as needed
        }
        .padding()
        .onAppear {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
    }
}

struct HomeView: View {
    @State var showView: Bool = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if showView {
                VStack {
                    DeviceInfoView() // Display device information
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    // Your existing Home view or additional content
                    // can be added here if needed
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            GeometryReader { geometry in
                ZStack {
                    
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("Green").opacity(0.7), Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .scaleEffect(0.6)
                        .offset(x: geometry.size.width * 0.3, y: -geometry.size.height * 0.2)
                        .blur(radius: 120)
                        .rotationEffect(Angle(degrees: showView ? 0 : 360))
                    
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("Red").opacity(0.7), Color.clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                        .scaleEffect(0.6)
                        .offset(x: -geometry.size.width * 0.3, y: geometry.size.height * 0.2)
                        .blur(radius: 120)
                        .rotationEffect(Angle(degrees: showView ? 360 : 0))

                    Rectangle()
                        .fill(.ultraThinMaterial)
                }
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1.5), value: showView)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showView = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
