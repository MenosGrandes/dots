sudo apt install libclang-7-dev clang-7 clang-format-7


Commandline options:
-DASAN:BOOL="1" -D_libclang_LIBRARY:FILEPATH="/usr/lib/llvm-7/lib/libclang-7.so" -D_libclang_INCLUDE_DIR:PATH="/usr/lib/llvm-7/include/" -DREPROC_ENABLE_W4:BOOL="0" -DClang_FORMAT:FILEPATH="/usr/bin/clang-format-7" -DClang_EXECUTABLE:FILEPATH="/usr/bin/clang-7" -DASSERTS:BOOL="1" -DREPROC_BUILD_CXX_WRAPPER:BOOL="0" 


Cache file:
ASAN:BOOL=1
_libclang_LIBRARY:FILEPATH=/usr/lib/llvm-7/lib/libclang-7.so
_libclang_INCLUDE_DIR:PATH=/usr/lib/llvm-7/include/
REPROC_ENABLE_W4:BOOL=0
Clang_FORMAT:FILEPATH=/usr/bin/clang-format-7
Clang_EXECUTABLE:FILEPATH=/usr/bin/clang-7
ASSERTS:BOOL=1
REPROC_BUILD_CXX_WRAPPER:BOOL=0