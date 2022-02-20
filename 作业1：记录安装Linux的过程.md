### 作业一  记录安装Linux的过程

<p align="right">作者: 张子谦</p>

[TOC]

##### 一、所需要的安装工具

- VM WorkStations
- Linux安装的镜像文件
- 浏览器与相应的下载工具



##### 二、安装步骤（虚拟机安装详细版）

1. 首先进入Linux的官网，然后进入到下载页面，找到官方认证的镜像界面：[CentOS Mirrors List](http://isoredirect.centos.org/centos/7/isos/x86_64/)
 <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219121435111.png" alt="image-20220219121435111" style="zoom: 80%;" />

   - 注释：在上面的界面中，网页会根据地址选择距离比较近的镜像服务器，例如第一个网址就是上海交通大学的ftp服务器地址下CentOS的子目录，单击链接即可下载，当然还有一些企业用的网址，例如阿里云等等。

 - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219121658968.png" alt="image-20220219121658968" style="zoom:80%;" />

2. 上面是具体的一些下载链接，在具体开始下载之前，首先需要阅读ReadMe文档，了解里面的镜像文件的信息。 根据Readme文档，了解到一下关键信息：

   - | 版本                                 | 相应的解释和说明                                             |
     | ------------------------------------ | ------------------------------------------------------------ |
     | CentOS-7-x86_64-DVD-2009.iso         | 这个安装镜像包括所有的能够使用安装引导程序安装的包，这是对于大多数用户最为推荐的安装方式 |
     | CentOS-7-x86_64-NetInstall-2009.iso  | 这是网络安装和救援映像。 安装程序将询问它应该从哪里获取要安装的软件包。 如果您有CentOS软件包的本地镜像，则此映像最有用。 |
     | CentOS-7-x86_64-Everything-2009.iso. | 此映像包含 CentOS Linux 7 的完整软件包集。它可用于安装或填充本地镜像。 此映像需要一个16GB 的USB闪存驱动器，因为它对于DVD iso来说太大了。 |

   - **使用安装映像：**您可以将这些图像刻录到 DVD 或将它们“dd”到 USB 闪存驱动器。 准备好启动媒体后，从启动媒体启动计算机。 如果您使用这些安装映像安装到您的硬盘，请记住在安装后运行“yum update”以将您的系统更新到最新的软件包。

3. 最终我选择的阿里云的安装镜像：CentOS-7-x86_64-Everything-2009.iso.

4. 下载完成后，打开VM WorkStations，开始安装

   - 选择典型安装模式（这种模式是VM针对各种操作系统优化过的，所以只需要填入一些必备信息，安装程序可以更快捷的运行，当然也可以选择自定义，我之前尝试过一些自定义系统的安装如Cutefish，大致关键在于选择好操作系统的版本，一旦版本选择错误了后续的错误接踵而来，例如Cutefish在自定义安装的是选择Debian，因为Cutefish的内核是基于Debian，所以如果选择CentOS就一定会出错安装失败）
   - 此外，在之前的安装中（例如XP、其他windows或者Mac系统中，有时候需要更新一下这个VM WorkStations到最新版，有时候安装错误就是因为版本存在一些bug，更新后即可修复）
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219122927043.png" alt="image-20220219122927043" style="zoom: 80%;" />

   - 选择目录到我们刚刚下载好的镜像文件，显然虚拟机会自动检测安装镜像，会使用简易安装。
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219123535578.png" alt="image-20220219123535578" style="zoom: 80%;" />

   - 输入用户名密码（这个将是系统的账户和root密码），全名可以随意取。
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219123709493.png" alt="image-20220219123709493" style="zoom:80%;" />

   - 选择好安装目录，找一个固定的文件夹，由于我的课程文件均在云盘，所以我将虚拟机部署在Onedrive云盘，然后同时保留在本地，这样也可以以后方便远程使用、转移、共享或者拷贝虚拟机。
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219123841003.png" alt="image-20220219123841003" style="zoom:80%;" />
   - 设置磁盘大小60G，磁盘拆分为多个文件（可以更方便的移动虚拟机）
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219124549352.png" alt="image-20220219124549352" style="zoom:80%;" />

   - 检查相关属性，我修改了一下内存为4GB，因为电脑内存足够大（64GB）hhh。其他属性没有修改。
   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219124656217.png" alt="image-20220219124656217" style="zoom:80%;" />

   - 单击完成，开始安装。

5. 创建虚拟机后，会自动开启这个虚拟机。（如下图）

   - <img src="C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业一_记录安装Linux的过程.assets\image-20220219124859958.png" alt="image-20220219124859958" style="zoom:80%;" />

6. 安装完成即可登录。



