VERSION ?= 9.0.1

all: source
	mkdir -p build/release
	(cd build/release && cmake -G "Unix Makefiles" \
	-DLIBOMP_ARCH=x86_64 \
	-DLLVM_BINUTILS_INCDIR=/usr/include \
	-DLLVM_ABI_BREAKING_CHECKS=FORCE_OFF \
	-DLINK_POLLY_INTO_TOOLS=ON \
	-DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON \
	-DLLVM_BUILD_LLVM_DYLIB=ON \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_ENABLE_EH=ON \
	-DLLVM_ENABLE_FFI=ON \
	-DLLVM_ENABLE_LIBCXX=ON \
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_INSTALL_UTILS=ON \
	-DLLVM_OPTIMIZED_TABLEGEN=ON \
	-DLLVM_TARGETS_TO_BUILD=all \
	-DLLVM_ENABLE_PROJECTS=clang \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DWITH_POLLY=ON \
	-DLLDB_DISABLE_PYTHON=1 \
	-DLIBOMP_INSTALL_ALIASES=OFF ../../source/llvm && make)

source:
	wget https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$(VERSION).tar.gz
	tar xf llvmorg-$(VERSION).tar.gz
	mv llvm-project-llvmorg-$(VERSION) source

clean:
	rm -rf source build
