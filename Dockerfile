# 1. Use Java 17 as the base image
FROM openjdk:17-jdk-alpine

# 2. Set up a working directory
WORKDIR /app

# 3. Add the required SQLite database driver directly from Maven Central
ADD https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.36.0.3/sqlite-jdbc-3.36.0.3.jar /app/lib/sqlite-jdbc.jar

# 4. Copy required local files from your project
COPY docker-run/times.ttf /usr/share/fonts/
COPY docker-run/ /tmp/yml/
COPY docker-run/ /tmp/
# 5. Add the application JAR
ADD https://github.com/wyt1215819315/autoplan/releases/download/v2.11/auto_plan.jar /app/auto_plan.jar

# 6. Expose the port
EXPOSE 26666

# 7. Final command to run the application, including the SQLite driver in the classpath
CMD ["java", "-cp", "/app/auto_plan.jar:/app/lib/sqlite-jdbc.jar", "org.springframework.boot.loader.JarLauncher"]