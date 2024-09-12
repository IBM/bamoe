## Standalone Editors Examples

A series of examples showing how to use the Standalone Editors libraries in different applications.

### Examples

- State Control: Shows how to leverage the Editor API to undo/redo changes to a Decision, get its contents and download an SVG of the diagram.
- Read Only: Loads the editor in "Read Only" mode, where a Decision or Process can be displayed and navigated but not changed.
- With Included Models (DMN Editor only): Displays how Decisions can be imported into other Decisions as "Included Models", using the `resources` parameter from the DMN Editor.

### Build

To build the examples, execute one of the following commands on the root folder of the project:

```shell script
npm run build
```

### Run

To start the examples application, execute the following command on the root folder of the project:

```shell script
npm run start
```

Open http://localhost:9000 to see the list of files bundled by webpack, then choose an example:

- State Control:
  - http://localhost:9000/new-dmn-editor/state-control.html
  - http://localhost:9000/dmn-editor-classic/state-control.html
  - http://localhost:9000/bpmn-editor-classic/state-control.html
- Read Only:
  - http://localhost:9000/new-dmn-editor/read-only.html
  - http://localhost:9000/dmn-editor-classic/read-only.html
  - http://localhost:9000/bpmn-editor-classic/read-only.html
- With Included Models:
  - http://localhost:9000/new-dmn-editor/with-included-models.html
  - http://localhost:9000/dmn-editor-classic/with-included-models.html
