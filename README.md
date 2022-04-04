# 2021-2022-2-Linux-and-Shell-Programming
For Lab 4 File Upload ONLY.
### Lab 4 正则表达式 实验报告

> 姓名：张子谦		学号：520111910121
>
> 实验报告针对题目做了适度的合并，例如同一个文件相关的题目作为一个任务组。任务组下面的h5标题 `第X题 ` 对应相关的题目。此外，由于要显示命令行中的匹配的字符，部分结果用html的代码显示出，红色为目标字符。

[TOC]



#### 任务组一

下载文件[user](https://oc.sjtu.edu.cn/courses/39890/files/4148319/download?verifier=FdSyujegMiGoE4QEnBgID01PdWTrkSVyH3JrAj6d&wrap=1)，其格式为：

```shell
用户名:密码:用户ID:组ID:用户描述:主目录:登录shell
```

完成以下要求：

> - 分别用grep/sed/awk找出所有登录shell为bash的用户名；
> - 找出UID或者GID为4位以上数字的用户名；
> - 找出主目录为/var/spoo...l的用户，这里.表示不确定o有多少次重复；
> - 已知有个用户名形如mimi...M，这里.表示mi至少一次以上的重复。

##### 第一题 分别用grep/sed/awk找出所有登录shell为bash的用户名；

使用 `grep` 的方法。 

```shell
[zhangziqian@localhost exercise1]$ grep bash$ ./user | cut -d: -f1
root
bio
mimimimimiM
```

- 注意这里必须要加 `bash$` ，我最开始没有加，但是结果依然正确，这是因为没有出现以 $bash$ 为用户名的 $nologin$ 选项，然后我专门在数据文件中添加了一个以 $bash$ 为用户名的行。因为`bash$` 表示结尾为 `bash` 。
- `|` 是管道符号，是unix一个很强大的功能,符号为一条竖线:`|`。用法: `command 1 | command 2`他的功能是把第一个命令`command 1`执行的结果作为`command 2`的输入传给`command 2`。

使用 `sed` 或者 `awk` 的方法。

```shell
[zhangziqian@localhost exercise1]$ sed -n '/bash$/p' ./user | cut -d: -f1
root
bio
mimimimimiM
```

```shell
[zhangziqian@localhost exercise1]$ awk '/bash$/' ./user | cut -d: -f1
root
bio
mimimimimiM
```

##### 第二题 找出UID或者GID为4位以上数字的用户名；

```shell
grep -E ":[0-9]{4,}\:[0-9]{1,}|:[0-9]{1,}\:[0-9]{4,}" ./user | cut -d: -f1
sync
nobody
mongodb
sshd
bio
mimimimimiM
```

##### 第三题 找出主目录为/var/spoo...l的用户，这里.表示不确定o有多少次重复；

```shell
[zhangziqian@localhost exercise1]$ cut -d: -f6 ./user | grep -E "/var/spo*l"
/var/spool/lpd
/var/spool/news
/var/spool/uucp
```

##### 第四题 已知有个用户名形如mimi...M，这里.表示mi至少一次以上的重复。

```shell
[zhangziqian@localhost exercise1]$ cut -d: -f1 ./user | grep -E "[mi]+M"
mimimimimiM
```



#### 任务组二

有个非常混乱的文本文件[regex.txt](https://oc.sjtu.edu.cn/courses/39890/files/4148321/download?verifier=XFdIfDzXcoqnpfS6cdbBPttksjBkYiaap4YqF9wJ&wrap=1)，需要进行一些正则表达式分析：

> - 用`grep`查找其中的大写字母；
> - 用`grep`查找其中的数字；
> - 查找包含"the"的行，忽略大小写，统计其总共出现的次数；
> - 统计不包含"the"的行数；
> - 查找包含"test"或者"tast"的行；
> - 查找不包含"#"的行；
> - 查找"oog"但前面的字符不能是"g"或者"o"；
> - 查找以"the"开头的行；
> - 查找以"d"结束的行；
> - 过滤掉空行；
> - 过滤掉注释行，也就是以"#"开始的行；
> - 查找存在至少两个连续字符"e"的行；
> - 查找字母"g"后面跟着2-5个"o"且后面还有一个"g"的行；
> - 输出`regex.txt`的内容，并打印行号，并删除2-5行；
> - 同上，但删除第5行到最后一行；
> - 原位删除第一行；
> - 在第二行前插入两行"test"，在第三行后添加";;"行；
> - 将2-5行的内容更换为"nothing but 2nd-5th line"；
> - 只输出5-8行

##### 第一题 用`grep`查找其中的大写字母；

```shell
[zhangziqian@localhost exercise2]$ grep -E "[A-Z]" ./regex.txt
```

<pre>
<font color="#EF2929"><b>F</b></font>ootball game is not use feet only.
<font color="#EF2929"><b>H</b></font>owever, this dress is about $ 3183 dollars.
<font color="#EF2929"><b>GNU</b></font> is free air not free beer.
<font color="#EF2929"><b>H</b></font>er hair is very beauty.
<font color="#EF2929"><b>I</b></font> can&apos;t finish the test.
<font color="#EF2929"><b>O</b></font>h! <font color="#EF2929"><b>T</b></font>he soup taste good.
<font color="#EF2929"><b>T</b></font>his window is clear.
<font color="#EF2929"><b>O</b></font>h!<font color="#EF2929"><b>M</b></font>y god!
<font color="#EF2929"><b>T</b></font>he gd software is a library for drafting programs.
<font color="#EF2929"><b>Y</b></font>ou are the best is mean you are the no. 1.
<font color="#EF2929"><b>T</b></font>he world &lt;<font color="#EF2929"><b>H</b></font>appy&gt; is the same with &quot;glad&quot;.
<font color="#EF2929"><b>I</b></font> like dog.
go! go! <font color="#EF2929"><b>L</b></font>et&apos;s go.
# <font color="#EF2929"><b>I</b></font> am <font color="#EF2929"><b>VB</b></font>ird
</pre>



##### 第二题 用`grep`查找其中的数字；

```shell
[zhangziqian@localhost exercise2]$ grep -E "[0-9]" ./regex.txt
```


<pre>However, this dress is about $ <font color="#EF2929"><b>3183</b></font> dollars.
You are the best is mean you are the no. <font color="#EF2929"><b>1</b></font>.
</pre>



##### 第三题 查找包含"the"的行，忽略大小写，统计其总共出现的次数；

```shell
[zhangziqian@localhost exercise2]$ grep -n -i "the" ./regex.txt
[zhangziqian@localhost exercise2]$ grep -c -i "the" ./regex.txt
7
```

第一个命令的输出结果如下，统计的结果是七行（当然也可以直接数下面的行数）。

<pre>
<font color="#4E9A06">10</font><font color="#06989A">:</font>I can&apos;t finish <font color="#EF2929"><b>the</b></font> test.
<font color="#4E9A06">11</font><font color="#06989A">:</font>Oh! <font color="#EF2929"><b>The</b></font> soup taste good.
<font color="#4E9A06">14</font><font color="#06989A">:</font><font color="#EF2929"><b>the</b></font> symbol &apos;*&apos; is represented as start.
<font color="#4E9A06">16</font><font color="#06989A">:</font><font color="#EF2929"><b>The</b></font> gd software is a library for drafting programs.
<font color="#4E9A06">17</font><font color="#06989A">:</font>You are <font color="#EF2929"><b>the</b></font> best is mean you are <font color="#EF2929"><b>the</b></font> no. 1.
<font color="#4E9A06">18</font><font color="#06989A">:</font><font color="#EF2929"><b>The</b></font> world &lt;Happy&gt; is <font color="#EF2929"><b>the</b></font> same with &quot;glad&quot;.
<font color="#4E9A06">20</font><font color="#06989A">:</font>google is <font color="#EF2929"><b>the</b></font> best tools for search keyword.
</pre>




##### 第四题 统计不包含"the"的行数；

```shell
[zhangziqian@localhost exercise2]$ grep -v -n "the" ./regex.txt
[zhangziqian@localhost exercise2]$ grep -v -c "the" ./regex.txt
18
```

第一个命令的输出结果如下，统计的结果是 $18$ 行（当然也可以直接数下面的行数）。

<pre>
<font color="#4E9A06">1</font><font color="#06989A">:</font>apple is my favorite food.
<font color="#4E9A06">2</font><font color="#06989A">:</font>test
<font color="#4E9A06">3</font><font color="#06989A">:</font>test
<font color="#4E9A06">4</font><font color="#06989A">:</font>Football game is not use feet only.
<font color="#4E9A06">5</font><font color="#06989A">:</font>this dress doesn&apos;t fit me.
<font color="#4E9A06">6</font><font color="#06989A">:</font>;;
<font color="#4E9A06">7</font><font color="#06989A">:</font>However, this dress is about $ 3183 dollars.
<font color="#4E9A06">8</font><font color="#06989A">:</font>GNU is free air not free beer.
<font color="#4E9A06">9</font><font color="#06989A">:</font>Her hair is very beauty.
<font color="#4E9A06">11</font><font color="#06989A">:</font>Oh! The soup taste good.
<font color="#4E9A06">12</font><font color="#06989A">:</font>motorcycle is cheap than car.
<font color="#4E9A06">13</font><font color="#06989A">:</font>This window is clear.
<font color="#4E9A06">15</font><font color="#06989A">:</font>Oh!My god!
<font color="#4E9A06">16</font><font color="#06989A">:</font>The gd software is a library for drafting programs.
<font color="#4E9A06">19</font><font color="#06989A">:</font>I like dog.
<font color="#4E9A06">21</font><font color="#06989A">:</font>goooooogle yes!
<font color="#4E9A06">22</font><font color="#06989A">:</font>go! go! Let&apos;s go.
<font color="#4E9A06">23</font><font color="#06989A">:</font># I am VBird
</pre>





##### 第五题 查找包含"test"或者"tast"的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n -i "t[ae]st" ./regex.txt
```

第一个命令的输出结果如下，显然是 $4$ 行，当然也可以用之前的统计方法统计。

<pre>
<font color="#4E9A06">2</font><font color="#06989A">:</font><font color="#EF2929"><b>test</b></font>
<font color="#4E9A06">3</font><font color="#06989A">:</font><font color="#EF2929"><b>test</b></font>
<font color="#4E9A06">10</font><font color="#06989A">:</font>I can&apos;t finish the <font color="#EF2929"><b>test</b></font>.
<font color="#4E9A06">11</font><font color="#06989A">:</font>Oh! The soup <font color="#EF2929"><b>tast</b></font>e good.
</pre>




##### 第六题 查找不包含"#"的行；

```shell
[zhangziqian@localhost exercise2]$ grep -v -n -i "#" ./regex.txt
1:apple is my favorite food.
2:test
3:test
4:Football game is not use feet only.
5:this dress doesn't fit me.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
[zhangziqian@localhost exercise2]$ grep -v -c -i "#" ./regex.txt
22
```

当然，一共有 $22$ 行。



##### 第七题 查找"oog"但前面的字符不能是"g"或者"o"；

```shell
[zhangziqian@localhost exercise2]$ grep -n -i "[^g|^o]oog" ./regex.txt
[zhangziqian@localhost exercise2]$ grep -n -i "[^g|o]oog" ./regex.txt
```

- 测试了一下两个命令，输出的结果都没有，事实也证明，不存在符合题目的这样的内容。



##### 第八题 查找以"the"开头的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "^the" ./regex.txt		#严格匹配
[zhangziqian@localhost exercise2]$ grep -n -i "^the" ./regex.txt	#忽略大小写
```

<pre>[zhangziqian@localhost exercise2]$ grep -n -i &quot;^the&quot; ./regex.txt
<font color="#4E9A06">14</font><font color="#06989A">:</font><font color="#EF2929"><b>the</b></font> symbol &apos;*&apos; is represented as start.
<font color="#4E9A06">16</font><font color="#06989A">:</font><font color="#EF2929"><b>The</b></font> gd software is a library for drafting programs.
<font color="#4E9A06">18</font><font color="#06989A">:</font><font color="#EF2929"><b>The</b></font> world &lt;Happy&gt; is the same with &quot;glad&quot;.
[zhangziqian@localhost exercise2]$ grep -n &quot;^the&quot; ./regex.txt
<font color="#4E9A06">14</font><font color="#06989A">:</font><font color="#EF2929"><b>the</b></font> symbol &apos;*&apos; is represented as start.
</pre>




##### 第九题 查找以"d"结束的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "d$" ./regex.txt
```

<pre><font color="#4E9A06">23</font><font color="#06989A">:</font># I am VBir<font color="#EF2929"><b>d</b></font>
</pre>




##### 第十题 过滤掉空行；

```shell
[zhangziqian@localhost exercise2]$ grep -n -v '^$' ./regex.txt
1:apple is my favorite food.
2:test
3:test
4:Football game is not use feet only.
5:this dress doesn't fit me.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
```



##### 第十一题 过滤掉注释行，也就是以"#"开始的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n -v '^#' ./regex.txt
1:apple is my favorite food.
2:test
3:test
4:Football game is not use feet only.
5:this dress doesn't fit me.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
```



##### 第十二题 查找存在至少两个连续字符"e"的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "e\{2,\}" ./regex.txt
```

<pre>
<font color="#4E9A06">4</font><font color="#06989A">:</font>Football game is not use f<font color="#EF2929"><b>ee</b></font>t only.
<font color="#4E9A06">8</font><font color="#06989A">:</font>GNU is fr<font color="#EF2929"><b>ee</b></font> air not fr<font color="#EF2929"><b>ee</b></font> b<font color="#EF2929"><b>ee</b></font>r.
</pre>




##### 第十三题 查找字母"g"后面跟着2-5个"o"且后面还有一个"g"的行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "go\{2,5\}g" ./regex.txt
```

<pre>
<font color="#4E9A06">20</font><font color="#06989A">:</font><font color="#EF2929"><b>goog</b></font>le is the best tools for search keyword.
</pre>




##### 第十四题 输出`regex.txt`的内容，并打印行号，并删除2-5行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "" ./regex.txt | sed '2,5d'
1:apple is my favorite food.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
23:# I am VBird
```



##### 第十五题 同上，但删除第5行到最后一行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "" ./regex.txt | sed '5,$d'
1:apple is my favorite food.
2:test
3:test
4:Football game is not use feet only.
```



##### 第十六题 原位删除第一行；

```shell
[zhangziqian@localhost exercise2]$ grep -n "" ./regex.txt | sed '1d'
2:test
3:test
4:Football game is not use feet only.
5:this dress doesn't fit me.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
23:# I am VBird
```



##### 第十七题 在第二行前插入两行"test"，在第三行后添加";;"行；

```shell
[zhangziqian@localhost exercise2]$ sed -i '2i test\ntest' ./regex.txt
[zhangziqian@localhost exercise2]$ sed -i '3a ;;' ./regex.txt
[zhangziqian@localhost exercise2]$ grep -n "" ./regex.txt
1:apple is my favorite food.
2:test
3:test
4:;;
5:test
6:test
7:Football game is not use feet only.
8:this dress doesn't fit me.
9:;;
10:However, this dress is about $ 3183 dollars.
11:GNU is free air not free beer.
12:Her hair is very beauty.
13:I can't finish the test.
14:Oh! The soup taste good.
15:motorcycle is cheap than car.
16:This window is clear.
17:the symbol '*' is represented as start.
18:Oh!My god!
19:The gd software is a library for drafting programs.
20:You are the best is mean you are the no. 1.
21:The world <Happy> is the same with "glad".
22:I like dog.
23:google is the best tools for search keyword.
24:goooooogle yes!
25:go! go! Let's go.
26:# I am VBird
```



##### 第十八题 将2-5行的内容更换为"nothing but 2nd-5th line"；

(此题目接上题目修改)

```shell
[zhangziqian@localhost exercise2]$ sed -i '2,5c nothingbut2nd-5thline' ./regex.txt
[zhangziqian@localhost exercise2]$ grep -n "" ./regex.txt
1:apple is my favorite food.
2:nothingbut2nd-5thline
3:test
4:Football game is not use feet only.
5:this dress doesn't fit me.
6:;;
7:However, this dress is about $ 3183 dollars.
8:GNU is free air not free beer.
9:Her hair is very beauty.
10:I can't finish the test.
11:Oh! The soup taste good.
12:motorcycle is cheap than car.
13:This window is clear.
14:the symbol '*' is represented as start.
15:Oh!My god!
16:The gd software is a library for drafting programs.
17:You are the best is mean you are the no. 1.
18:The world <Happy> is the same with "glad".
19:I like dog.
20:google is the best tools for search keyword.
21:goooooogle yes!
22:go! go! Let's go.
23:# I am VBird
```



##### 第十九题 只输出5-8行

```shell
[zhangziqian@localhost exercise2]$ sed -n '5,8p' ./regex.txt
this dress doesn't fit me.
;;
However, this dress is about $ 3183 dollars.
GNU is free air not free beer.

```



#### 任务组三

1. 下载文件[sample.GTF](https://oc.sjtu.edu.cn/courses/39890/files/4189657/download?verifier=s3Oft47jbng5ffXFECmX5eSgb27RkB01LfqdMdSP&wrap=1)

2. 这是一个典型的基因组中编码基因和转录本的信息文件

3. 将文件中每行的外显子（exon）以TAB分隔的坐标信息

   ```
    chr1  xxx   exon      28427874    28425431
   ```

   转换为

   ```
    chr1:28427874-28425431
   ```

   的形式。

4. 将转录组文件中最后一列的基因、外显子、转录本名称的注释信息去除，仅保留转录本的ID信息。

##### 第一题 转换形式

- 似乎文件在分割的时候出现了一些问题，只有用awk才能正常分割。

```
awk '{position=$1":"$4"-"$5; print position;}' ./sample.GTF
chr1:11869-12227
chr1:12613-12721
chr1:13221-14409
chr1:11872-12227
chr1:12613-12721
chr1:13225-14412
chr1:11874-12227
chr1:12595-12721
chr1:13403-13655
chr1:13661-14409
chr1:12010-12057
chr1:12179-12227
chr1:12613-12697
chr1:12975-13052
chr1:13221-13374
chr1:13453-13670
chr1:29321-29370
chr1:24738-24891
chr1:18268-18379
chr1:17915-18061
chr1:17602-17742
chr1:17233-17364
chr1:16854-17055
chr1:16607-16765
chr1:15904-15947
chr1:15796-15901
chr1:14970-15038
chr1:14363-14829
chr1:24734-24886
chr1:18268-18369
chr1:17915-18061
chr1:17606-17742
chr1:17498-17504
chr1:17233-17364
chr1:16854-17055
chr1:14970-15038
chr1:14363-14829
chr1:29321-29370
chr1:24738-24891
chr1:17915-18061
chr1:17606-17742
chr1:17233-17368
chr1:16858-17055
chr1:16607-16765
chr1:15796-15947
chr1:14970-15038
chr1:14363-14829
chr1:29534-29570
chr1:24738-24891
chr1:18268-18366
chr1:17915-18061
chr1:17606-17742
chr1:17233-17368
chr1:16858-17055
chr1:16607-16765
chr1:15796-15947
chr1:15005-15038
chr1:14404-14501
chr1:29534-29806
chr1:24737-24891
chr1:18268-18366
chr1:17915-18061
chr1:17602-17742
chr1:17233-17364
chr1:16858-17055
chr1:16748-16765
chr1:16607-16745
chr1:15904-15947
chr1:15796-15901
chr1:15000-15038
chr1:14411-14502
chr1:29554-30039
chr1:30564-30667
chr1:30976-31097
chr1:30267-30667
chr1:30976-31109
chr1:30366-30503
```



##### 第二题 仅保留转录本的ID信息。

```shell
awk '{print $22;}' ./sample.GTF > 1.tmp
"ENSE00002234944";
"ENSE00003582793";
"ENSE00002312635";
"ENSE00002234632";
"ENSE00003608237";
"ENSE00002306041";
"ENSE00002269724";
"ENSE00002270865";
"ENSE00002216795";
"ENSE00002303382";
"ENSE00001948541";
"ENSE00001671638";
"ENSE00001758273";
"ENSE00001799933";
"ENSE00001746346";
"ENSE00001863096";
"ENSE00001718035";
"ENSE00003624050";
"ENSE00001642865";
"ENSE00003638984";
"ENSE00001699689";
"ENSE00001656010";
"ENSE00001760358";
"ENSE00003618297";
"ENSE00001375216";
"ENSE00001388009";
"ENSE00003497546";
"ENSE00003511598";
"ENSE00002254515";
"ENSE00002303227";
"ENSE00003638984";
"ENSE00003629019";
"ENSE00002285713";
"ENSE00001656010";
"ENSE00001760358";
"ENSE00003497546";
"ENSE00003511598";
"ENSE00001718035";
"ENSE00003603734";
"ENSE00003513603";
"ENSE00003565315";
"ENSE00003685767";
"ENSE00003553898";
"ENSE00003621279";
"ENSE00002030414";
"ENSE00003591210";
"ENSE00003693168";
"ENSE00001890219";
"ENSE00003507205";
"ENSE00003477500";
"ENSE00003565697";
"ENSE00003475637";
"ENSE00003502542";
"ENSE00003553898";
"ENSE00003621279";
"ENSE00002030414";
"ENSE00001935574";
"ENSE00001843071";
"ENSE00001378845";
"ENSE00002317443";
"ENSE00003682243";
"ENSE00003638984";
"ENSE00001699689";
"ENSE00001656010";
"ENSE00003632482";
"ENSE00002275850";
"ENSE00002241734";
"ENSE00001375216";
"ENSE00001388009";
"ENSE00002215305";
"ENSE00002295553";
"ENSE00001947070";
"ENSE00001922571";
"ENSE00001827679";
"ENSE00001841699";
"ENSE00001890064";
"ENSE00003695741";
```

#### 任务组四

已知命令`ip addr`可输出本机多张网卡的IP地址等信息，你能否从中抽取MAC地址、IP地址和子网掩码？

##### 第一题 ip信息抽取

- 首先执行 `ip addr > ipInfo` ，将输出重定向到文件中。

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:60:cc:8d brd ff:ff:ff:ff:ff:ff
    inet 192.168.85.128/24 brd 192.168.85.255 scope global noprefixroute dynamic ens33
       valid_lft 1592sec preferred_lft 1592sec
    inet6 fe80::1875:5aee:9926:29ab/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:98:dd:18 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
4: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast master virbr0 state DOWN group default qlen 1000
    link/ether 52:54:00:98:dd:18 brd ff:ff:ff:ff:ff:ff
```

- 查看IP地址。

```
grep "inet " ./ipInfo | awk '{print $2;}'
127.0.0.1/8
192.168.85.128/24
192.168.122.1/24
```

- 查看Mac地址。

```
grep "link/" ./ipInfo | awk '{print $2;}'
00:00:00:00:00:00
00:0c:29:60:cc:8d
52:54:00:98:dd:18
52:54:00:98:dd:18
```

- 查看子网掩码

```
grep "inet " ./ipInfo | awk '{print $4;}'
host
192.168.85.255
192.168.122.255
```



#### 任务组五

针对FASTA格式的序列文件[improper.fa](https://oc.sjtu.edu.cn/courses/39890/files/4148324/download?verifier=dofSjKTVj4r4ZUASA2KgupheheJ0ZqsJ9pkHfjQW&wrap=1)

> - 输出每条序列的长度；
> - 输出每条序列中A/C/G/T四种碱基出现的频率；
> - 计算每条序列中A/C/G/T四种碱基的比例；
> - 计算所有序列中碱基的平均比例；
> - 这些序列中包含一个错误，你能找出来么？

##### 问题一 ~ 问题四：信息统计

```
#!/usr/bin/awk -f
BEGIN {	
    AA = 0;
    GG = 0;
    CC = 0;
    TT = 0;
}
{
	c = substr($0, 0, 1);
	if(c == ">"){
		print $0;
		next;
	}
		
	else{
		curAA = 0;
		curGG = 0;
		curCC = 0;
		curTT = 0;
		
		for(i=0; i<=length($0); i++)
		{
			if(substr($0, i, 1) == "A")
				curAA ++;
			if(substr($0, i, 1) == "G")
				curGG ++;
			if(substr($0, i, 1) == "C")
				curCC ++;
			if(substr($0, i, 1) == "T")
				curTT ++;
		}
		
		print "碱基的个数：",length($0);
		print "A的含量：",curAA,"A的频率：",curAA/length($0);
		print "G的含量：",curGG,"G的频率：",curGG/length($0);
		print "C的含量：",curCC,"C的频率：",curCC/length($0);
		print "T的含量：",curTT,"T的频率：",curTT/length($0);
		
		AA += curAA;
		GG += curGG;
		CC += curCC;
		TT += curTT;	
	}
}

END{
	print ">综合统计信息";
	print "所有A的含量：",AA;
	print "所有G的含量：",GG;
	print "所有C的含量：",CC;
	print "所有U的含量：",TT;
	print "所有A的比例：",AA/(AA+GG+CC+TT);
	print "所有G的比例：",GG/(AA+GG+CC+TT);
	print "所有C的比例：",CC/(AA+GG+CC+TT);
	print "所有U的比例：",TT/(AA+GG+CC+TT);
}

awk -f exercise5.awk improper.fa
[zhangziqian@localhost exercise5]$ awk -f exercise5.awk improper.fa
>good-sequence
碱基的个数： 46
A的含量： 13 A的频率： 0.282609
G的含量： 11 G的频率： 0.23913
C的含量： 14 C的频率： 0.304348
T的含量： 9 T的频率： 0.195652
>bad-sequence
碱基的个数： 46
A的含量： 13 A的频率： 0.282609
G的含量： 13 G的频率： 0.282609
C的含量： 11 C的频率： 0.23913
T的含量： 9 T的频率： 0.195652
>综合统计信息
所有A的含量： 26
所有G的含量： 24
所有C的含量： 25
所有U的含量： 18
所有A的比例： 0.27957
所有G的比例： 0.258065
所有C的比例： 0.268817
所有U的比例： 0.193548
```

##### 问题五：存在的问题

- 序列的描述不清晰？
- 46个碱基的序列不是3的倍数？



#### 任务组六

针对文件[twoseqs.fa](https://oc.sjtu.edu.cn/courses/39890/files/4148327/download?verifier=Y5faYznVHQmt68jx6saEApLs617R0dCUda75JihH&wrap=1)[](http://cbb.sjtu.edu.cn/course/bi296/data/twoseqs.fa)中的两条DNA序列，编写awk脚本。

> - 计算每个序列的3-mer的发生频率，所谓3-mer指的是序列中长度为3的子串，如在序列ACTGGACT中ACT的发生率为2。
> - 根据3-mer的频率按照下列公式计算两序列的相似性得分：

$$
score = \exp\left( -\sum_i (occ_{1i}- occ_{2i})^2\right)
$$

##### 问题一 发生率计算

```
#!/usr/bin/awk -f
BEGIN {
	seqID = 0;
}
{
	c = substr($0, 0, 1);
	if(c == ">"){
		next;
	}
	else{
		seqID++;
		for(i=0; i<=length($0)-2; i++){
			#print substr($0, i, 3);
			if(seqID == 1){
				table1[substr($0, i, 3)]++;
			}
			if(seqID == 2){
				table2[substr($0, i, 3)]++;
			}
		}
	}
}
END {
	tmpsum = 0;
	for(i in table1)
		print i,table1[i];
	for(i in table2)
		print i,table2[i];
}
```



##### 问题二 相似性得分

- 偷懒了一下下，就把基因合并了一行，不过此题重点在于计算。
- 对于每一个三长度字串，计算频率，然后再作差。

- 最终答案是： $0.000335463$

```sh
#!/usr/bin/awk -f
BEGIN {
	seqID = 0;
}
{
	c = substr($0, 0, 1);
	if(c == ">"){
		next;
	}
	else{
		seqID++;
		for(i=0; i<=length($0)-2; i++){
			#print substr($0, i, 3);
			if(seqID == 1){
				table1[substr($0, i, 3)]++;
			}
			if(seqID == 2){
				table2[substr($0, i, 3)]++;
			}
		}
	}
}
END {
	tmpsum = 0;
	for(i in table1)
		print i,table1[i];
	print "---------------------------------------------";
	for(i in table2)
		print i,table2[i];
	
	for(i in table1)
		tmpsum += (table1[i] - table2[i])^2;
	for(i in table2)
		tmpsum += (table1[i] - table2[i])^2;
	print "最终答案是：",2.71828182^(-tmpsum);
}
awk -f exercise6.awk twoseqs.fa
最终答案是： 0.000335463
```





#### 任务组七

从PDB数据库中下载一个PDB格式的大分子结构文件[4CHK.pdb](https://oc.sjtu.edu.cn/courses/39890/files/4146754/download?verifier=P8ryBC2kyeSzVdq4AHKUnl0UabWKVMW26tJmWIZa&wrap=1)，统计蛋白质中氨基酸的组成情况，并计算其中所有$C_{\alpha}$原子两两之间的欧氏距离。

##### 问题一 氨基酸统计

```sh
#!/usr/bin/awk -f
BEGIN {
	
}
{
     table[$4]++;
}
END{
    for(i in table)
		print i,table[i];
}
A 1
CYS 288
GLY 480
B 1
LEU 1120
AARG 12
C 1
PRO 336
GLN 540
THR 672
D 1
ILE 544
HOH 159
E 1
F 1
ASN 64
MET 288
G 1
LYS 774
TYR 768
H 9
ASP 784
SER 828
BARG 12
PHE 528
HIS 160
GLU 1350
TRP 448
ARG 666
ALA 100
VAL 1120
```



##### 问题二 氨基酸欧氏距离

```sh
#!/usr/bin/awk -f
BEGIN {
	num = 0;
}
{
     table[$4]++;
     if($3 == "CA"){
     	num++;
     	xx[num] = $7;
     	yy[num] = $8;
     	zz[num] = $9;
     	acid[num] = $2;
     }
}
END{
    for(i in table)
		print i,table[i];
	
	for(x = 1; x<=num; x++){
		for(y = x+1; y<=num; y++){
			print acid[x],"和",acid[y],"位置的氨基酸的距离是：",sqrt((xx[x]-xx[y])*(xx[x]-xx[y]) + (yy[x]-yy[y])*(yy[x]-yy[y]) + (zz[x]-zz[y])*(zz[x]-zz[y]))
		}
	}
}
```

- 由于文件实在太大 所以打包上传。有些位置号有两个或者多个氨基酸。

```
857 和 4462 位置的氨基酸的距离是： 27279.6
857 和 4472 位置的氨基酸的距离是： 16774.2
857 和 4472 位置的氨基酸的距离是： 9510.43
857 和 4483 位置的氨基酸的距离是： 16775.7
857 和 4483 位置的氨基酸的距离是： 8363.85
857 和 4490 位置的氨基酸的距离是： 16779.3
857 和 4490 位置的氨基酸的距离是： 5298.37
857 和 4502 位置的氨基酸的距离是： 16780.8
857 和 4502 位置的氨基酸的距离是： 1952.88
857 和 4509 位置的氨基酸的距离是： 16782.2
```



#### 任务组八

有一个文件[competition.txt](https://oc.sjtu.edu.cn/courses/39890/files/4146759/download?verifier=xUhTGyie52X6k7hTxyHZCJ2quVEDmDWW11XC19lo&wrap=1)，记录了红、蓝、绿三队队员的比赛得分情况。编写一个脚本，

> - 计算每个队员的平均得分；
> - 计算每轮比赛的平均得分；
> - 计算每支队伍的平均得分；

**注意**：

- 文件的首行是文件头；
- 如果某个队员的得分为负值，说明该队员缺席了该比赛，统计的时候应该忽略；
- 输出结果时，字符串左对齐占据10个字符长度；数值按右对齐占据7个字符，2位小数位；
- 脚本应该有更广泛的适用性，不应局限于本文件

##### 问题组 编写脚本

```sh
#!/usr/bin/awk -f
BEGIN {
	FS = ",";
}
{
	sum = 0;	sumScore = 0;
	for (i = 1; i <= NF; ++i){
		table[NR,i] = $i;
		
		if(NR>=2 && i >= 3 && $i >=0){
			sumScore += $i;
			sum ++;
		}
	}
	
	if(NR>=2)
		print $1,"的个人平均分是：",sumScore/sum;
}
END{
	for(i=3; i<=NF; i++){
		sum = 0;	sumScore = 0;
		for(j=2; j<=NR; j++){
			if(table[j,i]>0){
				sumScore += table[j,i];
				sum ++;
			}			
		}
		print table[1,i],"比赛的均分是：",sumScore/sum;
	}
	
	
	for(i=2; i<=NR; i++){
		for(j=3; j<=NF; j++){
			if(table[i,j]>0){
				teamNum[table[i,2]]++;
				teamScoreSum[table[i,2]] += table[i,j];
			}
		}
	}
	
	for(i=2; i<=NR; i++){
		if(booktable[table[i,2]] ==0){
			print table[i,2],"队伍的均分是",teamScoreSum[table[i,2]]/teamNum[table[i,2]];
			booktable[table[i,2]] = 1;
		}
	}
	
}

[zhangziqian@localhost exercise8]$ awk -f exercise8.awk competition.txt
Tom 的个人平均分是： 14.6667
Joe 的个人平均分是： 13
Maria 的个人平均分是： 15
Fred 的个人平均分是： 13.3333
Carlos 的个人平均分是： 19.5
Phuong 的个人平均分是： 15.6667
Enrique 的个人平均分是： 13
Nancy 的个人平均分是： 15
First Test 比赛的均分是： 5
 Second Test 比赛的均分是： 15.75
 Third Test 比赛的均分是： 22.125
Red 队伍的均分是 16
Green 队伍的均分是 13.8889
Blue 队伍的均分是 14.1667
```





