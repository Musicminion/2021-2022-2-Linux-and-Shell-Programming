# 实验三：熟悉Linux命令行

- 学号：
- 姓名：

[toc]

## 实验目的

1. 掌握常用的目录、权限管理的命令
2. 掌握用户管理的命令
3. 掌握文件操作的命令
4. 熟练man的使用



## 实验内容

### 一、目录、权限管理与操作

1. 以普通用户的身份登录你的Linux操作系统，打开终端。你现在的命令提示符是什么？

   答：以普通用户登录后，在桌面打开终端，命令提示符是当前用户的`用户名` + `@localhost ~` 。其中`~`代表用户的家目录。

   ```
   [zhangziqian@localhost ~]$ 
   ```

2. 输入`cd`，然后看看你当前所在的绝对路径是什么？

   答：输入`cd`后，无论如何先回到根目录，然后再输入`pwd` 命令，打印当前目录，显示当前目录的绝对路径。如下所示

   ```
   [zhangziqian@localhost ~]$ pwd
   /home/zhangziqian
   ```

3. 输入`mkdir -p bi296/lab3`创建多级目录`bi296/lab3`，这是我们这次实验的目录。

   答：执行命令后，终端没有任何提示，说明创建成功，然后可以发现在`home` 文件夹下发现这个新建的文件夹。

   ```
   [zhangziqian@localhost ~]$ mkdir -p bi296/lab3
   ```

4. 进入目录`bi296`，可以用`绝对路径`，也可以用`相对路径`的方式。

   答：绝对路径是指从根目录算起的路径，相对路径从当前目录算起的路径叫做相对路径。

   - 从绝对路径的进入方法

   - ```
     cd home
     cd bi296
     cd lab3
     ```

   - 从绝对路径的进入方法

   - ```
     [zhangziqian@localhost home]$ cd /home/zhangziqian/bi296/lab3
     [zhangziqian@localhost lab3]$ 
     ```

   归纳：绝对路径和相对路径是路径的两种表现形式，应遵循最短路径原则(使用最短的路径操作某个文件或者目录)。

   - 如果切换的目录离当前目录近可以使用相对路径
   - 如果切换的目录离根目录近可以使用绝对路径

5. 用`ls -ld`查看一下`lab3`这个目录的默认权限。

   答：执行命令，显示情况如下：

   ```
   [zhangziqian@localhost lab3]$ ls -ld
   drwxrwxr-x. 2 zhangziqian zhangziqian 6 Mar  8 18:19 .
   ```

   - `d` 表示文件类型是目录
   - `rwx` 表示文件所有者、文件所有者所在组的权限，`r-x`表示其他人的权限
   - 第一个`zhangziqian` 表示用户
   - 第二个`zhangziqian` 表示用户组
   - `6` 代表文件大小
   - `Mar  8 18:19` 表示文件的创建时间

6. 在命令行中输入：

```bash
cat >lab3/hello.sh <<EOF
#!/bin/bash
echo "What's your name?"
read name
echo "Welcome to Linux, \${name}"
EOF
```
​		答：先`cd`到bi296的文件夹，然后执行命令。

7. 这是通过重定向的方式将EOF之间的内容输出到文件`lab3/hello.sh`中。用`cat`查看该文件的内容，看看写入是否成功。

   答：执行命令后，输出结果如下，说明文件的写入都是正常的。

   ```
   [zhangziqian@localhost bi296]$ cat lab3/hello.sh
   #!/bin/bash
   echo "What's your name?"
   read name
   echo "Welcome to Linux, ${name}"
   ```

8. 然后我们试图运行`lab3/hello.sh`，会有什么样的输出/错误产生？

   答：错误不允许执行。

   ```
   [zhangziqian@localhost bi296]$ lab3/hello.sh
   bash: lab3/hello.sh: Permission denied
   ```

9. 怎么样去修改权限才能让上面的脚本得以运行，有哪些不同方式？

   解答：首先检查上面的脚本的默认权限

   ```
   [root@localhost lab3]# ls -l
   total 4
   -rw-rw-r--. 1 zhangziqian zhangziqian 80 Mar  8 19:19 hello.sh
   ```

   发现默认的权限是664，所以没有执行的权限，需要使用`chmod`进行修改。

   ```
   [root@localhost lab3]# chmod 764 hello.sh
   ```

   ```
   [root@localhost lab3]# ./hello.sh
   What's your name?
   zhangziqian
   Welcome to Linux, zhangziqian
   [root@localhost lab3]# 
   ```

