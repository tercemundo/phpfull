apt install mysql-client-core-8.0

apt -y install socat
kubectl expose deploy mariadb --type=ClusterIP

#Chequeo si existe el fwd

sleep 5

SALIDA=$(fuser -n tcp 3306)
if [ -n "$SALIDA" ]
then
        PID=$(netstat -natup | grep 3306 | grep kubectl | tail -1 | awk '{print $NF}' | awk -F/ '{print $1}')
        echo "el pid  $PID corresponde a un forward, lo matamos"
        kill -9 $PID

fi


POD=$(kubectl get pod | grep mariadb | awk '{print $1}')
nohup kubectl port-forward $POD 3306:3306 &




