## GMT快速安装脚本

[![Travis](https://travis-ci.org/gmt-china/gmt-easy-installer.svg)](https://travis-ci.org/gmt-china/gmt-easy-installer)
[![GMT Version](https://img.shields.io/badge/GMT-5.3.3-green.svg)](http://gmt.soest.hawaii.edu/)
[![license](https://img.shields.io/github/license/gmt-china/gmt-easy-installer.svg)](https://github.com/gmt-china/gmt-easy-installer/blob/master/LICENSE)

本项目旨在为GMT用户提供GMT最新版本的快速安装脚本。

### 注意事项

1. 所有脚本仅在全新安装的64位系统下测试通过
2. 当前用户应具有root权限（即可以使用 `sudo` 来安装软件）
3. 除用户自己外，无人可以为使用该脚本而导致的任何问题负责
6. 欢迎用户在多个不同的系统上进行测试

### 平台测试

#### GMT 5.3.3

| 发行版       | 是否通过 | 说明                                     |
|--------------|----------|------------------------------------------|
| CentOS 6.7   | ✓        | `FFTW` 以及 `GLIB_THREAD` 并行功能被禁用 |
| CentOS 7.2   | ✓        |                                          |
| Ubuntu 14.04 | ✓        |                                          |
| Ubuntu 15.10 | ✓        |                                          |
| Ubuntu 16.04 | ✓        | 源码有BUG，因而对源码打了补丁            |
| Fedora 22    | ✓        |                                          |
| Fedora 23    | ✓        |                                          |
| Debian 7.10  | ✓        |                                          |
| Debian 8.4   | ✓        |                                          |

### 使用方法

1. 下载GMT安装脚本 `GMT-installer.sh` 、 `md5sums.md5`和自己的Linux发行版对应的
   安装脚本，并保存到同一目录下

2. 执行自己的Linux发行版所对应的安装脚本以安装依赖

   ~~~
   bash ./XXXX-installer.sh
   ~~~

3. 执行GMT安装脚本

   ~~~
   bash ./GMT-installer.sh
   ~~~

4. 等待安装完成，实际使用时可能需要重新 `source ~/.bashrc` 或者退出重新登陆或者重启，使得环境变量生效

5. 测试是否安装正常

   ~~~
   gmt --version
   gmt pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P -V > GMT_test.ps
   ~~~

### FAQ

#### 如何下载？

有三种下载方式：

1. 直接点击项目主页上的“Download ZIP”按钮
2. 使用 `git clone https://github.com/gmt-china/gmt-easy-installer.git`
3. 点击要下载的脚本，在新页面的“Raw”按钮上右键保存

#### 原理介绍

其实GMT的安装很简单，在各个平台上的安装方法是完全一样的，区别在于不同的发行版要安装的包的名称不同。因而GMT安装脚本 `GMT-installer.sh` 是通用的，而 `XXXX-installer.sh` 则是不同的平台有不同的安装脚本。

首先执行自己平台对应的脚本以安装GMT所需的依赖，然后再执行 `GMT-installer.sh`，该脚本中首先下载GMT安装包，然后解压，修改配置，检查依赖是否满足，最后安装。

#### 加速下载

脚本会使用 `curl` 命令从GMT官网下载三个GMT安装包。如果觉得下载太慢，可以使用其他方法预先下载好脚本中指定的安装包，将其放在与脚本同一目录下。此时 `curl` 在下载数据时会发现安装包已经下载完成，就会自动跳过数据下载这一步骤。

### 更新说明

**本说明仅供项目维护者参考**

当 GMT 新版本发布时，应修改如下三个地方：

1. `GMT-installer.sh` 中的版本信息
2. `README.md` 中的版本信息
3. `md5sums.md5` 中的 md5 值