10. 权限修改完成后，重新运行该脚本，得到什么样的输出？

    解答：请看第9步的输出结果，会有一次交互的过程。

11. 如果将该输出/错误重定向到一个文件`lab3/hello.log`，该怎么运行这个脚本？

    解答：如下面的所示，将输出重定向，但是这样会导致一些提示性的问题前台没有显示。

    ```
    [root@localhost lab3]# ./hello.sh > hello.log
    zhang
    [root@localhost lab3]# cat hello.log
    What's your name?
    Welcome to Linux, zhang
    ```

12. 尝试修改lab3目录的权限，比如去除读（`r`）的权限，你还能进入这个目录么，你还能运行上面这个脚本么？如果去除的是执行（`x`）的权限呢？读取文件的权限呢？

    解答：

    - chmod后依然可以进入目录，`cd lab3` ，但是不能执行`ls`命令。但是可以执行脚本。

      ```
      d-wx-wx--x. 2 zhangziqian zhangziqian 39 Mar  8 19:43 lab3
      ```

    - 去除的是执行（`x`）的权限的时候无法`cd`到目录中，更无法运行脚本。
    - 去除的是写入（`w`）的权限的时候，可以进入目录，也可以执行脚本。

13. 除了`chmod`之外，也可以通过ACL体系修改文件/目录的权限，具体的你可以查看`man 5 acl`以及对应的命令`setfacl`和`getfacl`。

    解答：

    - `getfacl` 命令用于查看文件或目录当前设定的 ACL 权限信息。基本格式是：

    - ```
      [root@localhost ~]# getfacl 文件名
      ```

    - `setfacl` 命令可直接设定用户或群组对指定文件的访问权限。

    - ```
      [root@localhost ~]# setfacl 选项 文件名
      ```

    - 具体功能表：

    - | 选项    | 功能                                                         |
      | ------- | ------------------------------------------------------------ |
      | -m 参数 | 设定 ACL 权限。如果是给予用户 ACL 权限，参数则使用 "u:用户名:权限" 的格式，例如 `setfacl -m u:st:rx /project` 表示设定 st 用户对 project 目录具有 rx 权限；如果是给予组 ACL 权限，参数则使用 "g:组名:权限" 格式，例如 `setfacl -m g:tgroup:rx /project` 表示设定群组 tgroup 对 project 目录具有 rx 权限。 |
      | -x 参数 | 删除指定用户（参数使用 u:用户名）或群组（参数使用 g:群组名）的 ACL 权限，例如 `setfacl -x u:st /project` 表示删除 st 用户对 project 目录的 ACL 权限。 |
      | -b      | 删除所有的 ACL 权限，例如 `setfacl -b /project` 表示删除有关 project 目录的所有 ACL 权限。 |
      | -d      | 设定默认 ACL 权限，命令格式为 "setfacl -m d:u:用户名:权限 文件名"（如果是群组，则使用 d:g:群组名:权限），只对目录生效，指目录中新建立的文件拥有此默认权限，例如 `setfacl -m d:u:st:rx /project` 表示 st 用户对 project 目录中新建立的文件拥有 rx 权限。 |
      | -R      | 递归设定 ACL 权限，指设定的 ACL 权限会对目录下的所有子文件生效，命令格式为 "setfacl -m u:用户名:权限 -R 文件名"（群组使用 g:群组名:权限），例如 `setfacl -m u:st:rx -R /project` 表示 st 用户对已存在于 project 目录中的子文件和子目录拥有 rx 权限。 |
      | -k      | 删除默认 ACL 权限。                                          |

14. 用`ln`为上面的脚本在当前目录下创建一个硬链接（hard link）和一个符号链接（symbolic link），用`ls -i`查看这两个文件的i节点编号，与源文件`lab3/hello.sh`相比，是否相同？这两个文件的文件类型分别是什么（给出文件类型位信息）？

    解答：

    创建硬链接的结果如下：

    ```
    [zhangziqian@localhost lab3]$ ls -i
    68117160 hellohard.sh  68117163 hello.log  68117160 hello.sh
    ```

    创建符号链接后的情况：

    ```
    -rwxrw-r--. 2 zhangziqian zhangziqian 80 Mar  8 19:19 hellohard.sh
    -rw-r--r--. 1 root        root        42 Mar  8 19:59 hello.log
    -rwxrw-r--. 2 zhangziqian zhangziqian 80 Mar  8 19:19 hello.sh
    lrwxrwxrwx. 1 zhangziqian zhangziqian  8 Mar  8 20:39 hellosoft.sh -> hello.sh
    ```

    

