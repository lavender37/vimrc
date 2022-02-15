@echo off
%自动更新host for onenote%
del /Q C:\Windows\System32\drivers\etc\hosts
if %ERRORLEVEL% EQU 0 (
certutil -urlcache -split -f  https://onedrive-hosts.learningman.top/dns.cache C:\Windows\System32\drivers\etc\hosts
) else (
copy C:\Windows\System32\drivers\etc\hosts.old C:\Windows\System32\drivers\etc\hosts
)
@echo on
dir C:\Windows\System32\drivers\etc\
pause