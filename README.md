## 背景
[PRReview.sh](https://www.drupal.org/project/pareviewsh)是Drupal官方维护的工具集，包含Drupal代码规范检查，phpstan静态代码检查等。提交到drupal.org的模块或者theme通过简单配置即可使用该脚本进行检查。
由于该工具的安装依赖于php和node环境，composer，npm等包管理工具，使得安装配置比较繁琐折腾。
本项目将改工具做成docker镜像，方便使用，节约折腾时间。

## 介绍
该镜像包含如下工具（来自官方介绍）
* eslint （JS代码质量检查）
* phpcs （PHP代码规范检查，Drupal代码规范检查）
* phpstan (PHP静态代码检查)
* stylelint （CSS代码质量检查）
* cspell （单词拼写检查）
* Check if README exists （README文件是否存在检查）
* Check README sections  （README文件段落检查）
* Check if hook_help exists （模块hook_help是否存在）
* Check *.info.yml syntax （*.info.yml语法检查）
* And more small checks
* Faster than drupal-ci-local. 1 sec VS 2:30 min for example

不包含phpunit

## 使用
#### 场景1 => 检查远程模块代码

```bash
docker run --rm  davyinsa/pareviewsh pareview.sh https://git.drupalcode.org/project/media_gallery.git 2.0.x
```

#### 场景2 => 在当前模块目录下执行
```bash
docker run --rm -v $(pwd):/app davyinsa/pareviewsh pareview.sh /app
```

#### 场景3 => 运行任意目录下的代码检查
```bash
docker run --rm -v /Users/terry/www/drupal/docroot/modules/custom/dyniva_experience_fragment:/app davyinsa/pareviewsh pareview.sh /app
```


#### 场景4 => 自动修复代码(当前目录)
```bash
docker run --rm -v $(pwd):/app davyinsa/pareviewsh phpcbf --standard=Drupal,DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml,twig /app
```

## 相关问题
[provide a docker image for PAReview.sh](https://www.drupal.org/project/pareviewsh/issues/3449071)

## 已知问题
目前使用github action无法构建成功镜像，本地可以构建成功。暂时使用本地构建，推送到docker hub.
构建命令为：
```
docker buildx build  --platform linux/amd64,linux/arm64 --progress=plain -t davyinsa/pareviewsh . --push
```