15. 是否可以执行这两个文件？如果不行，缺少了哪个步骤呢？

    解答：目前在我的虚拟机中可以执行，（我之前把根目录修改了777权限），如果不行可能是权限问题。

    ```
    [zhangziqian@localhost lab3]$ ./hellosoft.sh
    What's your name?
    zhang
    Welcome to Linux, zhang
    [zhangziqian@localhost lab3]$ ls
    hellohard.sh  hello.log  hello.sh  hellosoft.sh
    [zhangziqian@localhost lab3]$ ./hellohard.sh
    What's your name?
    zhang
    Welcome to Linux, zhang
    ```

    

16. 用`mv`将`lab3/hello.sh`移出`lab3`目录，看看这个文件的i节点是否会发生改变。

    解答：

    ```
    mv hello.sh ../
    ```

    ```
    [zhangziqian@localhost bi296]$ ls -i
    68117160 hello.sh  68117113 lab3
    ```

    事实证明，节点是一样的。也就是说硬链接指向的是磁盘中的某一个节点位置，无论怎么移动，指向的位置都没有改变，只有进入的入口（文件的位置改变了），符号链接就好比windows的快捷方式，快捷方式指向的真实内容不见了，自然就无效。

17. 这时候硬链接和符号链接哪个还能够执行？为什么？

    解答：硬链接依然可以执行，但是软链接已经失效`broken`，因为软链接就相当于一个快捷方式。硬链接指向的是磁盘中的某一个节点位置，无论怎么移动，指向的位置都没有改变，只有进入的入口（文件的位置改变了），符号链接就好比windows的快捷方式，快捷方式指向的真实内容不见了，自然就无效。

18. 将该脚本文件移动到目录`lab3`中，这时候符号链接文件的有效性是否发生改变？

    解答：再次移动后，符号链接有效了。

19. 修改上述脚本文件名为`test.sh`，这时候符号链接文件是否失效？

    解答：失效了，因为文件名字发生了改变，失效。

20. 这时候问一个问题，修改文件名、移动一个文件、复制一个文件是否会改变一个文件的i节点信息？

    解答：修改，移动，复制节点数值不变。

    ```
    [zhangziqian@localhost lab3]$ ls -i
    68117254 hello (copy).sh  68117163 hello.log  68117161 hellosoft.sh
    68117160 hellohard.sh     68117160 hello.sh
    ```

    

21. 用`cp`命令为目录`lab3`创建一个拷贝`lab3.backup`，需要加入哪个选项？

    解答：递归

    ```
    [zhangziqian@localhost bi296]$ cp -r lab3 lab3.backup
    ```

    

22. 尝试用`rm`或者`rmdir`删除这个目录`lab3.backup`，如何执行？

    解答：不能直接`rm`，需要加入递归选项。请看下面几组样例，测试结果显示第二个才能成功。

    ```
    [zhangziqian@localhost bi296]$ rm lab3.backup1
    rm: cannot remove ‘lab3.backup1’: Is a directory
    ```

    ```
    [zhangziqian@localhost bi296]$ rm -r lab3.backup1
    ```

    ```
    rmdir lab3.backup1
    rmdir: failed to remove ‘lab3.backup1’: Directory not empty
    [zhangziqian@localhost bi296]$ rmdir lab3.backup1
    rmdir: failed to remove ‘lab3.backup1’: Directory not empty
    [zhangziqian@localhost bi296]$ rmdir -p lab3.backup1
    rmdir: failed to remove ‘lab3.backup1’: Directory not empty
    ```

    

23. 能否为目录`lab3`创建硬链接`lab3.default`？符号链接呢？

    解答：硬链接不能对目录创建受限于文件系统的设计。 Linux 文件系统中的目录均隐藏了两个特殊的目录，当前目录.和父目录..其实是两个硬链接，若系统运行对目录创建硬链接，则会产生目录环。 目录是种特殊的文件，普通文件不会存放自己的位置信息，只有一个inode [x]的数据结构指向文件，其中，x是文件的inode索引号码。 而我们ls一个目录，会发现目录文件最开始的两条数据是“."和".."，也就是说，目录文件在文件里 已经写死了自己在文件系统中的位置 允许目录的hard link，也就意味着某个目录的hard link集合，只有一份是对的，显然这没有意义。但是符号链接是可以的。

