package com.xxiaohei.tool;

import com.mybatisflex.codegen.Generator;
import com.mybatisflex.codegen.config.ColumnConfig;
import com.mybatisflex.codegen.config.GlobalConfig;
import com.xxiaohei.mybatis.entity.BaseDO;
import com.zaxxer.hikari.HikariDataSource;

/**
 * MybatisFlex代码生成器
 *
 * @author xxiaohei
 * @since 2023-08-08 21:04
 */
public class MybatisFlexCodegen {
    private static final String BASE_PACKAGE = "com.xxiaohei.cloud.database";

    private static final String TABLE_PREFIX = "";
    private static final String[] GENERATE_TABLE = new String[]{"sys_user", "sys_role", "sys_user_role", "sys_permission", "sys_role_permission"};
    private static final String SOURCE_DIR = "D:\\Java\\xxiaohei-cloud\\cloud-core-services\\xxiaohei-oauth2-server\\xxiaohei-oauth2-server-service\\src\\main\\java";
    private static final String MAPPER_XML_PATH = "D:\\Java\\xxiaohei-cloud\\cloud-core-services\\xxiaohei-oauth2-server\\xxiaohei-oauth2-server-service\\src\\main\\resources\\mapper";

    public static void main(String[] args) {
        //配置数据源
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/user_center?characterEncoding=utf-8");
        dataSource.setUsername("root");
        dataSource.setPassword("xxiaohei");

        //创建配置内容，两种风格都可以。
//        GlobalConfig globalConfig = createGlobalConfigUseStyle1();
        GlobalConfig globalConfig = createGlobalConfigUseStyle2();

        //通过 datasource 和 globalConfig 创建代码生成器
        Generator generator = new Generator(dataSource, globalConfig);

        //生成代码
        generator.generate();
    }

    public static GlobalConfig createGlobalConfigUseStyle1() {
        //创建配置内容
        GlobalConfig globalConfig = new GlobalConfig();

        //设置根包
        globalConfig.setBasePackage(BASE_PACKAGE);

        //设置表前缀和只生成哪些表
        globalConfig.setTablePrefix(TABLE_PREFIX);
        globalConfig.setGenerateTable(GENERATE_TABLE);

        //设置生成 entity 并启用 Lombok
        globalConfig.setEntityGenerateEnable(true);
        globalConfig.setEntityWithLombok(true);

        //设置生成 mapper
        globalConfig.setMapperGenerateEnable(true);

        //可以单独配置某个列
        ColumnConfig columnConfig = new ColumnConfig();
        columnConfig.setColumnName("is_deleted");
        columnConfig.setLogicDelete(true);
        globalConfig.setColumnConfig("sys_user", columnConfig);

        return globalConfig;
    }

    public static GlobalConfig createGlobalConfigUseStyle2() {
        //创建配置内容
        GlobalConfig globalConfig = new GlobalConfig();

        //设置根包
        globalConfig.getPackageConfig()
                .setSourceDir(SOURCE_DIR)
                .setMapperXmlPath(MAPPER_XML_PATH)
                .setBasePackage(BASE_PACKAGE);

        //设置表前缀和只生成哪些表，setGenerateTable 未配置时，生成所有表
        globalConfig.getStrategyConfig()
                .setTablePrefix(TABLE_PREFIX)
                .setGenerateTable(GENERATE_TABLE);

        //设置生成 entity 并启用 Lombok
        globalConfig.enableEntity()
                .setClassSuffix("DO")
                .setWithLombok(true)
                .setSuperClass(BaseDO.class);

        //设置生成 mapper
        globalConfig.enableMapper()
                .setClassSuffix("Mapper");

        globalConfig.enableMapperXml()
                .setFileSuffix("Mapper");

        //可以单独配置某个列
        ColumnConfig columnConfig = new ColumnConfig();
        columnConfig.setColumnName("is_deleted");
        columnConfig.setLogicDelete(true);
        globalConfig.getStrategyConfig()
                .setColumnConfig(columnConfig);

        return globalConfig;
    }

}