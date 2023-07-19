# 微服务脚手架

## xxiaohei-cloud-framework

### xxiaohei-cloud-boot

springboot启动包，引入方式：

```xml
<dependency>
    <groupId>com.xxiaohei.cloud</groupId>
    <artifactId>xxiaohei-cloud-boot</artifactId>
    <version>${xxiaohei-cloud-boot.version}</version>
    <type>pom</type>
</dependency>
```

### xxiaohei-cloud-nacos

nacos引入方式：

```xml
<dependency>
    <groupId>com.xxiaohei.cloud</groupId>
    <artifactId>xxiaohei-cloud-nacos</artifactId>
    <version>${xxiaohei-cloud-nacos.version}</version>
    <type>pom</type>
</dependency>
```

### xxiaohei-cloud-feign

这个feign包只是用于api使用，引入方式：

```xml
<dependency>
    <groupId>com.xxiaohei.cloud</groupId>
    <artifactId>xxiaohei-cloud-feign</artifactId>
    <version>${xxiaohei-cloud-feign.version}</version>
    <type>pom</type>
</dependency>
```


## 增强类的包

### xxiaohei-feign-enhancer

feign增强的包在service服务使用，需要在使用的时候，在application.yml加上如下的配置：

```yaml
feign:
  httpclient:
    enabled: false
  okhttp:
    enabled: true
```
