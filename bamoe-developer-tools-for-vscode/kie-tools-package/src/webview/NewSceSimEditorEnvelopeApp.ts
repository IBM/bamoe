import { TestScenarioEditorFactory } from "@kie-tools/scesim-editor-envelope/dist/TestScenarioEditorFactory";
import * as EditorEnvelope from "@kie-tools-core/editor/dist/envelope";

declare const acquireVsCodeApi: any;

EditorEnvelope.init({
  container: document.getElementById("envelope-app")!,
  bus: acquireVsCodeApi(),
  editorFactory: new TestScenarioEditorFactory(),
});
