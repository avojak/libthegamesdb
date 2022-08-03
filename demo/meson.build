executable(
    'thegamesdb-' + major_version + '-demo',

    'TheGamesDBDemo.vala',
    join_paths('Utils', 'EnumUtils.vala'),
    join_paths('Views', 'Games', 'GamesView.vala'),
    join_paths('Views', 'Games', 'GamesByName.vala'),

    dependencies: [
        libthegamesdb_dep,
        dependency('gtk+-3.0', version: '>= 3.6.4')
    ],

    install: true,
)

applications_dir = join_paths(
    get_option('prefix'),
    get_option('datadir'),
    'applications'
)

install_data(
    'com.github.avojak.thegamesdb-' + major_version + '.demo.desktop',
    install_dir: applications_dir
)