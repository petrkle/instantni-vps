<?php
$cfg['blowfish_secret'] = 'Fqx8lhwlccopkcqucrzaykfchuxH4c';
$cfg['PmaNoRelation_DisableWarning'] = true;
$cfg['VersionCheck'] = false;
$cfg['NavigationTreeEnableGrouping'] = false;
$cfg['NavigationDisplayLogo'] = false;

$i = 1;

$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
$cfg['VersionCheck'] = false;
$cfg['LoginCookieValidity'] = 7*24*3600;
$cfg['LoginCookieStore'] = 7*24*3600;
$cfg['MaxRows'] = 100;
$cfg['NavigationTreeEnableExpansion'] = false;
$cfg['SendErrorReports'] = 'never';
