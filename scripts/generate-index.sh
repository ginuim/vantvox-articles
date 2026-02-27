#!/bin/bash
# 自动扫描bio目录下的markdown文件，生成文章索引

cd "$(dirname "$0")/../docs"

# 生成索引内容
{
echo "const articles = ["
first=true
for md in bio/*.md; do
    if [ -f "$md" ]; then
        # 提取标题（第一行 # 后的内容）
        title=$(head -1 "$md" | sed 's/^# //')
        # 提取日期/时期
        period=$(grep -m1 "^> " "$md" | sed 's/^> //')
        
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        
        echo -n "  { file: 'docs/$md', title: '$title', period: '$period' }"
    fi
done
echo ""
echo "];"
} > articles.js

# 复制到根目录
cp articles.js ../articles.js

echo "Generated:"
cat articles.js
