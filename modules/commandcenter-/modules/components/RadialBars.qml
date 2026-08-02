import QtQuick
import Quickshell.Io
import qs.config
import qs.services

Item {
    id: root
    
    property int barWidth: 4
    property real outerRadius: height / 2 - Global.padding.normal
    property real innerRadius: 0

    Canvas {
        id: canvas
        anchors.fill: parent
        
        onPaint: {
            const ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            
            const bars = MrisServices.cavaBarsData
            const cx = width / 2
            const cy = height / 2
            const angleStep = (Math.PI * 2) / bars.length
            
            bars.forEach((val, i) => {
                const angle = i * angleStep - Math.PI / 2
                const barHeight = (val / 100) * (root.outerRadius - root.innerRadius)
                
                const x1 = cx + Math.cos(angle) * root.innerRadius
                const y1 = cy + Math.sin(angle) * root.innerRadius
                const x2 = cx + Math.cos(angle) * (root.innerRadius + Math.max(2, barHeight))
                const y2 = cy + Math.sin(angle) * (root.innerRadius + Math.max(2, barHeight))
                
                ctx.beginPath()
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.strokeStyle = Colors.active
                ctx.lineWidth = root.barWidth
                ctx.lineCap = "round"
                ctx.stroke()
            })
        }
    }

    Connections {
        target: MrisServices
        function onCavaBarsDataChanged() { canvas.requestPaint() }
    }
}