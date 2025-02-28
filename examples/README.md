#  Example applications for IBM Business Automation Manager Open Editions

This folder contains a collection of examples showcasing the capabilities of [IBM Business Automation Manager Open Editions](https://www.ibm.com/products/business-automation-manager-open-editions) (BAMOE).

Each top-level directory features a self-contained project that highlights a specific use case, covering various aspects of BAMOE—from Processes, Decisions, and Rules to integrations with libraries like Standalone Editors.

To explore and run these examples, follow the instructions provided in each directory’s `README.md` file.

---

### Contributing

- To share ideas, propose new features, or suggest enhancements, refer to https://ibm.biz/bamoe-ideas
- To report a problem, please file a Support Ticket at https://www.ibm.com/mysupport
- For casual discussions and to see what others have shared, visit [IBM Open Editions Community](https://community.ibm.com/community/user/automation/communities/community-home?CommunityKey=6c04b811-cff1-4f31-bb5c-0185982de671)


---

### Building all Maven-based examples

For convenience, a top-level `pom.xml` is included. Running:

```bash
# Maven 3.9.6 required.
mvn clean package -DskipTests -DskipITs
```

will build all Maven-based examples. For more details, like specific profiles or running Docker compose, please refer to each example individually.