通过上面的练习，尝试总结一下文件、目录的各种权限的作用，以及硬链接和符号链接的区别，尤其是索引节点也就是i结点的意义。

**小结：**

- 权限系统作为一个操作系统的一个管理的重要工具，在日常虽然比较少的使用到（毕竟现在都大多使用自己的PC，基本不会有人给各种文件设置一系列的文件）但是对于一些云主机，公共的服务器（例如需要很多人参与来维护的系统，如大型的商业应用的服务器，就会有不同的成员登录系统，进行操作，于是乎作为管理员需要考虑清楚权限的分配，当然不仅仅局限于文件夹的权限的管理，还有一些操作的权限等等。）

- 硬链接和符号链接：硬链接，两个文件指向磁盘中同一个位置，修改了A相当于修改了B，反之同理。符号链接就类比windows的快捷方式，指向一个固定的目录位置文件。

- 索引节点：linux中，文件查找不是通过文件名称来查找的。实际上是通过i节点来实现文件的查找定位的。我们可以形象的将i节点看做是一个指针。当文件存储到磁盘上去的时候，文件肯定会存放到一个磁盘位置上，可以这样想象，既然文件数据是存放在磁盘上的，如果我们知道这个文件数据的地址，当我们想要读写文件的时候，就可以直接使用这个地址去找到文件。linux下，i节点其实就是可以这么认为，把i节点看作是一个指向磁盘上该文件存储区的地址。只不过这个地址我们一般是没办法直接使用的，而是通过文件名来间接使用的。事实上，i节点不仅包含了文件数据存储区的地址，还包含了很多信息，比如数据大小，等等文件信息。但是i节点是不保存文件名的。文件名是保存在一个目录项中。每一个目录项中都包含了文件名和i节点。


  ​      


### 二、用户管理

1. 用`sudo useradd`命令为你的系统增加另一个用户，确保该用户与你（非root）在同一个组。

   解答：如下

   ```
   [zhangziqian@localhost home]$ sudo useradd -g zhangziqian testuser2
   ```

   

2. 这样你能在新用户的家目录下写文件或者修改该用户的文件么？为什么？你认为这样用户的隔离性是合理的么？

   解答：不能，下面是权限信息`ls -l`

   ```
   drwx------.  3 testuser1   testuser1     92 Mar 11 21:41 testuser1
   drwx------.  3 testuser2   zhangziqian   92 Mar 11 21:45 testuser2
   drwx------. 18 zhangziqian zhangziqian 4096 Mar 11 19:39 zhangziqian
   ```

   

3. 你能修改这个用户的文件的权限么？有哪些用户是可以修改权限的？

   解答：不可以，作为普通用户，但是我使用`sudo chmod 777 testuser1`  用户`root`以及 `sudoer`可以修改权限。

   

4. `useradd`命令在执行的时候需要用到系统的设置如`/etc/default/useradd`文件和`/etc/skel`目录的信息，这样你在创建文件的时候才能给这个用户设置一些默认的参数。查看这两个文件，并尝试说说其中包含哪些信息。

   解答：

   ```
   # useradd defaults file
   GROUP=100
   HOME=/home
   INACTIVE=-1
   EXPIRE=
   SHELL=/bin/bash
   SKEL=/etc/skel
   CREATE_MAIL_SPOOL=yes
   ```

   - GROUP = 100 表示 用户组ID 
   - HOME = /HOME 表示家目录的位置
   - INACTIVE = -1 表示 是否启用帐号过期停权，-1表示不启用。
   - EXPIRE=    表示账号是否启用过期设置   无表示不启用
   - SHELL = /bin/bash 表示账号使用shell种类 
   - SKEL = /etc/skel　表示账号使用默认文件内容，　可以理解为添加用户的目录默认文件存放位置。也就是说，当用户用useradd添加用户时，用户主目录下的文件都是从这个目录中复制的　　　　　        
     CREATE_MAIL_SPOOL=yes  表示是否创建邮箱缓存  yes表示创建

   /etc/skel/目录是用来存放新用户配置文件的目录，当我们添加新用户的时候，这个目录下的所有文件会自动被复制到新添加的用户的家目录下。





### 三、文件查找

