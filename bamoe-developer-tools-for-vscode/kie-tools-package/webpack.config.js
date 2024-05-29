const CopyWebpackPlugin = require("copy-webpack-plugin");
const patternflyBase = require("@kie-tools-core/patternfly-base");
const stunnerEditors = require("@kie-tools/stunner-editors");
const vscodeJavaCodeCompletionExtensionPlugin = require("@kie-tools/vscode-java-code-completion-extension-plugin");
const { merge } = require("webpack-merge");
const { ProvidePlugin } = require("webpack");
const common = require("@kie-tools-core/webpack-base/webpack.common.config");

const commonConfig = (env) =>
  merge(common(env), {
    output: {
      library: "BamoeDeveloperToolsForVsCode",
      libraryTarget: "umd",
      umdNamedDefine: true,
      globalObject: "this",
    },
    externals: {
      vscode: "commonjs vscode",
    },
  });

module.exports = async (env) => [
  merge(commonConfig(env), {
    target: "node",
    entry: {
      "extension/extension": "./src/extension/extension.ts",
    },
  }),
  merge(commonConfig(env), {
    target: "webworker",
    entry: {
      "extension/extensionWeb": "./src/extension/extension.ts",
    },
    plugins: [
      new ProvidePlugin({
        process: require.resolve("process/browser.js"),
        Buffer: ["buffer", "Buffer"],
      }),
    ],
  }),
  merge(commonConfig(env), {
    target: "web",
    entry: {
      "webview/BpmnEditorEnvelopeApp": "./src/webview/BpmnEditorEnvelopeApp.ts",
      "webview/ClassicDmnEditorEnvelopeApp": "./src/webview/ClassicDmnEditorEnvelopeApp.ts",
      "webview/SceSimEditorEnvelopeApp": "./src/webview/SceSimEditorEnvelopeApp.ts",
      "webview/NewDmnEditorEnvelopeApp": "./src/webview/NewDmnEditorEnvelopeApp.ts",
    },
    module: {
      rules: [...patternflyBase.webpackModuleRules],
    },
    plugins: [
      new ProvidePlugin({
        process: require.resolve("process/browser.js"),
        Buffer: ["buffer", "Buffer"],
      }),
      new CopyWebpackPlugin({
        patterns: [
          {
            from: stunnerEditors.bpmnEditorPath(),
            to: "webview/editors/bpmn",
            globOptions: { ignore: ["**/WEB-INF/**/*", "**/*.html"] },
          },
          {
            from: stunnerEditors.dmnEditorPath(),
            to: "webview/editors/dmn",
            globOptions: { ignore: ["**/WEB-INF/**/*", "**/*.html"] },
          },
          {
            from: stunnerEditors.scesimEditorPath(),
            to: "webview/editors/scesim",
            globOptions: { ignore: ["**/WEB-INF/**/*", "**/*.html"] },
          },
          {
            from: stunnerEditors.dmnEditorPath(),
            to: "target/dmn",
            globOptions: { ignore: ["**/WEB-INF/**/*", "**/*.html"] },
          },
          {
            from: vscodeJavaCodeCompletionExtensionPlugin.path(),
            to: "server/",
            globOptions: { ignore: ["**/WEB-INF/**/*", "**/*.html"] },
          },
        ],
      }),
    ],
    resolve: {
      fallback: {
        stream: require.resolve("stream-browserify"),
        buffer: require.resolve("buffer/"),
      },
    },
  }),
];
