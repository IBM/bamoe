# 9.2.0
- New Test Scenario Editor compatible with DMN 1.5. It's a complete rewrite of the Test Scenario Editor (classic) and is the future of unit testing for DMN-based business Decisions.
- Changed default SVG generation settings to improve compatibility with the `src/main/resources/META-INF/processSVG` directory. When there's no customized configuration for SVG generation, SVG files are now placed in the same directory as the open file if not inside a `src/main/resources` structure, or on `src/main/resources/META-INF/processSVG/**/` if it is. The directory structure after `src/main/resources` is kept inside the `processSVG` dir. The same is true for DMN models, but the SVG directory is `META-INF/decisionSVG`.
- New Form generation command `> BAMOE Developer Tools: Generate form code for User Tasks` lets you generate code for User Tasks of BPMN models. You can select specific User Tasks and choose from the Bootstrap 4 and PatternFly UI libraries. The generated code is place inside the `src/main/resources/custom-forms-dev` directory.

# 9.1.1

- 

# 9.1.0

- 

# 9.0.1

- 

# 9.0.0

Initial release.
