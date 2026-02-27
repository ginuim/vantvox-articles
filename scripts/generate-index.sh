#!/bin/bash
# 自动扫描bio目录下的markdown文件，生成文章索引

cd "$(dirname "$0")/../docs"

echo "const articles = [" > articles.js

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
            echo "," >> articles.js
        fi
        
        echo -n "  { file: '$md', title: '$title', period: '$period' }" >> articles.js
    fi
done

echo "" >> articles.js
echo "];" >> articles.js

echo "Generated:"
cat articles.js
