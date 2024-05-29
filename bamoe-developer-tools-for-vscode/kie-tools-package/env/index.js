const { varsWithName, composeEnv } = require("@kie-tools-scripts/build-env");

module.exports = composeEnv([require("@kie-tools/root-env/env")], {
  vars: varsWithName({}),
  get env() {
    return {};
  },
});
