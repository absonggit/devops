第一步，安装GraphicsMagick
```
yum install -y epel-release
yum install -y GraphicsMagick
```

第二步，LUA版本目前不支持5.2，用系统自带的5.1就可以了。不过还是要安装下LUA的开发库
```
yum install -y lua-devel
```

第三步，安装 luajit，http://luajit.org/download.html到这里下载最新版，解压
```
make
make install
```

第四步，NGINX可以用淘宝出的tengine或者openresty，已加载lua插件，编译参数如下
```
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_concat_module --with-http_lua_module --with-luajit-inc=/usr/local/include/luajit-2.0 --with-luajit-lib=/usr/local/lib
```

nginx.conf配置如下：
```
location ~ '/(.*)/(.*).(jpg|JPG|jpeg|png|gif|GIF)_([0-9]+)x([0-9]+).(jpg|jpeg|png|gif)$' {
    root /home/images;     
    set $image_root /home/images;     
    set $thumbnail_root /home/images/thumbnail_root;
    # set $uri $request_filename;     
    if (!-e $request_filename){
        rewrite_by_lua_file conf/image.lua;         
        }     
    }
```

image.lua文件内容如下：
```
-- Nginx thumbnail module by lua
-- last update: 2014/1/11
-- ver: 0.3

-- 是否记录日志
local is_log = true;
-- 允许默认图片
local enable_default_img = false;
-- graphicsmagick安装路径
local gm_path="/usr/local/GraphicsMagick/bin/gm";
-- 链接地址，如/goods/0007/541/001_328x328.jpg
local uri = ngx.var.uri;
-- 图片目录
local ngx_img_root = ngx.var.image_root
-- 缩略图目录
local ngx_thumbnail_root = ngx.var.thumbnail_root
-- img_width:缩略图宽度 img_width:缩略图高度  img_size:缩略图宽x高 img_crop_type:缩略图裁剪类型
local img_width,img_height,img_size,img_crop_type = 0;

-- 配置项，对目录、缩略图尺寸、裁剪类型进行配置，匹配后才进行缩略图处理
local cfg = {
    {dir="",sizes={"76x38!","100x100!","138x77!","232x135!","640x240^","180x105!","300x242!","320x88!","180x120!"}}
--    {dir="manage",sizes={"138x77!","232x135!","500x500$","800x800!"}}
}

-- 日志函数
-- log_level: ngx.STDERR , ngx.EMERG , ngx.ALERT , ngx.CRIT , ngx.ERR , ngx.WARN , ngx.NOTICE , ngx.INFO , ngx.DEBUG
-- 默认为ngx.NOTICE
function lua_log(msg,log_level)
    if (log_level == nil) then log_level =  ngx.NOTICE end;    if(is_log) then ngx.log(log_level,msg) end;
end

-- 判断链接是否符合规则
function table.contains(table,element)
    -- 遍历table
    for _, value in pairs(cfg) do
        local dir = value["dir"];
        local sizes = value["sizes"];
        -- 根据正则匹配缩略图宽、高
        _,_,img_width,img_height = string.find(uri,""..dir.."_([0-9]+)x([0-9]+)");
         if(img_width ~= nil and img_height ~= nil) then
            -- 缩略图尺寸
            img_size = img_width.."x"..img_height;
            for _, value in pairs(sizes) do
                -- 1.保持原图比例，实际尺寸可能小于请求尺寸                if (img_size == value) then
                    img_crop_type=1;
                return true;
                -- 2.拉伸，图片有可能变形
                elseif (img_size.."!" == value) then
                    img_crop_type=2;
                    return true;
                -- 3.保证大小与比例，但图有可能裁剪不完整
                elseif (img_size.."^" == value) then
                    img_crop_type=3;
                    return true;
                -- 4.只限制宽度
                elseif (img_size.."$" == value) then
                    img_crop_type=4;
                    img_size = img_width.."x";
                    return true;
                end
            end
        end
    end
    return false
end

-- 原图链接
local img_original_uri = string.gsub(uri, "_[0-9]+x[0-9]+.[jpg|png|gif]+","");
-- 判断原图是否存在
local img_exist=io.open(ngx_img_root .. img_original_uri);
if not img_exist then
    if not enable_default_img then
        lua_log(img_original_uri.." isn't exist!",ngx.ERR);
        ngx.exit(404);
    else
        local default_img_original_uri = "/empty/empty.jpg";
        img_exist=io.open(ngx_img_root ..  default_img_original_uri);
        if img_exist then
            lua_log(img_original_uri .. "isn't exist! crop image with default image");
            img_original_uri = default_img_original_uri;
        else
            lua_log(img_original_uri.." isn't exist!",ngx.ERR);
            ngx.exit(404);
        end
    end;
end;

if not table.contains(cfg, uri) then
    lua_log(uri.." don't match!",ngx.ERR);
    ngx.exit(404);
else
    -- 开始生成缩略图
    local gm_command;
    -- 缩略图文件路径
    local img_thumbnail_path = ngx_thumbnail_root .. uri;
    -- 原图文件路径
    local img_original_path = ngx_img_root .. img_original_uri;
    -- 执行gm命令
    if (img_crop_type == 1) then
        gm_command = gm_path .. " convert " .. img_original_path  .. " -thumbnail "  .. img_size .. " -background white -gravity center -strip +profile '*' -quality 90 -extent " .. img_size .. " " .. img_thumbnail_path
    elseif (img_crop_type == 2) then
        gm_command = gm_path .. " convert " .. img_original_path  .. " -thumbnail "  .. img_size .. "! -strip +profile '*' -quality 90 -extent ".. img_size .." " .. img_thumbnail_path;
    elseif (img_crop_type == 3) then
        gm_command = gm_path .. " convert " .. img_original_path  .. " -thumbnail "  .. img_size .. "^ -strip +profile '*' -quality 90 -extent ".. img_size .." " ..img_thumbnail_path;
    elseif (img_crop_type == 4) then
        gm_command = gm_path .. " convert " .. img_original_path  .. " -resize '"  .. img_size .. ">' -strip +profile '*' -quality 90 " ..img_thumbnail_path;
    else
        lua_log("img_crop_type error:"..img_crop_type,ngx.ERR);
        ngx.exit(404);
    end

-- 判断图是否存在
    local new_img_exist=io.open(img_thumbnail_path);
    --lua_log(img_thumbnail_path .. uri);
    -- 执行gm命令 and not new_img_exist
    if (gm_command ~= nil and not new_img_exist) then
        -- 获取缩略图路径及文件名
        _,_,img_thumbnail_dir,img__thumbnail_filename=string.find(img_thumbnail_path,'(.-)([^/]*)$')
        -- 先创建缩略图所在目录，避免报错
        os.execute("mkdir -p "..img_thumbnail_dir);
        -- 执行gm命令
        os.execute(gm_command);
        lua_log("gm_command======"..img_crop_type..gm_command);
    en
    -- 转发请求至缩略图
    ngx.req.set_uri("/thumbnail_root"..uri,true);end
```
