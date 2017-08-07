*** Settings ***
Library           BuiltIn
Library           ApiTesterLib.src.library.ServiceLib
Library           Process
Library           ApiTesterLib.src.library.DatabaseLibrary

*** Variables ***
@{server_connect}    ${server_ip}    ${server_user}    123    # ${server_ip} | ${server_user} | 123456
@{service_list_test}    sseofferdbcleaner    tinit 1 redo    tradeserver 1    front 1    fens \ 1    #dbsync 1
${service_dir}    ~/run    # ~/cfg/${version}
@{service_list_data}    tinit    TradeServer    ticlient
@{offer_connect}    ${offer_ip}    ${server_user}    123456
@{offer_list}     szsetestappEx 1    szsebinaryoffer 1    szsebinaryoffer 2    szsetestappEx 2    ssespotoffer 1    ssespotoffer 2    # jzlink 1 Y Y Y \ #fileoffer 1 #szsebinarymdserver 1 #ssespotmdserver 1 #szsebinaryoffer 2

*** Test Cases ***
stop
    trade_stop
    xiaozhan_stop    e:\\\\release\\

deploy
    MakeBasePathForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}
    CopyObjectForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}    ObjectPath=/media/sf_virtual_share/trade/${version}
    CopyIniForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}    IniPath=/media/sf_virtual_share/trade/${version}

copyData
    CopyDataForServiceList    @{server_connect}    ServiceList=@{service_list_data}    ServiceDir=~/cfg/${version}    DataPath=/media/sf_virtual_share/data/${version}

db_clean
    #db_clean    10.102.0.21    Ashare_OIW    sa    xz@021~dongcai    ashare_
    #db_clean    10.102.0.167    Ashare_OIW    sa    xz@167~dongcai    ashare_
    #db_clean    10.0.39.61    OIW_13379    sa    sasa@bpcs123
    #db_clean    ${db_ip}    Ashare_OIW    sa    xz@213~dongcai    ashare_
    db_clean    192.168.56.1    sse_offer
    #db_clean    192.168.100.108\\TORA    wl

trade_clean
    trade_clean

start
    trade_clean
    trade_start
    sleep    25s
    #sseoffer_clear    ${server_ip}    8888
    #sleep    5s
    #sseoffer_clear    ${server_ip}    8889

xiaozhan_start
    xiaozhan_start    E:\\\\release\\

stop_ssexiaozhan
    xiaozhan_stop    e:\\\\release\\

deploy_trade
    ${obj_dir}    set variable    ~/target/${version}
    MakeBasePathForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}
    CopyObjectForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}    ObjectPath=${obj_dir}
    CopyIniForServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=~/cfg/${version}    IniPath=${obj_dir}

copy_data_trade
    ${data_dir}    set variable    ~/data/${version}
    CopyDataForServiceList    @{server_connect}    ServiceList=@{service_list_data}    ServiceDir=~/cfg/${version}    DataPath=${data_dir}

restart
    trade_start

ticlient
    ticlient_set_status    1
    ticlient_set_status    2
    sleep    15s

*** Keywords ***
db_clean
    [Arguments]    ${server}    ${db}    ${userid}=test1    ${password}=123456    ${pre}=\    ${port}=1433
    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};SERVER=${server};Port=${port};UID=${userid};DATABASE=${db};PWD=${password};"
    Execute Sql string    delete from ${pre}ORDWTH2
    Execute Sql string    delete from ${pre}ORDWTH
    Execute Sql string    delete from ${pre}CJHB

xiaozhan_start
    [Arguments]    ${dir}
    [Documentation]    local
    #@{server_connect}    create list    127.0.0.1    test    123456
    @{service_list_test}    create list    ssexiaozhan
    StartServiceList    \    ServiceList=@{service_list_test}    ServiceDir=E:\\\\release\\    ServiceArgs=\

xiaozhan_stop
    [Arguments]    ${dir}
    @{service_list_test}    create list    ssexiaozhan.exe
    StopServiceList    \    ServiceList=@{service_list_test}    ServiceDir=${dir}    ServiceArgs=\

trade_start
    StartServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=${service_dir}    ServiceArgs=\
    StartServiceList    @{offer_connect}    ServiceList=@{offer_list}    ServiceDir=${service_dir}    ServiceArgs=\

trade_clean
    CleanServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=${service_dir}    ServiceArgs=\
    CleanServiceList    @{offer_connect}    ServiceList=@{offer_list}    ServiceDir=${service_dir}    ServiceArgs=\

trade_stop
    StopServiceList    @{server_connect}    ServiceList=@{service_list_test}    ServiceDir=${service_dir}    ServiceArgs=\
    StopServiceList    @{offer_connect}    ServiceList=@{offer_list}    ServiceDir=${service_dir}    ServiceArgs=\

ticlient_set_status
    [Arguments]    ${Exchange}=1
    StopService    @{server_connect}    ServiceName=ticlient    ServiceDir=${service_dir}
    StartService    @{server_connect}    ServiceName=ticlient    ServiceDir=${service_dir}    ServiceArgs=1 ${TradingDay} ${Exchange} SET_STATUS
    sleep    3
    StopService    @{server_connect}    ServiceName=ticlient    ServiceDir=${service_dir}

sseoffer_clear
    [Arguments]    ${ip}    ${OfferPort}=55555
    StartService    @{server_connect}    ServiceName=managerport    ServiceDir=${service_dir}    ServiceArgs=CMD_CLEARDB ${ip} ${OfferPort}
