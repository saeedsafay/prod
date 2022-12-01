({
    baseUrl: ".",
    mainConfigFile: 'main.js',

    name: "main",
    out: "main-built.js",


    skipModuleInsertion: true,
    optimize: "uglify",
    normalizeDirDefines: "all",
    skipDirOptimize: false,
})