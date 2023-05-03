import SwiftUI
import MessageUI
import RealityKit

struct ContentView: View {
    @State private var message = "Order for Jayden: "
    @State private var isShowingMessageComposer = false
    @State private var showCount: Int = 0

    @State var showButtons = true
    @State var button = 0;
    
    
    @State var pressedButtons: [String] = []
    
    var body: some View {
        if(showCount < 1){
            if (showButtons) {
                VStack {
                    Button("Drinks") {
                        button = 1
                        showButtons = false
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    Button("Food") {
                        button = 2
                        showButtons = false
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    Button("YOUR ORDER") {
                        button = 3
                        showButtons = false
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    
                }
            }
            else {
                VStack {
                    
                    switch (button) {
                        
                    case 1:
                        Button("Coffee") {
                            
                            
                            pressedButtons.append("Coffee")
                            
                            
                            
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Tea") {
                            
                            pressedButtons.append("Tea")
                            
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Soda") {
                            
                            pressedButtons.append("Soda")
                            
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Water") {
                            
                            pressedButtons.append("Water")
                            
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        
                        
                        
                        
                    case 2:
                        Button("Donuts") {
                            
                            pressedButtons.append("Donuts")
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Sandwiches") {
                            pressedButtons.append("Sandwiches")
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Toast") {
                            pressedButtons.append("Toast")
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        
                        
                    case 3:
                        Text("Your order:")
                            .font(.title)
                        ForEach(pressedButtons, id: \.self) { button in
                            Text(button)
                                .font(.headline)
                        }
                        Button("Back") {
                            showButtons = true
                            message = "Order for Jayden"
                        }
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Place Order"){
                            isShowingMessageComposer = true
                        }
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        
                    default:
                        //print("yeah")
                        Text("Safety")
                        //showButtons = true
                        
                    }
                }
                .sheet(isPresented: $isShowingMessageComposer) {
                    MessageComposeView(message: AddOrder(pressedButtons: pressedButtons, message: message), recipient: "2083921227", isShowingMessageComposer: $isShowingMessageComposer, showCount: $showCount)
                }
            }
        }
        
        else if(showCount == 1){
            VStack {
                Text("Wait for text saying done")
                    .padding()
                    .font(.title2)
                
                Button("Next") {
                    isShowingMessageComposer = true
                    showCount = 2
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
        
        else if(showCount == 2){
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}

func AddOrder(pressedButtons: [String], message: String) -> String{
    
    var temp = message
    
    for orderText in pressedButtons{
        temp += " " + orderText
    }
    
    return temp
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct MessageComposeView: UIViewControllerRepresentable {
    
    let message: String
    let recipient: String
    @Binding var isShowingMessageComposer: Bool
    @Binding var showCount: Int
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.recipients = [recipient]
        messageComposeVC.messageComposeDelegate = context.coordinator
        messageComposeVC.body = message
        return messageComposeVC
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowingMessageComposer: $isShowingMessageComposer, showCount: $showCount)
    }

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        @Binding var isShowingMessageComposer: Bool
        @Binding var showCount: Int
        
        init(isShowingMessageComposer: Binding<Bool>, showCount: Binding<Int>) {
            _isShowingMessageComposer = isShowingMessageComposer
            _showCount = showCount
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            
            
            if(result.rawValue == 1){
                showCount = 1
            }
            isShowingMessageComposer = false
        }
        
    }
}
