#!/bin/bash
sed -i ":a;N;$!ba;s/\n - CQOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - POI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - TJOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - ZJOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - SCOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - SDOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - IOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - NOI//g" `grep 'OI' -rl ./_posts`
sed -i ":a;N;$!ba;s/\n - OI//g" `grep 'OI' -rl ./_posts`

sed -i ":a;N;$!ba;s/\n - NOI//g" `grep 'OI' -rl ./`
