package mapper;

import config.RootConfig;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
@Slf4j
@ActiveProfiles("prod")
public class MapperTests {

    @Setter(onMethod_ = @Autowired)
    private DataSource dataSource;

    @Value("${spring.profiles.active}")
    private String active;

    @Test
    public void sampleTest() {
        log.info("Sample Test");
    }

    @Test
    public void dataSourceTest() throws SQLException {
        log.info("dataSource Test {}", active);
        Connection con = dataSource.getConnection();
        log.info("Connected Schema Name: {}", con.getSchema());
    }
}