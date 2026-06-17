task-1: https://hub.docker.com/repository/docker/ravvka/custom-nginx/general

task-2: ![img.png](task-02/img.png)

task-3:
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