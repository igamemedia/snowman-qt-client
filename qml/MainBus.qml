import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

MainBus {
  id: container
  property int count
  property int programChannel
  property int previewChannel

  RowLayout {
    anchors.fill: parent

    Repeater {
      model: container.count
      MainBusButton {
        channel: index
        label: index + 1
        onClicked: {container.setPreview(channel)}
        onShiftClicked: {container.setProgram(channel)}
        previewChannel: container.previewChannel
        programChannel: container.programChannel
      }
    }

    MainBusTransitions {
      onTransition: container.transition()
      onTake: container.take()
    }
  }

  focus: true
  Keys.onPressed: {
    var channel;

    if (event.text == '\\') {
      container.transition();
      return;
    }

    if (event.text == '') { return; }   // Ignore modifier keys

    var previewMap = '1234567890';
    var programMap = '!@#$%^&*()';

    var previewChannel = previewMap.indexOf(event.text);
    var programChannel = programMap.indexOf(event.text);

    if (previewChannel > -1) {
      container.setPreview(previewChannel);
    }

    if (programChannel > -1) {
      container.setProgram(programChannel);
    }
  }

  Keys.onReturnPressed: {
    container.take()
  }
}