FROM golang:1.22-alpine as tester

RUN apk --no-cache add make

COPY git-tester /tmp/git-tester
RUN rm -f /tmp/git-tester/.git
RUN make -C /tmp/git-tester build

FROM rust:1.76-slim-buster

ENV TEST_RUNNER=/tmp/tester
COPY --from=tester /tmp/git-tester/dist/main.out ${TEST_RUNNER}

RUN apt update && \
	apt install --no-install-recommends --yes jq && \
	rm -r /var/lib/apt/lists

WORKDIR /tmp/app

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Cargo.toml,Cargo.lock"
ENV TEST_CASES_FILE="/tmp/app/test-cases.json"
ENV TEST_DIR="/tmp/app"
ENV TARGET_DIR="/tmp/app/target"

ENTRYPOINT ["/tmp/app/test.sh"]
