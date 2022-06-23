# 베이스 이미지 생성
FROM ubuntu:18.04

# Apache2 패키지 설치
RUN apt-get update && apt-get -y install apache2

# 웹 기본 페이지 생성
RUN echo 'Docker Container Application.' > /var/www/html/index.html

# 필요한 작업 경로 생성 (WORKDIR로 지정해도 됨.)
RUN mkdir /webapp

# Apache2에 필요한 환경변수, 디렉터리, 서비스 실행 등의 정봅를 쉘 스크립트에 작성하고 실행 권한 부여
RUN echo '. /etc/apache2/envvars' > /webapp/run_http.sh && \
    echo 'mkdir -p /var/run/apache2' >> /webapp/run_http.sh && \
    echo 'mkdir -p /var/lock/apache2' >> /webapp/run_http.sh && \
    echo '/usr/sbin/apache2 -D FOREGROUND' >> /webapp/run_http.sh && \
    chmod 744 /webapp/run_http.sh

# 80 포트 open
EXPOSE 80

# RUN 명령어로 작성된 쉘 스크립트를 컨테이너가 동작할 때 실행
CMD /webapp/run_http.sh
