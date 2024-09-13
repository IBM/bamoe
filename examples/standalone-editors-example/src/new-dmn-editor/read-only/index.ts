import * as DmnEditor from "@ibm/bamoe-standalone-dmn-editor/dist";
import { loadFile } from "../../fileLoader";

document.addEventListener("DOMContentLoaded", function () {
  loadEditor();
});

function loadEditor() {
  // Loads the DMN Editor in the `<div id="dmn-editor-container" />` element.
  // Initializes with an existing file called `loan-pre-qualification.dmn` on the root of the
  // workspace.
  // The `loadFile` function loads the file from the /static/models directory and returns
  // a Promise that resolves into a string.
  // The `readOnly` flag changes the editor, locking all changes to the model, making it
  // useful for displaying diagrams without editing the Decision.
  const editor = DmnEditor.open({
    container: document.getElementById("dmn-editor-container")!,
    initialFileNormalizedPosixPathRelativeToTheWorkspaceRoot: "loan-pre-qualification.dmn",
    initialContent: loadFile("loan-pre-qualification.dmn"),
    readOnly: true,
  });

  console.log({ editor });
}
