# 9.2.0
- Changed default SVG generation settings to improve compatibility with the `src/main/resources/META-INF/processSVG` directory. When there's no customized configuration for SVG generation, SVG files are now placed in the same directory as the open file if not inside a `src/main/resources` structure, or on `src/main/resources/META-INF/processSVG/**/` if it is. The directory structure after `src/main/resources` is kept inside the `processSVG` dir. The same is true for DMN models, but the SVG directory is `META-INF/decisionSVG`.

# 9.1.1

- 

# 9.1.0

- 

# 9.0.1

- 

# 9.0.0

Initial release.
