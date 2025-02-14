import { EditorEnvelopeLocator, EnvelopeContentType, EnvelopeMapping } from "@kie-tools-core/editor/dist/api";
import * as KieToolsVsCodeExtensions from "@kie-tools-core/vscode-extension";
import * as vscode from "vscode";

export function activate(context: vscode.ExtensionContext) {
  console.info("Extension is alive.");

  KieToolsVsCodeExtensions.startExtension({
    extensionName: "ibm.bamoe-developer-tools",
    context: context,
    viewType: "bamoeDeveloperToolsWebviewEditorsBpmn",
    generateSvgCommandId: "extension.ibm.bamoe.generatePreviewSvgBpmn",
    silentlyGenerateSvgCommandId: "extension.ibm.bamoe.silentlyGenerateSvgBpmn",
    editorEnvelopeLocator: new EditorEnvelopeLocator("vscode", [
      new EnvelopeMapping({
        type: "bpmn",
        filePathGlob: "**/*.bpmn?(2)",
        resourcesPathPrefix: "dist/webview/editors/bpmn",
        envelopeContent: { type: EnvelopeContentType.PATH, path: "dist/webview/BpmnEditorEnvelopeApp.js" },
      }),
    ]),
  });

  KieToolsVsCodeExtensions.startExtension({
    extensionName: "ibm.bamoe-developer-tools",
    context: context,
    viewType: "bamoeDeveloperToolsNewWebviewEditorsDmn",
    generateSvgCommandId: "extension.ibm.bamoe.generatePreviewSvgDmn",
    silentlyGenerateSvgCommandId: "extension.ibm.bamoe.silentlyGenerateSvgDmn",
    editorEnvelopeLocator: new EditorEnvelopeLocator("vscode", [
      new EnvelopeMapping({
        type: "dmn",
        filePathGlob: "**/*.dmn",
        resourcesPathPrefix: "",
        envelopeContent: { type: EnvelopeContentType.PATH, path: "dist/webview/NewDmnEditorEnvelopeApp.js" },
      }),
    ]),
  });

  KieToolsVsCodeExtensions.startExtension({
    extensionName: "ibm.bamoe-developer-tools",
    context: context,
    viewType: "bamoeDeveloperToolsWebviewEditorsDmnClassic",
    generateSvgCommandId: "extension.ibm.bamoe.classic.generatePreviewSvgDmn",
    silentlyGenerateSvgCommandId: "extension.ibm.bamoe.classic.silentlyGenerateSvgDmn",
    editorEnvelopeLocator: new EditorEnvelopeLocator("vscode", [
      new EnvelopeMapping({
        type: "dmn",
        filePathGlob: "**/*.dmn",
        resourcesPathPrefix: "dist/webview/editors/dmn",
        envelopeContent: { type: EnvelopeContentType.PATH, path: "dist/webview/ClassicDmnEditorEnvelopeApp.js" },
      }),
    ]),
  });

  KieToolsVsCodeExtensions.startExtension({
    extensionName: "ibm.bamoe-developer-tools",
    context: context,
    viewType: "bamoeDeveloperToolsWebviewEditorsSceSim",
    editorEnvelopeLocator: new EditorEnvelopeLocator("vscode", [
      new EnvelopeMapping({
        type: "scesim",
        filePathGlob: "**/*.scesim",
        resourcesPathPrefix: "dist/webview/editors/scesim",
        envelopeContent: { type: EnvelopeContentType.PATH, path: "dist/webview/SceSimEditorEnvelopeApp.js" },
      }),
    ]),
  });

  console.info("Extension is successfully setup.");
}

export function deactivate() {
  console.info("Extension is deactivated.");
}
