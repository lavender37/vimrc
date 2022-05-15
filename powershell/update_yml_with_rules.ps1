# 设置订阅地址
$url = "your_url"
$url_content = Invoke-WebRequest $url
$obj_array = ConvertFrom-Yaml $url_content.Content -AllDocuments -Ordered
[System.Collections.ArrayList]$proxies_names = $obj_array.proxies.name

# 清空策略组
# $obj_array.'proxy-groups'.Clear()
# 清空规则组
$obj_array.rules.Clear()

# 创建规则组列表
[System.Collections.ArrayList]$proxies_group_list = @()

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔯 代理模式" }
$rule_hashtable += @{"type" = "select" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("绕过大陆丨黑名单(GFWlist)") # 黑名单模式，意为「只有命中规则的网络流量，才使用代理」
$proxies_list.Add("绕过大陆丨白名单(Whitelist)") # 白名单模式，意为「没有命中规则的网络流量，统统使用代理」
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择香港低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("HK")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择美国低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("US")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择新加坡低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("SG")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择韩国低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("KR")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择台湾低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("TW")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 自动选择日本低延迟节点" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "3600" }
[System.Collections.ArrayList]$proxies_list = @()
foreach ($proxies_name_filter in $proxies_names) {
    if ($proxies_name_filter.Contains("JP")) {
        $proxies_list.Add($proxies_name_filter)
    }
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🔰 手动选择节点" }
$rule_hashtable += @{"type" = "select" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("DIRECT")
foreach ($proxies_name_filter in $proxies_names) {
    $proxies_list.Add($proxies_name_filter)
}
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "🛑 广告拦截" }
$rule_hashtable += @{"type" = "select" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("DIRECT")
$proxies_list.Add("REJECT")
$proxies_list.Add("PROXY")
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "绕过大陆丨黑名单(GFWlist)" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "86400" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("DIRECT")
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "绕过大陆丨白名单(Whitelist)" }
$rule_hashtable += @{"type" = "url-test" }
$rule_hashtable += @{"url" = "http://www.gstatic.com/generate_204" }
$rule_hashtable += @{'interval' = "86400" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("PROXY")
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)

# 添加规则组
[System.Collections.Hashtable]$rule_hashtable = @{}
$rule_hashtable += @{"name" = "PROXY" }
$rule_hashtable += @{"type" = "select" }
[System.Collections.ArrayList]$proxies_list = @()
$proxies_list.Add("🔰 手动选择节点")
$proxies_list.Add("🔰 自动选择香港低延迟节点")
$proxies_list.Add("🔰 自动选择美国低延迟节点")
$proxies_list.Add("🔰 自动选择新加坡低延迟节点")
$proxies_list.Add("🔰 自动选择台湾低延迟节点")
$proxies_list.Add("🔰 自动选择韩国低延迟节点")
$proxies_list.Add("🔰 自动选择日本低延迟节点")
$rule_hashtable += @{"proxies" = $proxies_list }
$proxies_group_list.Add($rule_hashtable)


$obj_array.'proxy-groups' = $proxies_group_list


# 创建规则提供商列表
[System.Collections.Hashtable]$rule_providers_list = @{}

# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/reject.yaml" }
$rule_providers_hashtable += @{'interval' = "86400" }
$rule_providers_list += @{"reject" = $rule_providers_hashtable } # 广告域名列表

# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/reject.yaml" }
$rule_providers_hashtable += @{'interval' = "86400" }
$rule_providers_list += @{"icloud" = $rule_providers_hashtable } # iCloud 域名列表

# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/apple.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"apple" = $rule_providers_hashtable } # Apple 在中国大陆可直连的域名列表

# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/google.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"google" = $rule_providers_hashtable } # Google 在中国大陆可直连的域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/proxy.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"proxy" = $rule_providers_hashtable } # 代理域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/direct.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"direct" = $rule_providers_hashtable } # 直连域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/private.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"private" = $rule_providers_hashtable } # 私有网络专用域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/gfw.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"gfw" = $rule_providers_hashtable } # GFWList 域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/greatfire.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/greatfire.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"greatfire" = $rule_providers_hashtable } # GreatFire 域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "domain" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/tld-not-cn.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"tld-not-cn" = $rule_providers_hashtable } # 非中国大陆使用的顶级域名列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "ipcidr" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/telegramcidr.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"telegramcidr" = $rule_providers_hashtable } # Telegram 使用的 IP 地址列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "ipcidr" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/cncidr.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"cncidr" = $rule_providers_hashtable } # 中国大陆 IP 地址列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "ipcidr" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/lancidr.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"lancidr" = $rule_providers_hashtable } # 局域网 IP 及保留 IP 地址列表
# 添加规则提供商
[System.Collections.Hashtable]$rule_providers_hashtable = @{}
$rule_providers_hashtable += @{"type" = "http" }
$rule_providers_hashtable += @{"behavior" = "classical" }
$rule_providers_hashtable += @{"url" = "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt" }
$rule_providers_hashtable += @{"path" = "./ruleset/applications.yaml" }
$rule_providers_hashtable += @{"interval" = "86400" }
$rule_providers_list += @{"applications" = $rule_providers_hashtable } # 需要直连的常见软件列表

$obj_array += @{"rule-providers" = $rule_providers_list }


# 添加规则

[System.Collections.ArrayList]$proxy_rules = @()
$proxy_rules.Add("DOMAIN,cp.u9un.com,PROXY")
$proxy_rules.Add("PROCESS-NAME,v2ray,DIRECT")
$proxy_rules.Add("PROCESS-NAME,xray,DIRECT")
$proxy_rules.Add("PROCESS-NAME,naive,DIRECT")
$proxy_rules.Add("PROCESS-NAME,trojan,DIRECT")
$proxy_rules.Add("PROCESS-NAME,trojan-go,DIRECT")
$proxy_rules.Add("PROCESS-NAME,ss-local,DIRECT")
$proxy_rules.Add("PROCESS-NAME,privoxy,DIRECT")
$proxy_rules.Add("PROCESS-NAME,leaf,DIRECT")
$proxy_rules.Add("PROCESS-NAME,v2ray.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,xray.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,naive.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,trojan.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,trojan-go.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,ss-local.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,privoxy.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,leaf.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge 2,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge 3,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge 4,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge%202,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge%203,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Surge%204,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Thunder,DIRECT")
$proxy_rules.Add("PROCESS-NAME,DownloadService,DIRECT")
$proxy_rules.Add("PROCESS-NAME,qBittorrent,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Transmission,DIRECT")
$proxy_rules.Add("PROCESS-NAME,fdm,DIRECT")
$proxy_rules.Add("PROCESS-NAME,aria2c,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Folx,DIRECT")
$proxy_rules.Add("PROCESS-NAME,NetTransport,DIRECT")
$proxy_rules.Add("PROCESS-NAME,uTorrent,DIRECT")
$proxy_rules.Add("PROCESS-NAME,WebTorrent,DIRECT")
$proxy_rules.Add("PROCESS-NAME,aria2c.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,BitComet.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,fdm.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,NetTransport.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,qbittorrent.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,Thunder.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,ThunderVIP.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,transmission-daemon.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,transmission-qt.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,uTorrent.exe,DIRECT")
$proxy_rules.Add("PROCESS-NAME,WebTorrent.exe,DIRECT")
$proxy_rules.Add("RULE-SET,applications,DIRECT")
$proxy_rules.Add("DOMAIN,clash.razord.top,DIRECT")
$proxy_rules.Add("DOMAIN,yacd.haishan.me,DIRECT")
$proxy_rules.Add("RULE-SET,private,DIRECT")
$proxy_rules.Add("RULE-SET,reject,🛑 广告拦截")
$proxy_rules.Add("RULE-SET,icloud,DIRECT")
$proxy_rules.Add("RULE-SET,apple,DIRECT") # 这三个为国内可直连地址，如果希望走代理改为PROXY
$proxy_rules.Add("RULE-SET,google,DIRECT")
$proxy_rules.Add("RULE-SET,tld-not-cn,PROXY")
$proxy_rules.Add("RULE-SET,gfw,PROXY")
$proxy_rules.Add("RULE-SET,greatfire,PROXY")
$proxy_rules.Add("RULE-SET,telegramcidr,PROXY")
$proxy_rules.Add("RULE-SET,lancidr,DIRECT")
$proxy_rules.Add("RULE-SET,cncidr,DIRECT")
$proxy_rules.Add("GEOIP,,DIRECT")
$proxy_rules.Add("GEOIP,CN,DIRECT")
$proxy_rules.Add("RULE-SET,direct,DIRECT")
$proxy_rules.Add("RULE-SET,proxy,🔯 代理模式")
$proxy_rules.Add("MATCH,🔯 代理模式")  # 规则之外的"

$obj_array.rules = $proxy_rules

# 保存配置为文件
$to_yaml = ConvertTo-Yaml $obj_array | Out-File -FilePath ./result_privider_powershell.yml -Encoding utf8
