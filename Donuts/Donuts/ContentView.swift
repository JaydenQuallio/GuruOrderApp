import SwiftUI
import MessageUI
import RealityKit
import ARKit

struct ContentView: View {
    @State private var message = "Order for Jayden:"
    @State private var isShowingMessageComposer = false
    @State private var errorText: String = ""
    @State private var errorBool: Bool = false
    @State var showCount: Int = -1
    @State var showButtons = true
    @State var button = 0
    
    @State var pressedButtons: [String] = []
    @State var finalOrder: [String] = []
    
    var body: some View {
        if(showCount == 0){
            if (showButtons) {
                VStack {
                    Spacer()
                    Image("Guru")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer()
                    HStack{
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
                    }
                    Button("YOUR ORDER") {
                        finalOrder = pressedButtons.reduce(into: [:]) { counts, element in
                            counts[element, default: 0] += 1
                        }
                        .map { "\($0.key) x \($0.value)" }
                        
                        button = 3
                        showButtons = false
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    Spacer()
                    Spacer()
                }
            }
            else {
                VStack {
                    
                    switch (button) {
                        
                    case 1:
                        HStack{
                            Button("Coffee ☕️") {
                                
                                
                                pressedButtons.append("Coffee ☕️")
                                
                                
                                
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                            
                            Button("Tea 🫖") {
                                
                                pressedButtons.append("Tea 🫖")
                                
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        }
                        HStack{
                            Button("Soda 🥤") {
                                
                                pressedButtons.append("Soda 🥤")
                                
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                            
                            Button("Water 💧") {
                                
                                pressedButtons.append("Water 💧")
                                
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        }
                        Button("Back"){
                            showButtons = true
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .padding()
                        
                    case 2:
                        HStack{
                            Button("Donut 🍩") {
                                
                                pressedButtons.append("Donut 🍩")
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                            
                            Button("Sandwich 🥪") {
                                pressedButtons.append("Sandwich 🥪")
                                showButtons = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        }
                        Button("Toast 🍞") {
                            pressedButtons.append("Toast 🍞")
                            showButtons = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Button("Back"){
                            showButtons = true
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .padding()
                        
                    case 3:
                        Text(errorText)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .font(.headline)
                            .opacity(errorBool ? 1 : 0)
                        
                        Text("Your Order:")
                            .font(.title)
                        ForEach(finalOrder, id: \.self) { button in
                            Text(button)
                                .font(.headline)
                        }
                        
                        Button("Place Order"){
                            if(pressedButtons.count > 0){
                                isShowingMessageComposer = true
                            }
                            else{
                                errorBool = true
                                errorText = "Please Add Something to Your Order!"
                            }
                        }
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        
                        Button("Back") {
                            showButtons = true
                            errorBool = false
                            message = "Order for Jayden:"
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .padding()
                        
                    default:
                        //print("yeah")
                        Text("Restart App")
                        //showButtons = true
                        
                    }
                }
                .sheet(isPresented: $isShowingMessageComposer) {
                    MessageComposeView(message: AddOrder(pressedButtons: finalOrder, message: message), recipient: "2083921227", isShowingMessageComposer: $isShowingMessageComposer, showCount: $showCount)
                }
            }
        }
        
        else if(showCount == 1){
            VStack {
                Text("Wait for text saying done")
                    .padding()
                    .font(.title2)
                
                Button("Next") {
                    pressedButtons = [String]()
                    showCount = 2
                    showButtons = true
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
        
        else if(showCount == 2){
            ZStack{
                ARViewContainer(sceneName: $showCount).edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Button("Go Home"){
                        showCount = -1
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                }
            }
        }
        else if(showCount == -1){
            ZStack{
                ARViewContainer(sceneName: $showCount).edgesIgnoringSafeArea(.all)
                HStack{
                    Text("Please Scan Icon")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

func AddOrder(pressedButtons: [String], message: String) -> String{
    
    var temp = message
    
    for button in pressedButtons{
            temp += "\n" + button
    }
    
    return temp
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var sceneName: Int
    
    func makeUIView(context: Context) -> ARView {
        
        if(sceneName == 2){
            let arView = ARView(frame: .zero)
            let config = ARWorldTrackingConfiguration()

            config.planeDetection = .horizontal
            
            
            guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
                fatalError("Missing expected asset catalog resources.")
            }
            
            config.detectionImages = referenceImages
            
            arView.session.run(config)
            
            context.coordinator.view = arView
            
            arView.session.delegate = context.coordinator
            
            if (try? Experience.loadBox()) != nil {
                // Load the "Box" scene from the "Experience" Reality File
                let boxAnchor = try! Experience.loadBox()
                
                // Add the box anchor to the scene
                arView.scene.anchors.append(boxAnchor)
                context.coordinator.scene1 = boxAnchor
            }
            
            return arView

        }
        
        else {
            
            let arView = ARView(frame: .zero)
            
            context.coordinator.view = arView
            
            // Load the "Box" scene from the "Experience" Reality File
            let boxAnchor = try! Experience.loadScene()
            
            context.coordinator.scene2 = boxAnchor
            
            boxAnchor.actions.sceneStarted.onAction = context.coordinator.Start(_:)

            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
            
            return arView

        }
            
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(showCount: $sceneName)
    }
}

class Coordinator:NSObject, ARSessionDelegate
{
    //Storing values
    @Binding var showCount: Int
    weak var view:ARView?
    weak var scene1: Experience.Box?
    weak var scene2: Experience.Scene?

    required override init() {
        fatalError("init() has not been implemented")
    }

    init(showCount: Binding<Int>) {
        self._showCount = showCount
        super.init()
    }
    
    func session(_ session: ARSession, didAdd anchors:[ARAnchor]){
        for anchor in anchors{
            if(anchor.name == "donut"){
                let anchorEntity = AnchorEntity(world: anchor.transform)
                anchorEntity.addChild(scene1!)
                view!.scene.anchors.append(anchorEntity)
            }
        }
    }
    
    func Start(_ entity: Entity?){
        showCount = 0
    }
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
            
            isShowingMessageComposer = false
            print(result.rawValue)
            
            if(result.rawValue == 0){
                showCount = 0
            }
            else if(result.rawValue == 1){
                showCount = 1
            }
        }
        
    }
}
