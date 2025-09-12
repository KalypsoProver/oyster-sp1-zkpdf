FROM --platform=linux/amd64 ghcr.io/succinctlabs/sp1:v5.2.1

RUN apt update && apt install -y clang libssl-dev pkg-config build-essential curl git time

ENV PATH="/root/.sp1/bin:$PATH"

RUN curl -L https://sp1.succinct.xyz | bash

WORKDIR /app

COPY evm /app/evm
COPY digitally_signed.pdf /app/digitally_signed.pdf
RUN ~/.sp1/bin/sp1up --version v5.2.1
RUN cargo prove --version


ENTRYPOINT ["time","/app/evm","--system", "groth16", "--pdf-path", "/app/digitally_signed.pdf"]