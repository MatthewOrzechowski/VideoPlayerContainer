//
//  ToastWidget.swift
//  VideoPlayer
//
//  Created by shayanbo on 2023/6/15.
//

import SwiftUI

extension ToastService {
    
    struct Toast: Identifiable, Equatable {
        
        public let object: Any
        public let id = UUID().uuidString
        
        public init(object: Any) {
            self.object = object
        }
        
        public static func == (a: Toast, b: Toast) -> Bool {
            return a.id == b.id
        }
    }
}

public class ToastService: Service {
    
    @ViewState fileprivate var toasts = [Toast]()
    
    @ViewState fileprivate var insets: EdgeInsets = .init(top: 48, leading: 10, bottom: 48, trailing: 0)
    
    @ViewState fileprivate var lineSpacing: CGFloat = 8
    
    fileprivate var duration: DispatchTimeInterval = .seconds(3)
    
    fileprivate var content: ( (Any)->any View )?
    
    public required init(_ context: Context) {
        super.init(context)
    }
    
    public func configure(duration: DispatchTimeInterval) {
        self.duration = duration
    }
    
    public func configure(insets: EdgeInsets) {
        self.insets = insets
    }
    
    public func configure(content: @escaping (Any)->some View) {
        self.content = content
    }
    
    public func configure(lineSpacing: CGFloat) {
        self.lineSpacing = lineSpacing
    }
    
    public func toast(_ object: Any) {
        withAnimation {
            let toast = Toast(object: object)
            toasts.append(toast)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                withAnimation {
                    self?.toasts.removeAll { $0 == toast }
                }
            }
        }
    }
}

struct ToastWidget: View {
    
    var body: some View {
        
//        WithService(ToastService.self) { service in
//            ToastLayout(service.lineSpacing) {
//                Spacer()
//
//                if let content = service.content {
//                    ForEach(service.toasts) { toast in
//                        AnyView(content(toast.object))
//                            .padding(.leading, service.insets.leading)
//                            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))
//                    }
//                }
//            }
//            .padding(EdgeInsets(top: service.insets.top, leading: 0, bottom: service.insets.bottom, trailing: service.insets.trailing))
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
        Text("")
    }
}

//struct ToastLayout : Layout {
//
//    let lineSpacing: CGFloat
//
//    init(_ lineSpacing: CGFloat) {
//        self.lineSpacing = lineSpacing
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//
//        var y = 0.0
//        for subview in subviews.reversed() {
//            let viewSize = subview.sizeThatFits(proposal)
//            y = y + lineSpacing + viewSize.height
//            subview.place(at: CGPoint(x: 0, y: bounds.minY + (proposal.height ?? 0) - y), proposal: proposal)
//        }
//    }
//
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
//    }
//}
//
