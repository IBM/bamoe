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
package com.ibm.bamoe.ilmt.dmoe;

import io.quarkus.runtime.Startup;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;

import com.ibm.bamoe.ilmt.common.SwidFileGenerator;

import java.nio.file.Path;
import java.nio.file.Paths;

@Startup
@ApplicationScoped
public class DMOESwidTagGen extends SwidFileGenerator {

    @PostConstruct
    public void createSwidFile() {
        super.createSwidFile();
    }

    public Path getFilePath() {
        return Paths.get( "ibm.com_IBM_Decision_Manager_Open_Edition-9.0.0.swidtag");
    }

    @Override
    public String getResourceFileName() {
        return "/ibm.com_IBM_Decision_Manager_Open_Edition.swidtag";
    }
}
