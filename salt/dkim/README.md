# DKIM

Podepisování odeslaných mailů

> opendkim-genkey --domain=example.cz --selector=selectorName --verbose

> selectorName._domainkey TXT v=DKIM1; k=rsa; p=[Key Data Here]
