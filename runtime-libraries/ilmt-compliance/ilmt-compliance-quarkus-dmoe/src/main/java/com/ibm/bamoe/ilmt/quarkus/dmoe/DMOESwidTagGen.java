/**
 * Copyright IBM Corp. 2023
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ibm.bamoe.ilmt.quarkus.dmoe;

import io.quarkus.runtime.Startup;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;

import com.ibm.bamoe.ilmt.common.SwidFileGenerator;

@Startup
@ApplicationScoped
public class DMOESwidTagGen extends SwidFileGenerator {

    @PostConstruct
    public void createSwidFile() {
        super.createSwidFile();
    }

    public String getFileName() {
        return "ibm.com_IBM_Decision_Manager_Open_Edition-9.0.1.swidtag";
    }

    @Override
    public String getSwidContent() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
                "<SoftwareIdentity xmlns=\"http://standards.iso.org/iso/19770/-2/2015/schema.xsd\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" name=\"IBM Decision Manager Open Edition\" tagId=\"ibm.com-a46f72acb4204f1c8b27228722103341-9.1.0\" version=\"9.1.0\" versionScheme=\"multipartnumeric\" xml:lang=\"en\" xsi:schemaLocation=\"http://standards.iso.org/iso/19770/-2/2015-current/schema.xsd schema.xsd\">\n" +
                "    <Meta persistentId=\"a46f72acb4204f1c8b27228722103341\"/>\n" +
                "    <Meta generator=\"4-1-20210113\"/>\n" +
                "    <Entity name=\"IBM\" regid=\"ibm.com\" role=\"licensor tagCreator softwareCreator\"/>\n" +
                "</SoftwareIdentity>";
    }
}
