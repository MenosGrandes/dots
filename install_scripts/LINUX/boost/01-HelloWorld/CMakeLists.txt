project(boost_python_tests)
PYTHON_ADD_MODULE(hello hello.cpp)
FILE(COPY hello.py DESTINATION .)
ADD_TEST(NAME 01-HelloWorld COMMAND ${PYTHON_EXECUTABLE} hello.py)
