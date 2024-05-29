import { SceSimEditorFactory } from "@kie-tools/kie-bc-editors/dist/scesim/envelope";
import * as EditorEnvelope from "@kie-tools-core/editor/dist/envelope";

declare const acquireVsCodeApi: any;

EditorEnvelope.init({
  container: document.getElementById("envelope-app")!,
  bus: acquireVsCodeApi(),
  editorFactory: new SceSimEditorFactory({ shouldLoadResourcesDynamically: true }),
});
