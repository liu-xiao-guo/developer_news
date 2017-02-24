import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
   property alias text: content.text

   Flickable {
       id: flickableContent
       anchors.fill: parent

       Text {
           id: content
           textFormat: Text.RichText
           wrapMode: Text.WordWrap
           width: parent.width
       }

       contentWidth: parent.width
       contentHeight: content.height
       clip: true
   }


   Scrollbar {
       flickableItem: flickableContent
   }
}
