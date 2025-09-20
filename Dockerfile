# 1. 使用与 .jar 文件兼容的 Java 17 作为基础镜像
FROM openjdk:17-jdk-alpine

# 2. (可选，但推荐) 安装字体支持，这在原始文件中存在
RUN apk --no-cache add fontconfig ttf-dejavu

# 3. 将 docker-run 目录中的文件复制到镜像内的正确位置
#    - 复制字体文件
COPY docker-run/times.ttf /usr/share/fonts/
#    - 复制应用程序配置文件
COPY docker-run/ /tmp/yml/
COPY docker-run/ /tmp/

# 4. 从网络直接下载并添加 .jar 文件
ADD https://github.com/wyt1215819315/autoplan/releases/download/v3.0.9-dev/auto_plan.jar /auto_plan.jar

# 5. 声明应用程序将使用的端口
EXPOSE 26666

# 6. 设置启动容器时执行的命令
#    Spring Boot应用会自动查找 /tmp/yml/application.yml 作为外部配置
CMD ["java", "-jar", "/auto_plan.jar"]