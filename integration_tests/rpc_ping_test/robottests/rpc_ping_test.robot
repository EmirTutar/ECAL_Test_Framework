*** Comments ***
This test checks the communication between a client and a server using eCAL RPC.

It runs the test in two modes:
- network_udp
- network_tcp

Success criteria:
- Client connects to the server
- Server responds to the client's Ping request
- Client prints the response and exits with code 0

*** Settings ***
Library           OperatingSystem
Library           Process
Library           ${CURDIR}/../../lib/MyDockerLibrary.py
Library           ${CURDIR}/../../lib/GlobalPathsLibrary.py
Suite Setup       Init Test Context

*** Variables ***
${NETWORK}        ${EMPTY}
${BUILD_SCRIPT}   ${EMPTY}
${BASE_IMAGE}     rpc_ping_test

*** Test Cases ***
RPC Test Network UDP
    Run RPC Test In Mode    network_udp

RPC Test Network TCP
    Run RPC Test In Mode    network_tcp

*** Keywords ***
Init Test Context
    Set Test Context    rpc_ping_test    rpc_ping_test
    ${build}=    Get Build Script Path
    ${net}=      Get Network Name
    ${args}=     Get Build Script Args
    Set Suite Variable    ${BUILD_SCRIPT}    ${build}
    Set Suite Variable    ${NETWORK}         ${net}

    ${desc}=    Get Test Description
    Log    ${desc}

    Log To Console    [SETUP] Building Docker image...
    ${result}=    Run Process    ${BUILD_SCRIPT}    @{args}
    Should Be Equal As Integers    ${result.rc}    0    Failed to build Docker image!

    Create Docker Network    ${NETWORK}
    Sleep    2s

Run RPC Test In Mode
    [Arguments]    ${MODE}
    ${IMAGE}=    Set Variable    ${BASE_IMAGE}_${MODE == "network_tcp" and "tcp" or "udp"}
    ${SERVER}=   Set Variable    rpc_server_${MODE}
    ${CLIENT}=   Set Variable    rpc_client_${MODE}

    Log To Console    \n[INFO] Starting RPC Server...
    Start Container   ${SERVER}    ${IMAGE}    server    ${MODE}    network=${NETWORK}
    Sleep    1s
    Log To Console    \n[INFO] Starting RPC Client...
    Start Container   ${CLIENT}    ${IMAGE}    client    ${MODE}    network=${NETWORK}
    ${exit}=    Wait For Container Exit    ${CLIENT}
    Should Be Equal As Integers    ${exit}    0    Client failed!

    ${logs}=    Get Container Logs    ${SERVER}
    Log To Console    \n[CONTAINER LOG: SERVER]\n${logs}
    Log               \n[CONTAINER LOG: SERVER]\n${logs}

    ${logs}=    Get Container Logs    ${CLIENT}
    Log To Console    \n[CONTAINER LOG: CLIENT]\n${logs}
    Log               \n[CONTAINER LOG: CLIENT]\n${logs}

    Log Test Summary    RPC Client/Server Test ${MODE}    ${True}
    Stop Container    ${SERVER}
    Stop Container    ${CLIENT}
    Sleep    1s
