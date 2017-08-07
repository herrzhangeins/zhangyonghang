*** Settings ***
Documentation     业务关键字

*** Variables ***
${ExchangeID}     2    # szse
${MarketID}       2    # 深圳A股
${CurrencyID}     CNY
${SecurityID}     000725
${Price}          ${2.97}
${Volume}         ${100}
@{AShare1}        ${SecurityID}    ${Price}    ${0}    # 主板000001-001999
@{AShare2}        002756    ${28.27}    ${0}    # 中小板002001-004999
@{AShare3}        300107    ${7.95}    ${0}    # 创业板300001-300999
@{ETF1}           159915    ${2.303}    ${0}    # 单市场股票etf
@{ETF2}           159926    ${111.779}    ${0}    # 单市场国债etf
@{Bond1}          100213    ${144.13}    ${0.26356164}    # 国债
@{Bond2}          111023    ${83.211}    ${3.09512329}    # 企业债
@{Bond3}          112238    ${54.472}    ${0.62684932}    # 公司债
@{Fund1}          184722    ${1.18}    ${0}    # 封闭式基金
@{Fund2}          160127    ${1}    ${0}    # 开放式基金
@{ownbest}        a    3    1    # OrderPriceType，TimeCondition，VolumeConditiion
@{oppbest}        3    3    1
@{FAK}            1    1    1
@{FOK}            1    1    3
@{FiveLvl}        G    1    1
