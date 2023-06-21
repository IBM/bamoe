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
package com.ibm.bamoe.ilmt.common;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

public class SwidFileGeneratorTest {

    final Path swidFilePath = Paths.get("swid_file.xml");

    @AfterEach
    void clean() throws IOException{
        Files.deleteIfExists(swidFilePath);
    }

    @Test
    public void testBasicContentWriting() throws IOException {
        final String someContent = "<test>";

        SwidFileGenerator swidFileGenerator = new SwidFileGenerator() {
        @Override
        public Path getFilePath() {
            return swidFilePath;
        }
    
        public String getSwidContent() {
            return someContent;
        }};

        swidFileGenerator.createSwidFile();

        assertTrue(Files.exists(swidFilePath), "SWID file should be generated");
        assertEquals(swidFileGenerator.getSwidContent(), someContent, "SWID file content should match expected content");
    }
}