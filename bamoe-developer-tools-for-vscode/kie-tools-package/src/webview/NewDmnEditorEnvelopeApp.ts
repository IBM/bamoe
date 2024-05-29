import { DmnEditorFactory } from "@kie-tools/dmn-editor-envelope/dist/DmnEditorFactory";
import * as EditorEnvelope from "@kie-tools-core/editor/dist/envelope";

declare const acquireVsCodeApi: any;

EditorEnvelope.init({
  container: document.getElementById("envelope-app")!,
  bus: acquireVsCodeApi(),
  editorFactory: new DmnEditorFactory(),
});
