files = [
    "afcv3_1_rtm_lamp_ctrl.vhd",
]

fetchto = "../../ip_cores"

modules = {
    "local" : [
        "../..",
    ],
    "git" : [
        "https://github.com/lnls-dig/infra-cores.git",
        "https://github.com/lnls-dig/general-cores.git",
        "https://github.com/lnls-dig/afc-gw.git",
    ],
}
