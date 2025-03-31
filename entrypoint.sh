#!/bin/bash

DEBUG="${INPUT_DEBUG}"

if [[ "$DEBUG" == "true" ]]; then
  set -x
fi


python3 -m venv ~/py_envs
ls ~/py_envs/bin
source ~/py_envs/bin/activate
python3 -m pip install -r /py-scripts/requirements.txt


# source /py-scripts/venv/Scripts/activate
# source /py-scripts/venv/bin/activate
# pip3 install requests==2.25.1
# pip3 install -r /py-scripts/requirements.txt

git lfs install

echo begin
echo ${GITHUB_REPOSITORY}
env
mkdir ~/git_repo
cd ~/git_repo
git init
git remote add origin https://github.com/${GITHUB_REPOSITORY}.git
git config http.https://github.com/.extraheader "AUTHORIZATION: basic $(echo -n "x-access-token:${INPUT_TOKEN}" | base64)"
git fetch --all
for branch in `git branch -a | grep remotes | grep -v HEAD`; do
  git branch --track ${branch##*/} $branch
done

_owner=$(echo "${GITHUB_REPOSITORY}"|cut -f1 -d"/")
_repo_name=$(echo "${GITHUB_REPOSITORY}"|cut -f2 -d"/")
echo "_owner = ${_owner}, _repo_name = ${_repo_name}"

_real_gitee_user=${_owner}
if [[ "${INPUT_GITEEUSER}" != "" ]]; then
  _real_gitee_user=${INPUT_GITEEUSER}
fi
_real_gitee_repo=${_repo_name}
if [[ "${INPUT_GITEEREPO}" != "" ]]; then
  _real_gitee_repo=${INPUT_GITEEREPO}
fi


python3 /py-scripts/http_utils.py --passcode "${INPUT_GITEETOKEN}" \
--url "https://gitee.com/api/v5/user/repos" \
--reponame "${_real_gitee_repo}"


remote_repo="https://${_real_gitee_user}:${INPUT_GITEETOKEN}@gitee.com/${_real_gitee_user}/${_real_gitee_repo}.git"
git remote add gitee "${remote_repo}"
git show-ref # useful for debugging
git branch --verbose
# publish all
git push --all --force gitee
git push --tags --force gitee

# Skip original code
exit $?
