task-1: https://hub.docker.com/repository/docker/ravvka/custom-nginx/general

task-2: ![img.png](task-02/img.png)

task-3:
![img_1.png](task-03/img_1.png)
    3 - командой attach мы зашли в основной поток контейнера. При нажатии Ctrl+C мы его завершили.
        Чтобы избежать такой ситуации необходимо подключаться с аргументом --sig-proxy=false
![img_2.png](task-03/img_2.png)
![img_3.png](task-03/img_3.png)

![img_4.png](task-03/img_4.png)
- мы перенастроили nginx на прослушивание 81 порта, а сам контейнер запущен на 80 порту

?
- для исправления ситуации без удаления контейнера необходимо все запросы на 81 порт перенаправить на 80