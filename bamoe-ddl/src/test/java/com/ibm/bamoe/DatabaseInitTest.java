package com.ibm.bamoe;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;

@QuarkusTest
@TestInstance(Lifecycle.PER_CLASS)
public class DatabaseInitTest {

    @Inject
    private DataSource dataSource;

    private static List<String> tables = new ArrayList<>();

    @BeforeAll
    void init() {
        try (var connection = dataSource.getConnection()) {
            final var metaData = connection.getMetaData();
            final var resultSet = metaData.getTables(null, null, "%", new String[] { "TABLE" });
            while (resultSet.next()) {
                tables.add(resultSet.getString("TABLE_NAME"));
            }
        } catch (final SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testTableCount() {
        assertEquals(42, tables.size());
    }

    @Test
    public void testSelectQueryOnTables() {
        for (final var table : tables) {
            final var query = "SELECT COUNT(*) FROM " + table;
            try (var connection = dataSource.getConnection();
                    var statement = connection.prepareStatement(query)) {
                assertDoesNotThrow(() -> {
                    statement.execute();
                }, "Unable to run select query on table: " + table);
            } catch (final SQLException e) {
                fail("Unexpected exception was thrown: " + e.getMessage());
            }
        }
    }
}