1. 在目录`/usr/bin`下用`find`命令查找所有用户都具有读、写和执行权限的文件，并输出这些文件的信息。

   解答：

   ```
   [zhangziqian@localhost bin]$ find -perm 777
   ./lz4c
   ./gtar
   ./bashbug
   ./sh
   ./geqn
   ./gneqn
   ./gnroff
   ./gpic
   ./pstree.x11
   ./gsoelim
   ./gtbl
   ./awk
   ./gtroff
   ./unxz
   ./xzcat
   ./xzcmp
   ./zsoelim
   ./bunzip2
   ./xzegrep
   ./bzcat
   ./xzfgrep
   ./lz4cat
   ./bzcmp
   ./unlz4
   ./bzless
   ./ex
   ./rvi
   ./lz
   ./rview
   ./mcat
   ./view
   ./mcd
   ./mdel
   ./mdir
   ./mdu
   ./mmd
   ./mrd
   ./mren
   ./mzip
   ./dnsdomainname
   ./domainname
   ./nisdomainname
   ./ypdomainname
   ./lastb
   ./iptables-xml
   ./gmake
   ./mattrib
   ./mbadblocks
   ./mclasserase
   ./ld
   ./mcopy
   ./mdeltree
   ./mformat
   ./minfo
   ./mlabel
   ./mmount
   ./mmove
   ./mpartition
   ./mshortname
   ./mshowfat
   ./mtoolstest
   ./mtype
   ./captoinfo
   ./nc
   ./infotocap
   ./mail
   ./reset
   ./Mail
   ./nail
   ./sg
   ./gpg
   ./gpgv
   ./python
   ./python2
   ./mkhybrid
   ./pstack
   ./desktop-file-edit
   ./mkisofs
   ./setup-nsssysinit
   ./i386
   ./cdrecord
   ./rpmquery
   ./rpmverify
   ./dvdrecord
   ./readcd
   ./uncompress
   ./java
   ./orbd
   ./rmid
   ./open
   ./jjs
   ./play
   ./rec
   ./x86_64
   ./systemd-coredumpctl
   ./systemd-loginctl
   ./linux32
   ./linux64
   ./keytool
   ./pack200
   ./rmiregistry
   ./servertool
   ./tnameserv
   ./unpack200
   ./ping6
   ./soxi
   ./psfaddtable
   ./psfgettable
   ./psfstriptable
   ./X
   ./audit2why
   ./slogin
   ./lpr
   ./lp
   ./lpq
   ./lprm
   ./pinentry-gtk
   ./gjs
   ./pango-querymodules-64
   ./alt-java
   ./policytool
   ./cdda2wav
   ./ghostscript
   ./liveinst
   ./pamon
   ./paplay
   ./parec
   ./parecord
   ./arecord
   ./lpstat
   ./cancel
   ./atq
   ./atrm
   ./rvim
   ./charmap
   ./gnome-character-map
   ./gnome-text-editor
   ./gnome-help
   ./vmware-user
   ./gnome-keyring
   ./cc
   ./csh
   ./gnome-weather
   ./javaws
   ./policyeditor
   ./itweb-settings
   ./ControlPanel
   ./setup
   ./pftp
   ./nmtui-connect
   ./nmtui-edit
   ./nmtui-hostname
   ./mailq.postfix
   ./newaliases.postfix
   ./vimdiff
   ./mailq
   ./newaliases
   ./rmail
   ./apropos
   ./scsi-rescan
   ./sudoedit
   ./nfs4_editfacl
   ./rnano
   ./traceroute6
   ./etags
   ./emacs
   ```

   

2. 从目录`/var/log`中搜索修改时间超过一个月的文件，并把这些文件备份到`lab3/log`目录中，然后给这个目录打包成`tar.gz`、`tar.bz2`和`tar.xz`等类型的文件后，删除`lab3/log`这个目录。

   ```
   find . -type f -mtime +3 -exec cp {}  /home/zhangziqian/bi296/lab3/log \;
   ```

   ```
   tar -zcvf log.tar.gz log
   ```

   ```
   rm -rf log
   ```

   

3. 这些可以通过`find`命令的`-exec`或`-ok`选项实现，也可以通过管道发送给`xargs`实现。你可以仔细查看`man find`和`man xargs`。

   解答：

   ```
   find . -type f -mtime +3 | xargs cp {}  /home/zhangziqian/bi296/lab3/log \;
   ```

   

