*** Settings ***
Library           BuiltIn
Library           ApiTesterLib.src.library.ApiTestLib    ZQBIND

*** Keywords ***
Base_Bind_Connect_nameserver
    [Arguments]    ${ApiID}=${ApiID}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    create_session    ${ApiID}    mode=0    group_id=${0}
    register_front    tcp://${server_ip}:${6500}    ${ApiID}
    connect    ${ApiID}    department=${DepartmentID}    user_id=${UserID}    AccountType=0
    check call back    OnFrontConnected    ${ApiID}    ${max_seq}    time_out=${30}
