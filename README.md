# DatabaseBackup

MySQL 数据库备份 shell 脚本

## 功能
- [x] 同一服务多个数据库备份, 备份到不同的 SQL 文件
- [x] 按照日期打包压缩 tar.gz

## 使用说明
1. 克隆仓库  
 `git clone git@github.com:gonglihai/DatabaseBackup.git`
2. 切换到本地目录  
 `cd ./DatabaseBackup`
3. 修改配置  
`vi run.sh`  
4. 添加执行权限  
`chmod +x ./run.sh`
5. 执行  
`./run.sh`

## 配置说明
 ``` shell
# 数据库用户名
database_user="root"
# 数据库密码
database_password="you_password"
# 备份到文件夹
backup_dir="/data/database/backup"
# 数据库库名数组
databases=("xxx_database1" "xxx_database2" "xxx_database3")
# mysqldump 可执行文件路径
mysqldump_path="/usr/bin"
```

## crontab 定时任务
``` shell
# 每日凌晨3点备份
0 3 * * * /data/database/run.sh
```

## 其他
### 1. 查找 mysqldump_path 
`whereis mysqldump`

### 2. 备份到阿里云盘
[阿里云盘CLI](https://github.com/tickstep/aliyunpan/tree/main) 
在 `./run.sh` 末尾添加
```
log "上传到 阿里云盘"

/root/home/tools/aliyunpan/aliyunpan u $dir.tar.gz /server/backup/mysql

log "上传结果: $?, 文件: /server/backup/mysql/$now.tar.gz"
```
