import * as BpmnEditor from "@ibm/bamoe-standalone-bpmn-and-dmn-editors-classic/dist/bpmn";
import { loadFile } from "../../fileLoader";

document.addEventListener("DOMContentLoaded", function () {
  loadEditor();
});

function loadEditor() {
  // Loads the BPMN Editor in the `<div id="bpmn-editor-container" />` element.
  // Initializes with an existing file called `hiring.bpmn` on the root of the
  // workspace.
  // The `loadFile` function loads the file from the /static/models directory and returns
  // a Promise that resolves into a string.
  // The `readOnly` flag changes the editor, locking all changes to the model, making it
  // useful for displaying diagrams without editing the Process.
  const editor = BpmnEditor.open({
    container: document.getElementById("bpmn-editor-container")!,
    initialContent: loadFile("hiring.bpmn"),
    readOnly: true,
  });

  console.log({ editor });
}
