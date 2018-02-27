FROM ekidd/rust-musl-builder AS builder
ADD . ./
RUN sudo chown -R rust:rust /home/rust \
  && cargo build --release

FROM gcr.io/distroless/base
COPY --from=builder \
    /home/rust/src/target/x86_64-unknown-linux-musl/release/hello-rust \
    /usr/sbin/
ENTRYPOINT [ "/usr/sbin/hello-rust" ] 