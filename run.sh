#!/bin/bash


database_user="root"                          # database username, 数据库用户名
database_password="you_password"              # database password, 数据库密码
backup_dir="/root/home/database/backup"       # backup dir, 备份到文件夹
databases=("prod_mybox" "prod_auto_download") # database names array,数据库库名数组
mysqldump_path="/usr/bin"                     # mysqldump path, mysqldump 可执行文件路径


function log() {
  now_time="$(date "+%Y-%m-%d %H:%M:%S")"
  echo "######### $now_time $*" 
}

now="$(date +%Y%m%d%H%M%S)"
dir="$backup_dir/$now"
mkdir -p "$dir"
log "开始备份, 共计 ${#databases[*]} 个数据库"
for(( i=0; i<${#databases[@]}; i++ ))
do
  item=${databases[i]}
  log "备份 $i $item"
  $mysqldump_path/mysqldump -u$database_user -p$database_password --databases $item > "$dir/$item.sql" 
done;
log "备份完成, 正在打包"
tar czvf "$dir.tar.gz" -C $backup_dir ./$now
rm -rf $dir
log "备份完成 $dir.tar.gz"


