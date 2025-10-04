# 파이썬 3.11 설치 및 venv 구성
$ python -V
Python 3.6.8

$ sudo dnf install python311

$ sudo update-alternatives --config python3

Enter to keep the current selection[+], or type selection number: 2

$ python -V
Python 3.11.9

$ python -m venv annbench

$ source annbench/bin/activate

# Git 설치 및 clone
$ sudo dnf install git

$ git clone https://github.com/erikbern/ann-benchmarks.git

# 라이브러리 설치
$ cd ann-benchmarks/
$ pip install -r requirements.txt 

# Docker 설치
$ sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
$ sudo dnf remove -y runc
$ sudo dnf install -y docker-ce --nobest

$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service

$ sudo /usr/sbin/groupadd -f docker
$ sudo /usr/sbin/usermod -aG docker opc

# Docker 설치 권한 적용 후 재로그인 필요

# install.py 실행 예제
$ python install.py --help
$ python install.py
$ python install.py --proc 16
$ python install.py --proc 16 --algorithm pgvector
$ python install.py --proc 16 --algorithm qdrant

# run.py 실행 예제
$ python run.py --help
$ python run.py --dataset glove-25-angular --algorithm pgvector 
$ python run.py --dataset glove-25-angular --algorithm pgvector --runs 1 --batch

# PostgreSQL 컨테이너 확인 및 쿼리
$ docker ps

$ docker exec -it 787aedb2db4b psql -d ann -U ann -c "SELECT phase, round(100.0 * blocks_done / nullif(blocks_total, 0), 1) FROM pg_stat_progress_create_index;"

$ docker exec -it 75cb425ce34f psql -d ann -U ann -c "SELECT count(*) from items;"

$ docker exec -it 75cb425ce34f psql -d ann -U ann -c "SELECT * from items limit 1;"

$ while true; do docker exec -it 75cb425ce34f psql -d ann -U ann -c "SELECT phase, round(100.0 * blocks_done / nullif(blocks_total, 0), 1) FROM pg_stat_progress_create_index;"; sleep 3; done

# PostgreSQL 성능 튜닝 예제
SET maintenance_work_mem = '8GB';
SET max_parallel_maintenance_workers = 7;
SET max_parallel_workers =8;

# 권한 부여
sudo chmod -R 775 ./results

# plot.py 실행 (예시)
python plot.py --dataset glove-25-angular --count 10 --batch

# create_website.py 실행
python create_website.py --outputdir website
