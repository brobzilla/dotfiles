# Launch gdb for fire project in tui mode.
#
# Usage: debug [PROJECT e.g., fire] [EXECUTABLE e.g., player]
debug() {
    # Arguments.
    PROJECT="$1"
    EXECUTABLE="$2"

    if [[ $PROJECT == fire ]]; then
        IP=$FIRE_IP
    fi
    if [[ $PROJECT == xorn ]]; then
        IP=$XORN_IP
    fi
    if [[ $PROJECT == intel ]]; then
        IP=$INTEL_IP
    fi

    # Default gdbserver port is 9000.
    PORT="9000"

    # Toolchain prefix.
    if [[ $PROJECT == fire ]]; then
        TRIPLE="armv7-linux-"
    fi
    if [[ $PROJECT == xorn ]]; then
        TRIPLE="arm-linux-gnueabihf-"
    fi
    if [[ $PROJECT == intel ]]; then
        TRIPLE=""
    fi

    # Paths.
    CHECKOUT_PARENT="/home/$USER" # Where your svn-checkout sits.
    PROJECT_ROOT="$CHECKOUT_PARENT/$PROJECT" # Where you checked out this project.
    SYSROOT="${PROJECT_ROOT}/projects/$PROJECT/targetfs"

    if [[ $PROJECT == fire ]]; then
        TARGET_BIN="${PROJECT_ROOT}/projects/$PROJECT/targetfs/usr/local/bin"
    fi
    if [[ $PROJECT == xorn ]]; then
        TARGET_BIN="${PROJECT_ROOT}/projects/$PROJECT/targetfs/root/videon/usr/local/bin"
    fi
    # Intel has an unfortunately different layout handled here.
    if [[ $PROJECT == intel ]]; then
        TARGET_BIN="${PROJECT_ROOT}/intelce/project_build_i686/IntelCE/root/usr/local/bin"
        PROJECT_ROOT="/home/evan/Projects/intel/"
        SYSROOT="${PROJECT_ROOT}/intelce/project_build_i686/IntelCE/root"
    fi

    GDB="${PROJECT_ROOT}/projects/$PROJECT/toolchain/bin/${TRIPLE}gdb"
    EXEC_PATH="${TARGET_BIN}/$EXECUTABLE"
    P_SCRIPT=$TARGET_BIN/p
    PORT=`cat $P_SCRIPT | grep gdbserver | grep COMMAND | cut -f 4 -d' ' | cut -f 2 -d:`

    if [[ $PROJECT == intel ]]; then
        GDB="gdb"
    fi

    # Move into dir that we can drop our exported breakpoint files into.
    cd $PROJECT_ROOT

    # Start gdb with gui.
    $GDB                                   \
        --ex "set sysroot ${SYSROOT}"      \
        --ex "target exec ${EXEC_PATH}"    \
        --ex "target remote ${IP}:${PORT}" \
        --ex "symbol-file ${EXEC_PATH}"    \
        --ex "c"                           \
        --tui                              \

    # Move back.
    cd -
}
