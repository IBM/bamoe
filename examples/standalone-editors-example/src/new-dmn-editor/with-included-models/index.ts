import * as DmnEditor from "@ibm/bamoe-standalone-dmn-editor/dist";
import { loadFile } from "../../fileLoader";

document.addEventListener("DOMContentLoaded", function () {
  loadEditor();
});

function loadEditor() {
  // Loads the DMN Editor in the `<div id="dmn-editor-container" />` element.
  // Initializes with an existing file called `can-drive.dmn` on the root of the
  // workspace.
  // The `loadFile` function loads files from the /static/models directory and returns
  // a Promise that resolves into a string.
  // In this case resources are added alongside the main content and can be used as
  // an included model.
  // The paths are important here! Since path2/loan-pre-qualification.dmn is in a
  // different parent path than the main content (path1/can-drive.dmn), it won't be availabe
  // to be used as an included model.
  // Examples:
  // | Path                           | Available |
  // | ------------------------------ | --------- |
  // | path1/test/myModel.dmn         |     ✓     |
  // | myTypes.dmn                    |     x     |
  // | path2/model.dmn                |     x     |
  // | path1/sample.dm                |     ✓     |
  // | ------------------------------ | --------- |
  const editor = DmnEditor.open({
    container: document.getElementById("dmn-editor-container")!,
    initialFileNormalizedPosixPathRelativeToTheWorkspaceRoot: "path1/can-drive.dmn",
    initialContent: loadFile("can-drive.dmn"),
    resources: new Map([
      ["path1/can-drive-types.dmn", { contentType: "text", content: loadFile("can-drive-types.dmn") }],
      ["path2/loan-pre-qualification.dmn", { contentType: "text", content: loadFile("loan-pre-qualification.dmn") }],
    ]),
    readOnly: false,
  });

  console.log({ editor });
}
