unit_test_files = [
    'Client'
]

unit_test_sources = [
    libthegamesdb_sources,
    'TestUtils.vala'
]

foreach name : unit_test_files
    test(name, executable(name, name + 'Test.vala', unit_test_sources, config_header, dependencies: libthegamesdb_deps, install: false), env: ['G_TEST_SRCDIR=' + meson.current_source_dir()])
endforeach