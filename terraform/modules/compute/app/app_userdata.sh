#!/bin/bash
set -eux
export DEBIAN_FRONTEND=noninteractive

# 1. Update OS
apt-get update -y

# 2. Install Java (Spring Boot / Tomcat compatible)
apt-get install -y openjdk-17-jdk curl unzip

# 3. Create Tomcat user
useradd -m -U -d /opt/tomcat -s /bin/false tomcat || true

# 4. Install Tomcat
TOMCAT_VERSION=9.0.86

curl -fLO \
https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz


mkdir -p /opt/tomcat
tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1
chown -R tomcat:tomcat /opt/tomcat

# 5. Create systemd service
cat >/etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

mkdir -p /opt/tomcat/webapps/health/WEB-INF
chown -R tomcat:tomcat /opt/tomcat/webapps
chown -R tomcat:tomcat /opt/tomcat/webapps/health

cat <<EOF >/opt/tomcat/webapps/health/WEB-INF/web.xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         version="3.1">

  <servlet>
    <servlet-name>health</servlet-name>
    <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
  </servlet>

  <servlet-mapping>
    <servlet-name>health</servlet-name>
    <url-pattern>/health</url-pattern>
  </servlet-mapping>

</web-app>
EOF


# 6. Enable and start Tomcat
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# 7. Prepare deployment directory
mkdir -p /opt/tomcat/webapps
chown -R tomcat:tomcat /opt/tomcat/webapps

echo "Tomcat installed. Waiting for application artifact."
