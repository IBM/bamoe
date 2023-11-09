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

import static com.github.stefanbirkner.systemlambda.SystemLambda.withEnvironmentVariable;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.jupiter.api.Test;

public class SwidFileGeneratorTest {

    final String someContent = "<test>";

    class TestSwidFileGenerator extends SwidFileGenerator {

        @Override
        public String getFileName() {
            return "swid_file.xml";
        }

        @Override
        public String getSwidContent() {
            return someContent;
        }
    }

    @Test
    public void testBasicContentWriting() throws IOException {
        TestSwidFileGenerator swidFileGenerator = new TestSwidFileGenerator();
        swidFileGenerator.createSwidFile();

        assertTrue(Files.exists(Paths.get(swidFileGenerator.getFileName())), "SWID file should be generated");
        assertEquals(swidFileGenerator.getSwidContent(), someContent,
                "SWID file content should match expected content");
    }

    @Test
    void testEnvVarInvalid() throws Exception {
        TestSwidFileGenerator swidFileGenerator = new TestSwidFileGenerator();
        withEnvironmentVariable("SWIDTAG_DIR", "invalid content here")
                .execute(() -> {
                    try {
                        swidFileGenerator.createSwidFile();
                        fail("swid file couldn't be generated - invalid value");
                    } catch (RuntimeException ex) {
                    }
                });
    }

    @Test
    void testEnvVarNoValue() throws Exception {
        TestSwidFileGenerator swidFileGenerator = new TestSwidFileGenerator();

        withEnvironmentVariable("SWIDTAG_DIR", "")
                .execute(() -> {
                    swidFileGenerator.createSwidFile();

                    assertTrue(Files.exists(Paths.get(swidFileGenerator.getFileName())), "SWID file should be generated");
                    assertEquals(swidFileGenerator.getSwidContent(), someContent,
                            "SWID file content should match expected content");
                });
    }

    @Test
    void testEnvVarCorrect() throws Exception {
        TestSwidFileGenerator swidFileGenerator = new TestSwidFileGenerator();

        Path tempDir = Files.createTempDirectory("mytestPrefix");

        withEnvironmentVariable("SWIDTAG_DIR", tempDir.toFile().getAbsolutePath())
                .execute(() -> {
                    System.out.println(System.getenv("SWIDTAG_DIR"));

                    swidFileGenerator.createSwidFile();

                    assertTrue(swidFileGenerator.getFilePath().equals(Paths.get(tempDir.toFile().getAbsolutePath(), swidFileGenerator.getFileName())));
                    assertEquals(swidFileGenerator.getSwidContent(), someContent,
                            "SWID file content should match expected content");
                });
    }    
}