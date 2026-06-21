# TASK-1: https://hub.docker.com/repository/docker/ravvka/custom-nginx/general

# TASK-2: ![img.png](task-02/img.png)

# TASK-3:
1-3
![img_1.png](task-03/img_1.png)
    3 - командой attach мы зашли в основной поток контейнера. При нажатии Ctrl+C мы его завершили.
        Чтобы избежать такой ситуации необходимо подключаться с аргументом --sig-proxy=false

4-6   
![img_2.png](task-03/img_2.png)

7-9   
![img_3.png](task-03/img_3.png)

10   
![img_4.png](task-03/img_4.png)
- мы перенастроили nginx на прослушивание 81 порта, а сам контейнер запущен на 80 порту

12   
![img.png](task-03/img_5.png)

# TASK-4

1-2   
![img_1.png](task-04/img_1.png)
3-5   
![img_2.png](task-04/img_2.png)

# TASK-5
1   
![img_1.png](task-05/img_1.png)
* docker compose может запускать как compose.yaml(yml), так и docker-compose.yaml(yml) (второе для обратной совместимости)
* При наличии обоих файлов предпочтение отдаётся compose.yaml

2   
![img.png](task-05/img_2.png)

3   
![img.png](task-05/img_3.png)

4-5   
![img.png](task-05/img_4.png)

6   
![img.png](task-05/img_5.png)

7   
![img.png](task-05/img_6.png)
* атрибут `version` устарел и игнорируется
* контейнер `05-portainer-1` не описан в текущей настройке docker-compose.yaml 