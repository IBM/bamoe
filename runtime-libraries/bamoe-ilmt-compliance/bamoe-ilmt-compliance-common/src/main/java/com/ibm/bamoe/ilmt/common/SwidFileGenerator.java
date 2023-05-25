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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;

public abstract class SwidFileGenerator {

    public void createSwidFile() {
        String swidContent = getSwidContent();

        try {
            Path filePath = getFilePath();
            Files.deleteIfExists(filePath);
            Files.createFile(filePath);
            Files.writeString(filePath, swidContent);
        } catch (IOException e) {
            throw new RuntimeException("Error creating swidtag.", e);
        }
    }

    public abstract Path getFilePath();

    public abstract String getResourceFileName();

    public String getSwidContent() {
        try (InputStream inputStream = getClass().getResourceAsStream(getResourceFileName());
             BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {

            StringBuilder swidContent = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                swidContent.append(line).append('\n');
            }

            return swidContent.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }
}
