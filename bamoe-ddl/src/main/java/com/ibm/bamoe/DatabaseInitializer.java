package com.ibm.bamoe;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Set;
import java.util.stream.Collectors;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.quarkus.runtime.Startup;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class DatabaseInitializer {
    private static final Logger LOGGER = LoggerFactory.getLogger(DatabaseInitializer.class);
    private static final String SCRIPT_DIRECTORY = "postgresql";

    @Inject
    private DataSource dataSource;

    @Startup
    public void init() {
        final var scripts = getSqlScripts(SCRIPT_DIRECTORY);
        try (var connection = dataSource.getConnection()) {
            scripts.stream()
                    .map(this::readSql)
                    .forEach(sql -> executeSql(connection, sql));
        } catch (final SQLException e) {
            LOGGER.error("Unable to access database");
        }
    }

    private Set<Path> getSqlScripts(final String directory) {
        try (var stream = Files.list(Paths.get(directory))) {
            return stream
                    .filter(path -> Files.isRegularFile(path) && path.toString().endsWith(".sql"))
                    .collect(Collectors.toSet());
        } catch (final IOException e) {
            LOGGER.error("Unable to open directory: {}", directory);
            throw new RuntimeException("Unable to open directory");
        }
    }

    private String readSql(final Path script) {
        try {
            return Files.readString(script);
        } catch (final IOException e) {
            LOGGER.error("Unable to read sql script: {}", script.getFileName());
            throw new RuntimeException("Unable to read sql script");
        }
    }

    private void executeSql(final Connection connection, final String sql) {
        try (var statement = connection.createStatement()) {
            statement.execute(sql);
        } catch (final SQLException e) {
            final var errorMessage = "Unable to execute sql script";
            LOGGER.error(errorMessage);
            throw new RuntimeException(errorMessage);
        }
    }
}
