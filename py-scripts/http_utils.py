# !/usr/bin/env python3
# -*- coding: utf8 -*

import requests
import sys
import argparse


def post_json(url, data_as_json):
    headers = {
        "Content-Type": "application/json; charset=UTF-8"
    }
    response = requests.post(url, json=data_as_json, headers=headers)
    print('response=', response)
    as_json = response.json()
    print('as_json=', as_json)
    return as_json


def get_json(url, query_string_dict=None):
    headers = {
        "Content-Type": "application/json; charset=UTF-8"
    }
    response = requests.get(url, params=query_string_dict, headers=headers).json()
    return response


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='argparse testing')
    parser.add_argument('--url',     '-u',type=str ,required=True,help="url")
    parser.add_argument('--passcode','-p',type=str, help='password or passcode')
    parser.add_argument('--reponame','-r',type=str, help='reponame')

    args = parser.parse_args()
    print(args)

    json_data = {"has_issues":"true","has_wiki":"true","can_comment":"true","private":"true"}
    json_data['access_token'] = args.passcode
    json_data['name'] = args.reponame

    r = post_json(args.url, json_data)
    print('response=', r)

    