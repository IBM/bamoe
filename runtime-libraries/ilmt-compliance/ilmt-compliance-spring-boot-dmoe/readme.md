# This is a DMOE ILMT compliance library that every DMOE project should use.

This library uses the system variable SWIDTAG_DIR to determine the directory for creating a swidtag file. If the SWIDTAG_DIR variable is set, the library will use the specified directory for swidtag file creation. In cases where SWIDTAG_DIR is not set the library will default to the home directory of the hosting application.

It's important to note that if the SWIDTAG_DIR environment variable contains invalid content or an invalid path, the hosting application will fail to deploy.

The swidtag file is an XML file content based on ISO/IEC 19770-2:2015 specification. Here’s an example of the swidtag file content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SoftwareIdentity name="IBM Decision Manager Open Edition" tagId="ibm.com-3d9d28f19d0f45fda113c07fb481e3ea-9.0.0" version="9.0.0" versionScheme="multipartnumeric" xml:lang="en" xmlns="http://standards.iso.org/iso/19770/-2/2015/schema.xsd" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://standards.iso.org/iso/19770/-2/2015-current/schema.xsd schema.xsd">
    <Meta persistentId="3d9d28f19d0f45fda113c07fb481e3ea"/>
    <Meta generator="4-1-20210113"/>
    <Entity name="IBM" regid="ibm.com" role="licensor tagCreator softwareCreator"/>
</SoftwareIdentity>
```