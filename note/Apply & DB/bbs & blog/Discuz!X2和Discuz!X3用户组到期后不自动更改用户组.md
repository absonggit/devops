1. 修改文件：source/include/spacecp/spacecp_usergroup.php
- 找到代码：`$groupexpirynew = $groupterms['ext'][$groupid];`
- 替换为：`$groupexpirynew = $groupterms['ext'][$extgroupidsnew];`
- 找到代码：
```PHP
$expirylist[$group['groupid']]['grouptitle'] = in_array($group['groupid'], $expgrouparray) ? '' : $group['grouptitle'];
                }
        }
```

>因为不同版本代码有变，所以如果搜不到全部，就只搜一下：$expirylist[$group['groupid']]['grouptitle']

在这段代码下面（注意：一定是在两个大括号之后）添加：
```PHP
if($expgrouparray) {
$extgroupidarray = array();
foreach(explode("\t", $_G['forum_extgroupids']) as $extgroupid) {
if(($extgroupid = intval($extgroupid)) && !in_array($extgroupid, $expgrouparray)) {
$extgroupidarray[] = $extgroupid;
}
}
$groupidnew = $_G['groupid'];
$adminidnew = $_G['adminid'];
foreach($expgrouparray as $expgroupid) {
if($expgroupid == $_G['groupid']) {
if(!empty($groupterms['main']['groupid'])) {
$groupidnew = $groupterms['main']['groupid'];
$adminidnew = $groupterms['main']['adminid'];
} else {
$groupidnew = DB::result_first("SELECT groupid FROM ".DB::table('common_usergroup')." WHERE type='member' AND '".$_G['member']['credits']."'>=creditshigher AND '$credits'<creditslower LIMIT 1");
if(in_array($_G['adminid'], array(1, 2, 3))) {
$query = DB::query("SELECT groupid FROM ".DB::table('common_usergroup')." WHERE groupid IN (".dimplode($extgroupidarray).") AND radminid='$_G[adminid]' LIMIT 1");
$adminidnew = (DB::num_rows($query)) ? $_G['adminid'] : 0;
} else {
$adminidnew = 0;
}
}
unset($groupterms['main']);
}
unset($groupterms['ext'][$expgroupid]);
}
require_once libfile('function/forum');
$groupexpirynew = groupexpiry($groupterms);
$extgroupidsnew = implode("\t", $extgroupidarray);
$grouptermsnew = addslashes(serialize($groupterms));
DB::query("UPDATE ".DB::table('common_member')." SET adminid='$adminidnew', groupid='$groupidnew', extgroupids='$extgroupidsnew', groupexpiry='$groupexpirynew' WHERE uid='$_G[uid]'");
DB::query("UPDATE ".DB::table('common_member_field_forum')." SET groupterms='$grouptermsnew' WHERE uid='$_G[uid]'");
}
```
