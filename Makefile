all: test nits bench

.PHONY: test
test:
	cargo build --release
	cargo test --release

.PHONY: nits
nits:
	rustup component add rustfmt clippy
	cargo fmt -- --check
	cargo clean --doc
	cargo doc --no-deps
	cargo deadlinks

	cargo clippy --tests
	cargo clippy --tests --features "serde-1"
	cargo clippy --tests --features "reports"

.PHONY: bench
bench:
	EGG_TIME_LIMIT=60 cargo bench | ./scripts/filter-iai-output.py
