import { DmnEditorStandaloneApi } from "@ibm/bamoe-standalone-dmn-editor/dist";
import { StandaloneEditorApi as BpmnStandaloneEditorApi } from "@ibm/bamoe-standalone-bpmn-and-dmn-editors-classic/dist/bpmn";
import { StandaloneEditorApi as DmnStandaloneEditorApi } from "@ibm/bamoe-standalone-bpmn-and-dmn-editors-classic/dist/dmn";

export function loadFile(fileName: string) {
  return fetch(`/static/models/${fileName}`).then((value) => value.text());
}

export function initFileLoader(files: Array<string>, editor: DmnEditorStandaloneApi | BpmnStandaloneEditorApi | DmnStandaloneEditorApi) {
  files.map((fileName) => {
    document.getElementById(fileName)?.addEventListener("click", () => {
      loadFile(fileName).then((fileContent) => editor.setContent(fileName, fileContent));
    });
  });
}
