# !/bin/sh

rm -rf coverage
mkdir coverage

flutter test --coverage
cp coverage/lcov.info coverage/lcov.unit.info

flutter test integration_test --coverage
cp coverage/lcov.info coverage/lcov.integration.info

lcov -a coverage/lcov.unit.info -a coverage/lcov.integration.info -o coverage/lcov.merged.info

lcov --remove coverage/lcov.merged.info 'lib/*.g.dart' 'lib/*.freezed.dart' 'lib/generated/*' -o coverage/lcov.info --ignore-errors unused