4. 搜索文件的时候，有时候可用文件名进行搜索，这时候常常会用到通配符（wildcard characters）。通配符主要包含这些：
  - `?`：表示单个字符

  - `*`：表示任意个字符
  搜索`/usr/include`目录下的所有头文件并将其输出。

  ```
  find . -name "*.h"
  ```

  ```
  [zhangziqian@localhost include]$ find . -name "*.h"
  ./asm/a.out.h
  ./asm/auxvec.h
  ./asm/vm86.h
  ./asm/bitsperlong.h
  ./asm/boot.h
  ./asm/bootparam.h
  ./asm/unistd_x32.h
  ./asm/bpf_perf_event.h
  ./asm/byteorder.h
  ./asm/debugreg.h
  ./asm/e820.h
  ./asm/errno.h
  ./asm/fcntl.h
  
  # 后面的内容暂时省略
  ```

  
5. 某些文件中可能会包含一些特殊字符（比如空格），在输入的时候必须注意用反斜杠符号（backslash）进行转义，例如`\ `表示空格等，或者加入引号也是可以的，如`"program files"`。

### 四、文件操作

1. 用`cat`、`less`和`more`分别查看文件`/etc/passwd`，可以看到这个文件包含了系统的所有用户信息，比如用户名、用户ID、用户的组ID、用户的别名、用户的家目录、用户默认的shell等信息。每个用户一行，每个信息一列，相互之间用`:`分隔。

   ```
   [root@localhost etc]# cat passwd
   root:x:0:0:root:/root:/bin/bash
   bin:x:1:1:bin:/bin:/sbin/nologin
   daemon:x:2:2:daemon:/sbin:/sbin/nologin
   adm:x:3:4:adm:/var/adm:/sbin/nologin
   lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
   sync:x:5:0:sync:/sbin:/bin/sync
   shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
   halt:x:7:0:halt:/sbin:/sbin/halt
   mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
   operator:x:11:0:operator:/root:/sbin/nologin
   games:x:12:100:games:/usr/games:/sbin/nologin
   ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
   nobody:x:99:99:Nobody:/:/sbin/nologin
   systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
   dbus:x:81:81:System message bus:/:/sbin/nologin
   polkitd:x:999:998:User for polkitd:/:/sbin/nologin
   libstoragemgmt:x:998:995:daemon account for libstoragemgmt:/var/run/lsm:/sbin/nologin
   colord:x:997:994:User for colord:/var/lib/colord:/sbin/nologin
   rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
   saned:x:996:993:SANE scanner daemon user:/usr/share/sane:/sbin/nologin
   gluster:x:995:992:GlusterFS daemons:/run/gluster:/sbin/nologin
   saslauth:x:994:76:Saslauthd user:/run/saslauthd:/sbin/nologin
   abrt:x:173:173::/etc/abrt:/sbin/nologin
   setroubleshoot:x:993:990::/var/lib/setroubleshoot:/sbin/nologin
   rtkit:x:172:172:RealtimeKit:/proc:/sbin/nologin
   pulse:x:171:171:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
   radvd:x:75:75:radvd user:/:/sbin/nologin
   chrony:x:992:987::/var/lib/chrony:/sbin/nologin
   unbound:x:991:986:Unbound DNS resolver:/etc/unbound:/sbin/nologin
   qemu:x:107:107:qemu user:/:/sbin/nologin
   tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/sbin/nologin
   sssd:x:990:984:User for sssd:/:/sbin/nologin
   usbmuxd:x:113:113:usbmuxd user:/:/sbin/nologin
   geoclue:x:989:983:User for geoclue:/var/lib/geoclue:/sbin/nologin
   ntp:x:38:38::/etc/ntp:/sbin/nologin
   gdm:x:42:42::/var/lib/gdm:/sbin/nologin
   rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
   nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
   gnome-initial-setup:x:988:982::/run/gnome-initial-setup/:/sbin/nologin
   sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
   avahi:x:70:70:Avahi mDNS/DNS-SD Stack:/var/run/avahi-daemon:/sbin/nologin
   postfix:x:89:89::/var/spool/postfix:/sbin/nologin
   tcpdump:x:72:72::/:/sbin/nologin
   zhangziqian:x:1000:1000:LinuxPC:/home/zhangziqian:/bin/bash
   testuser1:x:1001:1001::/home/testuser1:/bin/bash
   testuser2:x:1002:1000::/home/testuser2:/bin/bash
   
   
   ```

   

