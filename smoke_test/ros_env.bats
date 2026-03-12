#!/usr/bin/env bats

setup() {
    load "${BATS_TEST_DIRNAME}/test_helper"
}

# -------------------- ROS environment --------------------

@test "ROS_DISTRO is noetic" {
    assert_equal "${ROS_DISTRO}" "noetic"
}

@test "ROS setup.bash exists" {
    assert [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]
}

@test "ROS environment can be sourced" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && echo ok"
    assert_success
    assert_output "ok"
}

@test "rostopic command is available after sourcing ROS" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && which rostopic"
    assert_success
}

@test "rosrun command is available after sourcing ROS" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && which rosrun"
    assert_success
}

# -------------------- Dev tools --------------------

@test "catkin command is available" {
    run which catkin
    assert_success
}

@test "python3 is available" {
    run which python3
    assert_success
}

@test "git is available" {
    run which git
    assert_success
}

# -------------------- System --------------------

@test "user is not root" {
    run id -u
    assert_success
    refute_output "0"
}

@test "timezone is Asia/Taipei" {
    run cat /etc/timezone
    assert_success
    assert_output "Asia/Taipei"
}

@test "LANG is en_US.UTF-8" {
    assert_equal "${LANG}" "en_US.UTF-8"
}

@test "work directory exists" {
    assert [ -d "${HOME}/work" ]
}

@test "work directory is writable" {
    run bash -c "touch '${HOME}/work/.smoke_test' && rm '${HOME}/work/.smoke_test'"
    assert_success
}
