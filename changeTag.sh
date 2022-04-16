#!/bin/bash
sed "s/version/$1/g" kubernetes1.yml > kubernetes1-deploy.yml