2. 对于具有固定分隔符号的文件，我们常常用`cut`命令进行一些基本处理。例如你能否提取本系统中所有用户的用户名，并将其保存到一个文件`lab3/user.list`中。

   解答：

   ```
   cat /etc/passwd|cut -d : -f 1
   ```

   ```
   root
   bin
   daemon
   adm
   lp
   sync
   shutdown
   halt
   mail
   operator
   games
   ftp
   nobody
   systemd-network
   dbus
   polkitd
   libstoragemgmt
   colord
   rpc
   saned
   gluster
   saslauth
   abrt
   setroubleshoot
   rtkit
   pulse
   radvd
   chrony
   unbound
   qemu
   tss
   sssd
   usbmuxd
   geoclue
   ntp
   gdm
   rpcuser
   nfsnobody
   gnome-initial-setup
   sshd
   avahi
   postfix
   tcpdump
   zhangziqian
   testuser1
   testuser2
   ```

3. 如何查看`/etc/passwd`的前5个用户，最后5个用户，15-20行的用户？可以用`head`与`tail`通过管道（pipe）进行结合。

   ```
   cat /etc/passwd|head -n 5|cut -d : -f 1
   cat /etc/passwd|tail -n 5|cut -d : -f 1
   cat /etc/passwd|sed -n '15,20p'|cut -d : -f 1
   ```

   ```
   root
   bin
   daemon
   adm
   lp
   ```

   ```
   postfix
   tcpdump
   zhangziqian
   testuser1
   testuser2
   ```

   ```
   [root@localhost etc]# cat /etc/passwd|sed -n '15,20p'|cut -d : -f 1
   dbus
   polkitd
   libstoragemgmt
   colord
   rpc
   saned
   ```

   

4. 一个文件同时有几个时间戳：`atime`, `ctime`, `mtime`。这几个时间戳分别代表什么含义，默认`ls -l`输出的是哪个时间戳？如何改变其输出？而`touch`命令修改的是哪个时间戳？

   解答：

   - atime : 它代表着最近一次访问文件的时间
   - mtime : 它代表着最近一次文件内容被修改的时间。可用ls -l 命令查看。
   - ctime : 它代表着最近一次文件状态改变的时间 
   - 默认`ls -l`输出的是`mtime`时间戳
   - 可以修改`atime` ，`mtime`

   

### 五、帮助信息和`vim`的使用

1. 用`tree`命令获取根目录/下的两层文件目录结构，将其重定向到一个文件`lab3/directory_tree`中。
2. 从搜索引擎获取关于bioinformatics在wikipedia上的页面，将其源码用vim命令编辑为bioinformatics，看看在vim下如何跳转到末行，首行，行首、行末，如何在光标行下一行插入，如何复制5行，删除10行，查找bioinformatics的字符，把bioinformatics替换为bioinfo science。
3. 用`man hier`获取每个目录的基本信息，将其用`vim`写入文件`directory_tree`中。
4. 用`man builtins`获取所有bash内置命令的列表，将其写入文件`lab3/builtins`，将其修改为每行包含一个命令的记录，仅保留每个命令的功能信息。
5. 用命令`ip`或者`ifconfig`查看当前系统的网络配置信息，并将其存入文件`lab3/network.info`中。
6. 把你当前的日期信息写入文件`lab3/finished.log`中。



### 六、YUM的使用

1. 用`su - root`命令切换到root，并手动配置`yum`交大的镜像源文件`/etc/yum.repos.d/sjtu.repo`：

   ```
   [base]
   name=CentOS-7 - Base
   baseurl=http://ftp.sjtu.edu.cn/centos/$releasever/os/$basearch/
   gpgcheck=1
   gpgkey= http://ftp.sjtu.edu.cn/centos/RPM-GPG-KEY-CentOS-7
   
   [update]
   name=CentOS-7 - Updates
   baseurl= http://ftp.sjtu.edu. cn/centos/$releasever/updates/$basearch/
   gpgcheck=1
   gpgkey= http://ftp.sjtu.edu.cn/centos/RPM-GPG-KEY-CentOS-7
   
   [extras]
   name=CentOS-7 - Extras
   baseurl= http://ftp.sjtu.edu. cn/centos/$releasever/extras/$basearch/
   gpgcheck=1
   gpgkey= http://ftp.sjtu.edu.cn/centos/RPM-GPG-KEY-CentOS-7
   
   [centosplus]
   name=CentOS-7 - Plus
   baseurl= http://ftp.sjtu.edu. cn/centos/$releasever/centosplus/$basearch/
   gpgcheck=1
   enabled=0
   gpgkey= http://ftp.sjtu.edu.cn/centos/RPM-GPG-KEY-CentOS-7
   ```

   注释：\$releasever——发行版的版本；\$arch —— cpu平台，如i586, i686, x86_64等；\$basearch —— 系统的基本平台，i586和i686对应于i386，AMD64和Intel64对应于x86_64。

   - 然后执行`yum update`更新镜像源的缓存
   - 运行`yum install epel-release`，这里的EPEL（Extra Packages for Enterprise Linux）是由Fedora推出的项目，其中包含许多软件包
   - `yum install wget`安装`wget`工具，这是常用的在线下载工具。
   - 用`yum --help`查看`yum`的帮助信息

