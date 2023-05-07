# 如何在[Render](https://dashboard.render.com/)中部署小雅Alist的Docker镜像

>[Render](https://dashboard.render.com/)是一个全托管的云计算平台，可以用于托管Docker容器，且每月有750小时的免费使用时长，如果你仅仅部署一个容器，则可以覆盖整月使用。
>
>而[小雅Alist](http://alist.xiaoya.pro/)由于token限制，无法直接用于观看视频，需要自行挂载其docker镜像，使用自己的token才能正常观看。这无疑对没有服务器/软路由等可以用来挂载Docker镜像的设备的用户设置了一道很高的门槛。
>
>而无论是[Railway](https://railway.app/dashboard)还是[Render](https://dashboard.render.com/)都无法使用小雅提供的一键命令进行部署，那么该如何将小雅Alist的Docker镜像部署到Render上呢？
>
>通过修改镜像，把自己的token打包进去，重新构筑镜像的办法就可以。
>
>不需要你手动构筑镜像，你可以直接使用这个仓库来完成。

## 部署方法

>好用的话，可以帮我点一下star嘛？

### 新建一个仓库，并设置为**Private**。

点击[这里](https://github.com/new)进入新建仓库的页面，名称任意，设置为Private。

![Private](/pic/Private.png)

### 导入本仓库的内容

翻到最下面，点击import code

![import](/pic/import.png)

输入本仓库的地址，然后点击Begin import。

![address](/pic/address.png)

### 填入自己的token

首先按照[小雅的说明文档](http://alist.xiaoya.pro/%E5%AE%89%E8%A3%85%EF%BC%8C%E9%85%8D%E7%BD%AE%EF%BC%8C%E4%BF%AE%E5%A4%8D%20xiaoya%20docker%20%E6%8C%87%E5%8D%97/%E5%A6%82%E4%BD%95%E5%AE%89%E8%A3%85%E5%92%8C%E7%BB%B4%E6%8A%A4xiaoya%20docker.pdf)中的说明获取自己的token、opentoken、folder_id。

![xiaoyadoc](/pic/xiaoyadoc.png)

然后在自己新建的Private仓库中进入data文件夹，编辑三个文件，分别填入上图的三个参数并保存。

![edit](/pic/edit.png)

![commit](/pic/commit.png)

### 在Render进行部署

打开[Render](https://dashboard.render.com/)，用相同的GitHub账户登录，然后点击New Web Service，选择刚刚自己新建的的Private仓库，点击Connect。

Name随意填写，Runtime选择免费的那一项，翻到最后点击Advanced，在展开的选项中点击Add Environment Variable，添加环境变量PORT=5678。

![environment](/pic/environment.png)

然后再点击最下方的Create Web Service。

等待3-5分钟，Logs窗口出现类似于下图这样的信息时，你的小雅Alist Docker镜像就成功部署到Render上啦，在标题下方你可以找到访问地址。

![log](/pic/log.png)

![url](/pic/url.png)

### 同步更新小雅Alist的内容

你只需要在Render中删除这个项目，然后重新Create New Service，重复最后这一步操作，就可以同步更新小雅Alist的更新内容。

### 搜索以及WebDav挂载问题

由于Render的原因，在Render上搭建的小雅Alist的Docker镜像的搜索和WebDav挂载功能会失效，需要你再搭建一个Alist，并挂载你在Render上搭建的小雅，并构建索引，才能正常搜索并挂载WebDav。

## 容器保活

Render上托管的项目并不一定会一直保持活跃，有些在一段时间无人访问之后就会休眠，所以可以使用一些外部监控手段保活。

我已知的网站监控：
>1 [cron-job.org](https://console.cron-job.org)
>
>2 [UptimeRobot](https://uptimerobot.com/)

可供自行搭建的网站监控：
>[Uptime-Kuma](https://github.com/louislam/uptime-kuma)
