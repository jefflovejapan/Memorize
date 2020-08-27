//
//  Pie.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-19.
//  Copyright © 2020 polyergy. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false

    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }

        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + (radius * cos(CGFloat(startAngle.radians))),
            y: center.y + (radius * sin(CGFloat(startAngle.radians)))
        )

        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}

struct PiePreview: PreviewProvider {
    static var previews: some View {
        Group {
            Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 45), clockwise: true)
            Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 45), clockwise: false)
        }

    }
}