2. 用`yum`安装`figlet`软件包，并用`man`查看其帮助信息，尝试用其在命令行下写下下面的图形文字：

```
  _     _       _        __                            _   _
 | |__ (_) ___ (_)_ __  / _| ___  _ __ _ __ ___   __ _| |_(_) ___ ___
 | '_ \| |/ _ \| | '_ \| |_ / _ \| '__| '_ ` _ \ / _` | __| |/ __/ __|
 | |_) | | (_) | | | | |  _| (_) | |  | | | | | | (_| | |_| | (__\__ \
 |_.__/|_|\___/|_|_| |_|_|  \___/|_|  |_| |_| |_|\__,_|\__|_|\___|___/
```

解答：执行完成即可



### 七、基因组序列文件的简单操作

1. 进入`lab3`这个目录，然后创建`genomes/Saccharomyces cerevisiae`，注意这里的目录名包含了一个空格，但是以后我们在工作中要尽量避免在文件名、目录名中出现空格或者其他一些特殊字符，尽量只在文件名中出现字母、数值和下划线。

   解答：创建完成。

2. 进入刚创建的目录，用`wget`命令从`Ensembl`的在线ftp中下载基因组序列

   ```
   http://ftp.ensembl.org/pub/current_fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
   ```

   ![image-20220312153204387](C:\Users\zhangziqian\OneDrive - musicminion\2021-2022-2\2021-2022-2 Linux and Shell Programming\作业\作业3\作业2：Lab3.assets\image-20220312153204387.png)

3. 这个文件是用`gzip`压缩的`FASTA`文件，你可以用`ls`查看一下下载文件的大小，输出单位为KB。

   解答：如下所示，压缩前12MB，压缩后3MB

   ```
   [zhangziqian@localhost Saccharomyces cerevisiae]$ ls -l
   total 19120
   -rw-r--r--. 1 zhangziqian zhangziqian 12360704 Mar 11 23:32 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
   -rw-rw-r--. 1 zhangziqian zhangziqian  3784201 Oct 12 03:22 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
   
   ```

   

4. 将改文件进行解压缩，现在文件的大小是多少？可以粗略计算一下这个gzip文件的压缩比。

   解答：压缩率 $69.38$

5. 可以打开文件查看一下内容，了解一下基因组序列的格式。

   解答：由一段碱基序列组成`A` `G` `C` `T`

```
>I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA
CATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
CACCATCCATCCCTCTACTTACTACCACTCACCCACCGTTACCCTCCAATTACCCATATC
CAACCCACTGCCACTTACCCTACCATTACCCTACCATCCACCATGACCTACTCACCATAC
TGTTCTTCTACCCACCATATTGAAACGCTAACAAATGATCGTAAATAACACACACGTGCT
TACCCTACCACTTTATACCACCACCACATGCCATACTCACCCTCACTTGTATACTGATTT
TACGTACGCACACGGATGCTACAGTATATACCATCTCAAACTTACCCTACTCTCAGATTC
CACTTCACTCCATGGCCCATCTCTCACTGAATCAGTACCAAATGCACTCACATCATTATG
CACGGCACTTGCCTCAGCGGTCTATACCCTGTGCCATTTACCCATAACGCCCATCATTAT
CCACATTTTGATATCTATATCTCATTCGGCGGTCCCAAATATTGTATAACTGCCCTTAAT
ACATACGTTATACCACTTTTGCACCATATACTTACCACTCCATTTATATACACTTATGTC
AATATTACAGAAAAATCCCCACAAAAATCACCTAAACATAAAAATATTCTACTTTTCAAC
AATAATACATAAACATATTGGCTTGTGGTAGCAACACTATCATGGTATCACTAACGTAAA
AGTTCCTCAATATTGCAATTTGCTTGAACGGATGCTATTTCAGAATATTTCGTACTTACA
CAGGCCATACATTAGAATAATATGTCACATCACTGTCGTAACACTCTTTATTCACCGAGC

/*后面的文本省略*/
```



## 上机作业提交

最后别忘记了把`lab3`目录打包成`lab3_yourID.tgz`，并删除目录lab3。