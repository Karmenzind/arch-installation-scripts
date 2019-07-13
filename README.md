
ArchLinux Installation Scripts
==============================

This repo is no longer maintained.

此仓库目前已经停止维护，仅供参考。

------------

内容               | 状态
:------------------|:--
ArchLinux安装脚本  | 2018-09-20 自测成功安装，机械硬盘

## TOC

<!-- vim-markdown-toc GFM -->

* [用法简述](#用法简述)
* [详细介绍](#详细介绍)
    * [文件结构](#文件结构)
    * [使用前提](#使用前提)
    * [分区说明](#分区说明)
    * [安装步骤](#安装步骤)

<!-- vim-markdown-toc -->

## 用法简述


在repo根目录运行[install.sh](./install.sh)，选择所需的功能，根据提示操作。[详细介绍见下文](#安装脚本部分)。
```bash
git clone https://github.com/Karmenzind/dotfiles-and-scripts --depth=1
cd ./dotfiles-and-scripts
./install.sh  
```
:exclamation: 注意：除了下文特别说明的（如Arch安装第一步）一些功能，其他脚本都建议**从install.sh统一执行**，否则会报错


## 详细介绍

### 文件结构

> 命名对应了ArchWiki中的安装过程

- [livecd_part](./scripts/install_arch/livecd_part.sh) LiveCD部分：分区、安装base package等
- [chrooted_part](./scripts/install_arch/chrooted_part.sh) 进入chroot环境之后的部分，直到重启
- [general_recommendations_part](./scripts/install_arch/general_rec_part.sh) 安装完成后的一些基础设置，目前内容较少，后续根据需要增加
- [graphical_env_part](./scripts/install_arch/graphical_env_part.sh) 安装图形环境，目前支持GNOME kde Xfce4 i3wm

### 使用前提

*   熟悉ArchLinux安装和Bash语法
*   一块独立硬盘（暂不兼容和其他系统在同一硬盘混装）
*   设备支持UEFI（采用GPT分区，后续可能会加入MBR支持）
*   手动配置网络（暂不提供网络配置，请参考ArchWiki）

### 分区说明

提供了两种分区方式，用Y/N选择：
```
Do you want to use recommended partition table as follows (Y) 
or do the partition by yourself? (N)
recommended table:
1. for a disk larger than 60G:
    550MiB              ESP             for boot
    32GiB               ext4            for ROOT
    the same as         linux-swap      for SWAP
    your ram            
    remainder           ext4            for HOME
2. for a disk smaller than 60G:
    550MiB              ESP             for BOOT
    remainder           ext4            for ROOT
    (you can create a swapfile by yourself after installation)
```
包括：
*   自动分区，空间大于60G时，参考ArchWiki的推荐分区（wiki里认为`/`分区20G够用，此处改成了32G）；小于60G时，参考了Manjaro的处理方式。
*   手动分区，进入fdisk交互环境自行操作，保存退出。支持boot、root、swap、home每种用途分区最多一个。

### 安装步骤

1. 确定阅读完上述内容。经安装介质启动进入LiveCD环境，参考ArchWiki手动配置好网络。
2. **在LiveCD环境中执行liveCD part**。<br>
    方案一，拷贝整个项目到LiveCD。执行`pacman -Sy git`尝试安装Git，然后进行clone。如果无法安装Git，建议找一台可以ssh登陆的机器（我用了树莓派）用scp传输项目，或者通过挂载其他存储介质来拷贝项目。成功拷贝项目后，参考[Usage](#usage)运行install.sh，依次选择`install ArchLinux`、`livecd part`，依照提示执行。结束后已经处于arch-chroot环境，此时进入`/dotfiles-and-scripts`目录，通过`./install.sh`脚本继续执行`chrooted part`。<br>
    方案二，获取livecd_part.sh文件。手动输入:smiling_imp:如下命令：
    ```bash
    wget https://raw.githubusercontent.com/Karmenzind/dotfiles-and-scripts/master/scripts/install_arch/livecd_part.sh
    bash ./livecd_part.sh
    ```
    进入arch-chroot后，按照[Usage](#usage)介绍clone整个项目，执行`chrooted part`。
3. `chrooted part`执行结束后，重启，取出存储介质，从系统盘进入Arch。
4. 至此Arch系统已经安装完成，后续步骤为系统常用配置，对应了ArchWiki中的[General Recommendations部分](https://wiki.archlinux.org/index.php/General_recommendations)，其中图形环境部分单独分成一步。参考[Usage](#usage)分别执行`general recommendations part`、`graphical environment part`。如果需要批量安装其他软件，则查看下一节。

> 如果是在虚拟机中通过UEFI方式安装Arch，需要在ESP分区根目录创建文件`startup.nsh`写入grub的efi文件地址（注意`\`方向），如`\EFI\grub\grubx64.efi`

