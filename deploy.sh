hexo g
cp -R public/* .deploy/xqx930807.github.io
cd .deploy/xqx930807.github.io
git add .
git commit -m "update"
git push origin master
