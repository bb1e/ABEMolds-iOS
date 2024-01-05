//
//  ContentView.swift
//  test
//
//  Created by Alexandre Silva on 15/12/2023.
//

import SwiftUI
import RealityKit
import ARKit

/* USED LINKS
 *https://medium.com/futureproofd/realitykit-basics-part-1-8ede1143137b
 *https://medium.com/futureproofd/realitykit-basics-part-2-be96faa32b8f
 *https://stackoverflow.com/questions/63631392/how-can-i-make-shadows-in-realitykit-for-usdz-files
 *https://coledennis.medium.com/tutorial-how-to-switch-between-front-and-rear-cameras-in-realitykit-using-a-swiftui-button-c8bd419b9358
 *https://betterprogramming.pub/introduction-to-realitykit-on-ios-entities-gestures-and-ray-casting-8f6633c11877
 */

struct MoldARView : View {
    @State private var autoMode = false
    @State var item: Mold
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        @ObservedObject var arViewModel = ARViewModel()
        ZStack {
            ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(item.projectName)
                        Text(item.customerName)
                        Text("Status: \(item.currentParameters.stage)")
                        Text("Plastic Temp.: \(item.currentParameters.plasticTempC)ºC")
                        Text("Cavity Temp.: \(item.currentParameters.cavityTempC)ºC")
                        Text("Pressure: \(item.currentParameters.pressure)")
                    }.background(.gray.opacity(0.4))
                }
                Spacer()
                HStack {
                    Button {
                        arViewModel.resetPositionClosed()
                    } label: {
                        Label("Reset", systemImage: "gobackward")
                    }.buttonStyle(.borderedProminent)
                    
                    Button {
                        arViewModel.openMold()
                    } label: {
                        Label("Open", systemImage: "arrow.left")
                    }.buttonStyle(.borderedProminent)
                    
                    Button {
                        arViewModel.closeMold()
                    } label: {
                        Label("Close", systemImage: "arrow.right")
                    }.buttonStyle(.borderedProminent)
                    
                    //TODO needs to fetch status and animate accordingly
                    //when stage goes to ejecting, call arViewModel.openMold()
                    //when stage goes from ejecting to clamping, call arViewModel.closeMold()
                    Toggle(isOn: $autoMode) {
                        Text("Auto Mode")
                    }
                }
            }
        }
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}

struct ARModel {
    private(set) var arView : ARView
    
    init() {
        arView = ARView(frame: .zero)
    }
    
}

class ARViewModel: ObservableObject {
    @Published private var model : ARModel = ARModel()
    
    var arView : ARView {
        model.arView
    }
    
    func resetPositionClosed() {
        guard !arView.scene.anchors.isEmpty else { return }
        
        arView.scene.anchors.first?.children.forEach {
            $0.position = [0, 0, 0]
            $0.scale = SIMD3(x: 1, y: 1, z: 1)
            $0.orientation = simd_quatf(angle: -(.pi/2), axis: SIMD3(x: 1, y: 0, z: 0))
        }
    }
    
    func resetPositionOpen() {
        guard !arView.scene.anchors.isEmpty else { return }
        var i = 0
        arView.scene.anchors.first?.children.forEach {
            if (i == 0) {
                //first child is ejection side model
                $0.position = [-1, 0, 0]
            }
            else {
                $0.position = [0, 0, 0]
            }
            i += 1
            $0.scale = SIMD3(x: 1, y: 1, z: 1)
            $0.orientation = simd_quatf(angle: -(.pi/2), axis: SIMD3(x: 1, y: 0, z: 0))
        }
    }
    
    func openMold() {
        guard !arView.scene.anchors.isEmpty else { return }
        
        var transform = arView.scene.anchors.first?.children.first?.transform
            
        transform?.translation = SIMD3<Float>(x: -1, y: 0, z: 0)
        
        resetPositionClosed()
        
        arView.scene.anchors.first?.children.first?.move(to: transform!, relativeTo: arView.scene.anchors.first, duration: 3, timingFunction: .easeInOut)
    }
    
    func closeMold() {
        guard !arView.scene.anchors.isEmpty else { return }
        
        var transform = arView.scene.anchors.first?.children.first?.transform
            
        transform?.translation = SIMD3<Float>(x: 0, y: 0, z: 0)
        
        resetPositionOpen()
        
        arView.scene.anchors.first?.children.first?.move(to: transform!, relativeTo: arView.scene.anchors.first, duration: 3, timingFunction: .easeInOut)
    }
    
}

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        //let arView = ARView(frame: .zero)
        let arView = arViewModel.arView
        
        arView.addCoaching()
        
        
        // Start AR session
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
                let coachingOverlay = ARCoachingOverlayView()
                coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                coachingOverlay.session = session
                coachingOverlay.goal = .horizontalPlane
                arView.addSubview(coachingOverlay)
        
        let material = createMaterial()
        //material.specular = .init(floatLiteral: 0.8)
        
        let model_ejection = loadModel(named: "ejection_rotated", with: material)
        
        let model_injection = loadModel(named: "injection_rotated", with: material)
        
        arView.installGestures(.all, for: model_injection)
        arView.installGestures(.all, for: model_ejection)
        
        var lights = addLights()

        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model_ejection)
        anchor.children.append(model_injection)
        
        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        let lightAnchor = AnchorEntity(world: [0, 0, 2.5])
        while !lights.isEmpty {
            lightAnchor.addChild(lights.popLast()!)
        }
        
        arView.scene.addAnchor(lightAnchor)
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
        #endif

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func createMaterial() -> PhysicallyBasedMaterial {
        var material = PhysicallyBasedMaterial()
        material.baseColor = PhysicallyBasedMaterial.BaseColor(tint: .gray)
        material.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 0.2)
        material.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 1.0)
        
        return material
    }

    func loadModel(named: String, with material: PhysicallyBasedMaterial) -> ModelEntity {
        /*let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let downloadLocation = downloadUSDZ(
          from: "gs://abemolds-60b85.appspot.com/1000_" + named + ".usdz",
          to: docsUrl
        ) else {
          fatalError("could not download usdz")
        }*/
        let model = try! Entity.loadModel(named: named)
        //let model = try! Entity.loadModel(contentsOf: downloadLocation)
        var comp: ModelComponent = model.components[ModelComponent.self]!
                    comp.materials = [material]
                    model.components.set(comp)
        model.generateCollisionShapes(recursive: true)
        return model
    }

    func addLights() -> Array<DirectionalLight> {
        let directLight = DirectionalLight()
        directLight.light.color = .white
        directLight.light.intensity = 100000
        directLight.orientation = simd_quatf(angle: Float.pi/8, axis: [-5, 5, 5])
        directLight.shadow = .init(DirectionalLightComponent.Shadow(maximumDistance: 5, depthBias: 1))
        
        let directLight2 = DirectionalLight()
        directLight2.light.color = .white
        directLight2.light.intensity = 100000
        directLight2.orientation = simd_quatf(angle: Float.pi/8, axis: [-5, 5, 0])
        directLight2.shadow = .init(DirectionalLightComponent.Shadow(maximumDistance: 5, depthBias: 1))
        
        return [directLight, directLight2]
    }
}

#Preview {
    ContentView()
}
