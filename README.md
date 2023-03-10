# simple-ComputeEngine.tf

ðµï¸ðµï¸ðµï¸ Terraformã§GCPä¸ã«`Compute Engine`ãç«ã¡ä¸ãããµã³ãã«ã§ãã  

![ææç©](./docs/img/fruit.gif)  

## ç°å¢æå ±

| Name | Version |
| ---- | ---- |
| terraform | v1.3.7 |
| Google Cloud SDK | 418.0.0 |

## å®è¡æ¹æ³

`terraform.tfvars.example`ãã³ãã¼ãã¦`terraform.tfvars`ãä½æããé©åãªå¤ãè¨­å®ãã¦ãã ããã  

```shell
terraform init
terraform plan
terraform apply
```

ãªã½ã¼ã¹ãåé¤ããå ´åã¯ä»¥ä¸ã®ã³ãã³ããå®è¡ãã¦ãã ããã  

```shell
terraform destroy
```

## ãã®ä»ã¤ã­ã¤ã­

ãã¡ã¤ã¢ã¦ã©ã¼ã«ã«ã¼ã«ã¯ä»¥ä¸ã®éãã§ãã  

* ã¤ã³ãã¦ã³ãéä¿¡ã¯SSH(22)ã»HTTP(80)ã»HTTPS(443)ã®ã¿è¨±å¯
* SSHã¯èªåã®IPã¢ãã¬ã¹ã®ã¿è¨±å¯
* ã¢ã¦ããã¦ã³ãéä¿¡ã¯å¨ã¦è¨±å¯

## åç¨®è¨­å®

### Terraform

[å¬å¼ãµã¤ã](https://developer.hashicorp.com/terraform/downloads)ã«ãã£ã¦ãTerraformããã¦ã³ã­ã¼ããã¦ãã ããã  
ã¤ã³ã¹ãã¼ã«å¾ã¯ãä»¥ä¸ã®ã³ãã³ããå®è¡ãã¦ãTerraformã®ãã¼ã¸ã§ã³ãç¢ºèªãã¦ãã ããã  

```shell
terraform version
```

æ­£ããã¤ã³ã¹ãã¼ã«ããã¦ããªãå ´åã«ã¯ããã¹ãéã£ã¦ããªãå¯è½æ§ãããã¾ãã  
ãã¹ãéã£ã¦ããªãå ´åã¯ãä»¥ä¸ã®ã³ãã³ããå®è¡ãã¦ããã¹ãéãã¦ãã ããã  

```shell
# Windows
$env:PATH += ";C:/âãã¹â"

# Unixç³»
export PATH=$PATH:/âãã¹â
```

### GCPã®è¨­å®

[ãã­ã¸ã§ã¯ã ã»ã¬ã¯ã¿ã«ç§»å](https://console.cloud.google.com/projectselector2/home/dashboard?hl=ja)ãããå¯¾è±¡ã®ãã­ã¸ã§ã¯ããé¸æãã¾ãã  

æ¬¡ã«ã[IAMãã¼ã¸](https://console.cloud.google.com/iam-admin/iam?hl=ja)ãããä»¥ä¸ã®æ¨©éãä»ä¸ããã¦ãããã¨ãç¢ºèªãã¦ãã ããã  

* compute.instance.*
* compute.firewalls.*

æå¾ã«[API ãæå¹ã«ãã](https://console.cloud.google.com/flows/enableapi?apiid=compute.googleapis.com&hl=ja)ããã`Compute Engine API`ãæå¹ã«ãã¦ãã ããã  

### gcloud CLI

[å¬å¼ãµã¤ã](https://learn.microsoft.com/ja-jp/cli/azure/install-azure-cli)ã«ãã£ã¦ãgcloud CLIãã¤ã³ã¹ãã¼ã«ãã¦ãã ããã  
Windowsã¦ã¼ã¶ã¯ä»¥ä¸ã®ã³ãã³ããå®è¡ããã°OKã§ãã  

```powershell
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe") & $env:Temp\GoogleCloudSDKInstaller.exe
```

```shell
# ã­ã°ã¤ã³
gcloud auth login

# ãã­ã¸ã§ã¯ãã®å¤æ´
gcloud config set project PROJECT_ID
```

## åèæç®

* [Google (Terraform)](https://cloud.google.com/docs/terraform?hl=ja)
