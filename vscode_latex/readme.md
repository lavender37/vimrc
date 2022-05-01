# 使用docker部署latex
```bash
docker pull raabf/latex-versions:texlive2020
```

对于中文使用者来说还需要复制中文字体，因此需要以下步骤，如果不需要中文，可以直接开启容器
下载Dockerfile
```bash
proxychains wget https://raw.githubusercontent.com/lavender37/vimrc/master/vscode_latex/Dockerfile
```

切换到dockerfile目录，将windows字体复制到当前目录Fonts文件夹，开始构建docker for latex_zh镜像
```bash
cp -r /mnt/c/Windows/Fonts/ ./Fonts_TEMP
docker build -t raabf/latex-versions:texlive2020_zh .
```

开一个容器
```bash
# 中文用户
docker run -it -v /mnt/d/latex_docs:/home/workdir --name latex_build_22 raabf/latex-versions:texlive2020_zh /bin/bash
# 英文用户
docker run -it -v /mnt/d/latex_docs:/home/workdir --name latex_build_22 raabf/latex-versions:texlive2020 /bin/bash
```

清楚Fonts_TEMP目录
```bash
rm -rf ./Fonts_TEMP
```

# 使用vscode连接到容器
安装Remote-Containers插件

选择Attach to running container即可

注意需要挂载自己需要的目录，如果没有挂载目录，需要重新开一个容器

# 编译latex
安装latex-workshop插件，并配置相关设置，点击编译