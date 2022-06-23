# 베이스 이미지 생성, AS 절에 단계 이름을 지정
FROM golang:1.15-alpine3.12 AS gobuilder-stage

# 작성자와 설명 작성
MAINTAINER test <test@example.com>
LABEL "purpose"="Service Deployment using Multi-stage builds."

# /usr/src/goapp 경로로 이동
WORKDIR /usr/src/goapp

# 현재 디렉토리의 goapp.go를 이미지 내부의 현재 경로에 복사
COPY goapp.go .

# GO언어 환경변수를 지정하고 /usr/local/bin 경로에 gostart 실행파일을 생성한다.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/gostart

# 두 번째 단계
FROM scratch AS runtime-stage

# 첫 번째 단계의 이름을 --from 옵션에 넣으면 해당 단계로부터 파일을 가져와서 복사
COPY --from=gobuilder-stage /usr/local/bin/gostart /usr/local/bin/gostart

# 컨테이너 실행 시 파일을 실행
CMD ["/usr/local/bin/gostart"]
