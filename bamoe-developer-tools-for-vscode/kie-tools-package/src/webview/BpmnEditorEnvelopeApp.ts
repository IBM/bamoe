import { VsCodeBpmnEditorFactory } from "@kie-tools/kie-bc-editors/dist/bpmn/envelope/vscode";
import * as EditorEnvelope from "@kie-tools-core/editor/dist/envelope";

declare const acquireVsCodeApi: any;

EditorEnvelope.init({
  container: document.getElementById("envelope-app")!,
  bus: acquireVsCodeApi(),
  editorFactory: new VsCodeBpmnEditorFactory({ shouldLoadResourcesDynamically: true }),
});
