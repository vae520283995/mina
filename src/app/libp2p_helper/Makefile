.PHONY: libp2p_helper clean test
.DEFAULT_GOAL := libp2p_helper

ifeq ($(GO),)
GO := go
endif

../../libp2p_ipc/libp2p_ipc.capnp.go:
	make -C ../../libp2p_ipc libp2p_ipc.capnp.go

libp2p_helper: ../../libp2p_ipc/libp2p_ipc.capnp.go
	$(WRAPAPP) ../../../scripts/build-go-helper.sh libp2p_helper

test: ../../libp2p_ipc/libp2p_ipc.capnp.go
	cd src/libp2p_helper && $(GO) test -short -timeout 15m

test-bs-qc: ../../libp2p_ipc/libp2p_ipc.capnp.go
	cd src/libp2p_helper \
		&& (ulimit -n 65536 || true) \
		&& $(GO) test -timeout 40m -run "^TestBitswapQC$$"

test-large: ../../libp2p_ipc/libp2p_ipc.capnp.go
	cd src/libp2p_helper \
		&& (ulimit -n 65536 || true) \
		&& $(GO) test -timeout 40m -run "^TestBitswapMedium$$" \
		&& $(GO) test -timeout 40m -run "^TestBitswapJumbo$$"

clean:
	rm -rf result ../../libp2p_ipc/libp2p_ipc.capnp.go
