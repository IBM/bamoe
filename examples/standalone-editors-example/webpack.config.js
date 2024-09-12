const CopyWebpackPlugin = require("copy-webpack-plugin");
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { ProvidePlugin } = require("webpack");

module.exports = (env) =>
  ({
    mode: "development",
    output: {
      path: path.join(__dirname, "dist"),
      filename: "[name].js",
    },
    entry: {
      "new-dmn-editor/state-control": "./src/new-dmn-editor/state-control/index.ts",
      "new-dmn-editor/read-only": "./src/new-dmn-editor/read-only/index.ts",
      "new-dmn-editor/with-included-models": "./src/new-dmn-editor/with-included-models/index.ts",
      "dmn-editor-classic/state-control": "./src/dmn-editor-classic/state-control/index.ts",
      "dmn-editor-classic/read-only": "./src/dmn-editor-classic/read-only/index.ts",
      "dmn-editor-classic/with-included-models": "./src/dmn-editor-classic/with-included-models/index.ts",
      "bpmn-editor-classic/state-control": "./src/bpmn-editor-classic/state-control/index.ts",
      "bpmn-editor-classic/read-only": "./src/bpmn-editor-classic/read-only/index.ts",
    },
    plugins: [
      new HtmlWebpackPlugin({
        filename: "new-dmn-editor/state-control.html",
        template: "./src/new-dmn-editor/state-control/index.html",
        chunks: ["new-dmn-editor/state-control"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "new-dmn-editor/read-only.html",
        template: "./src/new-dmn-editor/read-only/index.html",
        chunks: ["new-dmn-editor/read-only"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "new-dmn-editor/with-included-models.html",
        template: "./src/new-dmn-editor/with-included-models/index.html",
        chunks: ["new-dmn-editor/with-included-models"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "dmn-editor-classic/state-control.html",
        template: "./src/dmn-editor-classic/state-control/index.html",
        chunks: ["dmn-editor-classic/state-control"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "dmn-editor-classic/read-only.html",
        template: "./src/dmn-editor-classic/read-only/index.html",
        chunks: ["dmn-editor-classic/read-only"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "dmn-editor-classic/with-included-models.html",
        template: "./src/dmn-editor-classic/with-included-models/index.html",
        chunks: ["dmn-editor-classic/with-included-models"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "bpmn-editor-classic/state-control.html",
        template: "./src/bpmn-editor-classic/state-control/index.html",
        chunks: ["bpmn-editor-classic/state-control"],
        minify: false,
      }),
      new HtmlWebpackPlugin({
        filename: "bpmn-editor-classic/read-only.html",
        template: "./src/bpmn-editor-classic/read-only/index.html",
        chunks: ["bpmn-editor-classic/read-only"],
        minify: false,
      }),
      new ProvidePlugin({
        process: require.resolve("process/browser.js"),
        Buffer: ["buffer", "Buffer"],
      }),
      new CopyWebpackPlugin({
        patterns: [{ from: "./static", to: "static" }],
      }),
    ],
    module: {
      rules: [
        {
          test: /\.ts/,
          use: [
            {
              loader: require.resolve("ts-loader"),
            },
          ],
        },
      ]
    },
    resolve: {
      extensions: ['.js', '.jsx', '.ts', '.tsx'],
    },
    devServer: {
      static: [{ directory: path.join(__dirname, "./dist") }],
      compress: true,
      https: false,
      port: 9000,
      client: {
        overlay: false,
      },
    },
  });
