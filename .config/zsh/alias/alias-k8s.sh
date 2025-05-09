alias k=kubectl
alias kc="kubie ctx"
alias kn="kubie ns"

alias kget="k get deploy,pod,svc,sa,ingress,secrets"
alias kev="k get events --sort-by='.lastTimestamp'"

kl() {
  local pod_index
  
  if [[ -z "$1" ]]; then
    echo "Usage: getpodlogs <partial-pod-name> <pod-index>"
    return 1
  fi

  local partial="$1"
  local pod_index="${2:-1}"
  local pod_count=$(kubectl get pods --no-headers | wc -l)
  local ctx="$(kubectl config current-context)"
  local ns="$(kubectl config view --minify --output 'jsonpath={..namespace}')"
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep $partial | head -n $pod_index | tail -n 1) 

  echo $pod

  if [[ -z "$pod" ]]; then
    echo "No pod found with name containing '$partial:$pod_index' in namespace: '$ns' context: $ctx"
  else 
    echo "Fetching logs from pod: '$pod' idx:'$pod_index' in namespace: '$ns' context: '$ctx'"
  fi
  
  kubectl logs $pod
}
