import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0

UbuntuListView {
    id: listView
    property alias status: rssModel.status
    signal clicked(var instance)

    model: XmlListModel {
        id: rssModel
        source: "https://developer.ubuntu.com/en/blog/feeds/"
        query: "/rss/channel/item"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "published"; query: "pubDate/string()" }
        XmlRole { name: "content"; query: "description/string()" }
    }

    delegate: Subtitled {
        text: published
        subText: { return "<b>" + title + "</b>"; }

        progression: true
        onClicked: {
            console.log("currentidex: " + listView.currentIndex);
            console.log("index: " + index);
            listView.currentIndex = index;
            listView.clicked(model);
        }
    }

    // Define a highlight with customized movement between items.
    Component {
        id: highlightBar
        Rectangle {
            width: 200; height: 50
            color: "#FFFF88"
            y: listView.currentItem.y;
            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
        }
    }

    focus: true
    highlight: highlightBar

    Scrollbar {
        flickableItem: listView
    }

    function reload() {
        console.log('reloading')
        rssModel.reload()
    }
}
