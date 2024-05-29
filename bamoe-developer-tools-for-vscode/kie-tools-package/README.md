## IBM BAMOE Developer Tools

![vs-code-support](https://img.shields.io/badge/Visual%20Studio%20Code-1.66.0+-blue.svg)

Create, edit and visualize business processes (BPMN), decisions (DMN) and test scenarios (SceSim).

## Features

- Create and edit BPMN (\*.bpmn) and BPMN2 (\*.bpmn2) files.
- Create and edit DMN 1.1 and DMN 1.2 (\*.dmn) files using DMN Editor (classic).
- Create and edit DMN 1.2, 1.3, 1.4, and 1.5 (\*.dmn) files using the DMN Editor.
- Create and edit SceSim (\*.scesim) files with the Test Scenario Editor.
- Native keyboard shortcuts (Press `shift+/` to display available combinations).
- Export diagram to SVG (use the SVG icon on the top-right corner).

### Editing a new BPMN file

![alt](https://github.com/ibm/bamoe-developer-tools-for-vscode/gifs/bpmn.gif?raw=true)

### Editing a new DMN file

![alt](https://github.com/ibm/bamoe-developer-tools-for-vscode/gifs/dmn.gif?raw=true)

### Editing a new DMN file (classic)

![alt](https://github.com/ibm/bamoe-developer-tools-for-vscode/gifs/dmn-classic.gif?raw=true)

### Settings

| Setting                           | Description                                               | Default value                        |
| --------------------------------- | --------------------------------------------------------- | ------------------------------------ |
| `kogito.bpmn.runOnSave`           | Execute a command on each save operation of the BPMN file | _empty_                              |
| `kogito.bpmn.svgFilenameTemplate` | Filename template to be used when generating SVG files    | `${fileBasenameNoExtension}-svg.svg` |
| `kogito.bpmn.svgFilePath`         | Where to save generated SVG files                         | `${fileDirname}`                     |
| `kogito.dmn.runOnSave`            | Execute a command on each save operation of the DMN file  | _empty_                              |
| `kogito.dmn.svgFilenameTemplate`  | Filename template to be used when generating SVG files    | `${fileBasenameNoExtension}-svg.svg` |
| `kogito.dmn.svgFilePath`          | Where to save generated SVG files                         | `${fileDirname}`                     |

The `kogito.*.svgFilenameTemplate` and `kogito.*.svgFilePath` settings accept the following variables as tokens:

| Variable                       | Example                                   |
| ------------------------------ | ----------------------------------------- |
| **${workspaceFolder}**         | `/home/your-username/your-project`        |
| **${fileDirname}**             | `/home/your-username/your-project/folder` |
| **${fileExtname}**             | `.ext`                                    |
| **${fileBasename}**            | `file.ext`                                |
| **${fileBasenameNoExtension}** | `file`                                    |
