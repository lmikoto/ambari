TYPE=single-container
BLUEPRINT=blueprints/single-container.json

OS=redhat6
HDP_VERSION=2.6
AMBARI_HOST=localhost:8080
BASE_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.2.0

curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/blueprints/$TYPE --data-binary "@$BLUEPRINT"
curl --user admin:admin -H 'X-Requested-By:admin' -X PUT $AMBARI_HOST/api/v1/stacks/HDP/versions/$HDP_VERSION/operating_systems/$OS/repositories/HDP-${HDP_VERSION} -d '{"Repositories":{"base_url":"'$BASE_URL'", "verify_base_url":true}}'
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/clusters/dev --data-binary "@hostgroups/$TYPE.json"
