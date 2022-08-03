conf_data = configuration_data()
conf_data.set('MAJOR_VERSION', major_version)
conf_data.set('MINOR_VERSION', minor_version)
conf_data.set('MICRO_VERSION', micro_version)
conf_data.set('VERSION_STRING', version_string)

config_header = configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)

libthegamesdb_sources = files(
    join_paths('Models', 'Game.vala'),
    join_paths('Models', 'GameImage.vala'),
    join_paths('Models', 'Platform.vala'),
    join_paths('Requests', 'AbstractPagedRequest.vala'),
    join_paths('Requests', 'AbstractRequest.vala'),
    join_paths('Requests', 'GamesByNameRequest.vala'),
    join_paths('Requests', 'Request.vala'),
    join_paths('GameFieldFlags.vala'),
    join_paths('GameIncludeFlags.vala'),
    join_paths('Utils', 'EnumUtils.vala'),
    join_paths('Utils', 'JsonUtils.vala'),
    join_paths('APIResponse.vala'),
    join_paths('Client.vala'),
    join_paths('Errors.vala')
)

# Define all the names and versions
thegamesdb_gi_name = 'TheGamesDB'
thegamesdb_gi_version = version_string

thegamesdb_gi = thegamesdb_gi_name + '-' + thegamesdb_gi_version
thegamesdb_gir = thegamesdb_gi + '.gir'
thegamesdb_typelib = thegamesdb_gi + '.typelib'

include_dir = join_paths(
    get_option('prefix'),
    get_option('includedir'),
    meson.project_name()
)

libthegamesdb = library(
    meson.project_name (),
    config_header,
    libthegamesdb_sources,

    dependencies: [
        libthegamesdb_deps
    ],

    vala_header: 'thegamesdb-' + major_version + '.h',
    vala_vapi: 'thegamesdb-' + major_version + '.vapi',
    vala_gir: thegamesdb_gir,

    version: meson.project_version(),
    install: true,
    install_dir: [true, include_dir, true, true]
)

install_data(
    'thegamesdb-1.deps',
    install_dir: join_paths(get_option('datadir'), 'vala', 'vapi')
)

if get_option('introspection')
    g_ir_compiler = find_program('g-ir-compiler')
    custom_target(
        thegamesdb_typelib,
        command: [
            g_ir_compiler,
            '--shared-library',
            '@PLAINNAME@',
            '--output',
            '@OUTPUT@',
            join_paths(meson.current_build_dir(), thegamesdb_gir),
        ],
        input: libthegamesdb,
        output: thegamesdb_typelib,
        depends: libthegamesdb,
        install: true,
        install_dir: join_paths(get_option('libdir'), 'girepository-1.0'),
    )
endif

libthegamesdb_dep = declare_dependency(
    link_with: libthegamesdb,
    dependencies: libthegamesdb_deps,
    include_directories: [include_directories('.')]
)

# generate pkgconfig file
thegamesdb_pc = pkgconfig.generate(
    libthegamesdb,
    name: meson.project_name(),
    requires: libthegamesdb_deps,
    subdirs: ['thegamesdb-' + major_version],
    description: 'GObject-based client library for TheGamesDB API',
    version: meson.project_version(),
    url: 'https://github.com/avojak/libthegamesdb',
)