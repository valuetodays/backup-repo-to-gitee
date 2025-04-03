# gitee-mirror

使用 GitHub actions 同步 GitHub 仓库到 Gitee 仓库

创建 GITEE_TOKEN （[入口地址](https://gitee.com/profile/personal_access_tokens)）并在每个需要同步的 github 仓库的设置、 secret 中配置。

## 使用说明

可以参考[示例工程](https://github.com/valuetodays/sync-gitee-mirror-test)。

在 GitHub actions 配置文件中写入以下内容，其中 `with` 下的部分需要按需修改。

```yaml
jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
    - name: backup-repo-to-gitee
      uses: valuetodays/backup-repo-to-gitee@master
      with:
        # default is github repo name
        giteerepo: sync-gitee-mirror-test
        # default is github user name
        giteeuser: valuetodays
        # must not be empty
        giteetoken: ${{ secrets.GITEE_TOKEN }}
```

- `giteerepo`：填你的用户名与仓库名，格式如样例所示。
- `giteeuser`：填写你的 gitee 用户名
- `giteetoken`：填写你的 gitee 密码（注意：密码需要以 [Secrets](https://docs.github.com/cn/actions/reference/encrypted-secrets) 方式给出，以保证密码不被泄露，同时尽量确保密码避免 bash 特殊字符 `` !'"`@ `` 等等）
