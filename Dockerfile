# ================= 第一阶段：编译与打包 =================
# 使用包含 Maven 和 JDK 的镜像进行编译
FROM maven:3.9-eclipse-temurin-17 AS builder

# 设置工作目录
WORKDIR /build

# 复制 Maven 依赖配置文件，利用 Docker 缓存层加速依赖下载
COPY pom.xml .
RUN mvn dependency:go-offline -B

# 复制项目源代码
COPY src ./src

# 执行 Maven 打包命令（跳过测试以加快构建速度）
RUN mvn clean package -Dmaven.test.skip=true

# ================= 第二阶段：构建最终镜像 =================
# 使用轻量级的 JRE 运行环境
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# 从第一阶段（builder）的 target 目录中复制打好的 JAR 包
# 请将 'your-app-name-0.0.1-SNAPSHOT.jar' 替换为你实际生成的 JAR 包名称
COPY --from=builder /build/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]