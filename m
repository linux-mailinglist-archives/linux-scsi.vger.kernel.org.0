Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B936288FD6
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Oct 2020 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgJIROm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Oct 2020 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbgJIROl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Oct 2020 13:14:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4DC0613D2
        for <linux-scsi@vger.kernel.org>; Fri,  9 Oct 2020 10:14:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so7672718pgm.11
        for <linux-scsi@vger.kernel.org>; Fri, 09 Oct 2020 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGYTL7e7hWPNpPBMuCFjK2oCzyBFX8ZeZUCYsIrxqUA=;
        b=EOwgXBYYjD6hVkpWG4NTrjB0jh/8ms916uuvlckl6rDLm1cTDttPjZ0HfYoZCCTDQu
         qQSlqskVohu9VIyuvQ6eTxczAjx1ul87pHeZuLbttIb+2VEGpjW8/iD/MeWb8PRpW0fP
         Gs2lVR3OE22hIA/PwsbyY1L3H2fgwhyiVsGHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGYTL7e7hWPNpPBMuCFjK2oCzyBFX8ZeZUCYsIrxqUA=;
        b=JoEwm+emxkxaX7cH04H01Bk8OZF25CmOGrxavmN9gOG9ok9FDrf2apri7LtnfEarUM
         Faq4ZcG+zy2xhsSSOD6TsOClt7jC3M/F3wfoGNkQfQACEZynWdRL7BJiD+Irsbr5WKnz
         7EQ+XZNAaP9/83Aq7gS/monBFGP2Kdz3VJYvipLeu8MByBPur/Tw0aa7dHWAxWrg7fYC
         1aeeP6LxnRPQxthldrjTlBVGGvL95DCLKc/OhkIYZpYt4vcBJ7z91k01lLSsxzArT4FC
         skAsyCL1o7Uy00fBM40gcwA3lBOIYTcWdYNuLphc8z2w4YkcsG1lHCw/sTtTDdmUpDEr
         gm4A==
X-Gm-Message-State: AOAM532KYBeShKYbQI7nfJpTx7J0svkNXScZVgcwjFJjwWufvDN+PZR0
        L+6Cz0lzXJmyxyThI5kBXOTxpw==
X-Google-Smtp-Source: ABdhPJwDFFKycnpDEK1rvJmU2uawQf45CrBPaVwdSvqMkkgQ2XGDDjG0N644XZ9YclJ1+MuC72es0w==
X-Received: by 2002:a17:90a:c683:: with SMTP id n3mr5641919pjt.163.1602263680704;
        Fri, 09 Oct 2020 10:14:40 -0700 (PDT)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id fy24sm12299055pjb.35.2020.10.09.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:14:40 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 09/14] mpt3sas: Set valid PhysicalPort in SMPPassThrough
Date:   Fri,  9 Oct 2020 22:44:35 +0530
Message-Id: <20201009171440.4949-10-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
References: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008c775a05b1401582"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000008c775a05b1401582

Current driver is always setting PhysicalPort field as 0xFF for
SMPPassthrough Request message. So in zoning topologies this
SMPPassthrough command always operates on devices in one zone
(default zone) even when user issues SMP command for other zone
drives.

Now helper functions _transport_get_port_id_by_rphy() &
_transport_get_port_id_by_sas_phy() are defined to get Physical
Port number from sas_rphy & sas_phy respectively for
SMPPassthrough request message so that SMP Passthrough request
message is send to intended zone device.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  2 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     |  1 +
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 75 ++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 047d234..a8e42d1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -788,6 +788,7 @@ struct _sas_phy {
  * @phy: a list of phys that make up this sas_host/expander
  * @sas_port_list: list of ports attached to this sas_host/expander
  * @port: hba port entry containing node's port number info
+ * @rphy: sas_rphy object of this expander
  */
 struct _sas_node {
 	struct list_head list;
@@ -802,6 +803,7 @@ struct _sas_node {
 	struct hba_port *port;
 	struct	_sas_phy *phy;
 	struct list_head sas_port_list;
+	struct sas_rphy *rphy;
 };
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 05d43c4..855d1ec 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -6509,6 +6509,7 @@ _scsih_expander_add(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 		goto out_fail;
 	}
 	sas_expander->parent_dev = &mpt3sas_port->rphy->dev;
+	sas_expander->rphy = mpt3sas_port->rphy;
 
 	for (i = 0 ; i < sas_expander->num_phys ; i++) {
 		if ((mpt3sas_config_get_expander_pg1(ioc, &mpi_reply,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 3cc78c2..d52d8b3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -60,6 +60,24 @@
 
 #include "mpt3sas_base.h"
 
+/**
+ * _transport_get_port_id_by_sas_phy - get zone's port id that Phy belong to
+ * @phy - sas_phy object
+ *
+ * Return Port number
+ */
+static inline u8
+_transport_get_port_id_by_sas_phy(struct sas_phy *phy)
+{
+	u8 port_id = 0xFF;
+	struct hba_port *port = phy->hostdata;
+
+	if (port)
+		port_id = port->port_id;
+
+	return port_id;
+}
+
 /**
  * _transport_sas_node_find_by_sas_address - sas node search
  * @ioc: per adapter object
@@ -81,6 +99,49 @@ _transport_sas_node_find_by_sas_address(struct MPT3SAS_ADAPTER *ioc,
 		    sas_address, port);
 }
 
+/**
+ * _transport_get_port_id_by_rphy - Get Port number from rphy object
+ * @ioc: per adapter object
+ * @rphy: sas_rphy object
+ *
+ * Returns Port number.
+ */
+static u8
+_transport_get_port_id_by_rphy(struct MPT3SAS_ADAPTER *ioc,
+	struct sas_rphy *rphy)
+{
+	struct _sas_node *sas_expander;
+	struct _sas_device *sas_device;
+	unsigned long flags;
+	u8 port_id = 0xFF;
+
+	if (!rphy)
+		return port_id;
+
+	if (rphy->identify.device_type == SAS_EDGE_EXPANDER_DEVICE ||
+	    rphy->identify.device_type == SAS_FANOUT_EXPANDER_DEVICE) {
+		spin_lock_irqsave(&ioc->sas_node_lock, flags);
+		list_for_each_entry(sas_expander,
+		    &ioc->sas_expander_list, list) {
+			if (sas_expander->rphy == rphy) {
+				port_id = sas_expander->port->port_id;
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&ioc->sas_node_lock, flags);
+	} else if (rphy->identify.device_type == SAS_END_DEVICE) {
+		spin_lock_irqsave(&ioc->sas_device_lock, flags);
+		sas_device = __mpt3sas_get_sdev_by_rphy(ioc, rphy);
+		if (sas_device) {
+			port_id = sas_device->port->port_id;
+			sas_device_put(sas_device);
+		}
+		spin_unlock_irqrestore(&ioc->sas_device_lock, flags);
+	}
+
+	return port_id;
+}
+
 /**
  * _transport_convert_phy_link_rate -
  * @link_rate: link rate returned from mpt firmware
@@ -289,7 +350,7 @@ struct rep_manu_reply {
  */
 static int
 _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
-	u64 sas_address, struct sas_expander_device *edev)
+	u64 sas_address, struct sas_expander_device *edev, u8 port_id)
 {
 	Mpi2SmpPassthroughRequest_t *mpi_request;
 	Mpi2SmpPassthroughReply_t *mpi_reply;
@@ -356,7 +417,7 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 
 	memset(mpi_request, 0, sizeof(Mpi2SmpPassthroughRequest_t));
 	mpi_request->Function = MPI2_FUNCTION_SMP_PASSTHROUGH;
-	mpi_request->PhysicalPort = 0xFF;
+	mpi_request->PhysicalPort = port_id;
 	mpi_request->SASAddress = cpu_to_le64(sas_address);
 	mpi_request->RequestDataLength = cpu_to_le16(data_out_sz);
 	psge = &mpi_request->SGL;
@@ -772,7 +833,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
 	    MPI2_SAS_DEVICE_INFO_FANOUT_EXPANDER)
 		_transport_expander_report_manufacture(ioc,
 		    mpt3sas_port->remote_identify.sas_address,
-		    rphy_to_expander_device(rphy));
+		    rphy_to_expander_device(rphy), hba_port->port_id);
 	return mpt3sas_port;
 
  out_fail:
@@ -923,6 +984,7 @@ mpt3sas_transport_add_host_phy(struct MPT3SAS_ADAPTER *ioc, struct _sas_phy
 	    phy_pg0.ProgrammedLinkRate & MPI2_SAS_PRATE_MIN_RATE_MASK);
 	phy->maximum_linkrate = _transport_convert_phy_link_rate(
 	    phy_pg0.ProgrammedLinkRate >> 4);
+	phy->hostdata = mpt3sas_phy->port;
 
 	if ((sas_phy_add(phy))) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -993,6 +1055,7 @@ mpt3sas_transport_add_expander_phy(struct MPT3SAS_ADAPTER *ioc, struct _sas_phy
 	    expander_pg1.ProgrammedLinkRate & MPI2_SAS_PRATE_MIN_RATE_MASK);
 	phy->maximum_linkrate = _transport_convert_phy_link_rate(
 	    expander_pg1.ProgrammedLinkRate >> 4);
+	phy->hostdata = mpt3sas_phy->port;
 
 	if ((sas_phy_add(phy))) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -1197,7 +1260,7 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 
 	memset(mpi_request, 0, sizeof(Mpi2SmpPassthroughRequest_t));
 	mpi_request->Function = MPI2_FUNCTION_SMP_PASSTHROUGH;
-	mpi_request->PhysicalPort = 0xFF;
+	mpi_request->PhysicalPort = _transport_get_port_id_by_sas_phy(phy);
 	mpi_request->VF_ID = 0; /* TODO */
 	mpi_request->VP_ID = 0;
 	mpi_request->SASAddress = cpu_to_le64(phy->identify.sas_address);
@@ -1493,7 +1556,7 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 
 	memset(mpi_request, 0, sizeof(Mpi2SmpPassthroughRequest_t));
 	mpi_request->Function = MPI2_FUNCTION_SMP_PASSTHROUGH;
-	mpi_request->PhysicalPort = 0xFF;
+	mpi_request->PhysicalPort = _transport_get_port_id_by_sas_phy(phy);
 	mpi_request->VF_ID = 0; /* TODO */
 	mpi_request->VP_ID = 0;
 	mpi_request->SASAddress = cpu_to_le64(phy->identify.sas_address);
@@ -1983,7 +2046,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 
 	memset(mpi_request, 0, sizeof(Mpi2SmpPassthroughRequest_t));
 	mpi_request->Function = MPI2_FUNCTION_SMP_PASSTHROUGH;
-	mpi_request->PhysicalPort = 0xFF;
+	mpi_request->PhysicalPort = _transport_get_port_id_by_rphy(ioc, rphy);
 	mpi_request->SASAddress = (rphy) ?
 	    cpu_to_le64(rphy->identify.sas_address) :
 	    cpu_to_le64(ioc->sas_hba.sas_address);
-- 
2.18.4


--0000000000008c775a05b1401582
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Rag/s/0IKyxAQsoBcla5ZufuDE5ir/mlnYktkPJdg+kns/OPDsINSyWqNYE9PKy9+3cp/fItNFtH
krg1AgMBAAGjggHTMIIBzzAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsG
AQUFBzAChkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2ln
bjJzaGEyZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29t
L2dzcGVyc29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEF
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBE
BgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWdu
MnNoYTJnMy5jcmwwJwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4E
FgQU1CyhXqcQo40SZ7kFS/AiOnRW6lMwDQYJKoZIhvcNAQELBQADggEBAFeMmmz112eNFAV8Ense
5WremClV5F3Md1xS0yXKqxlgakUJaOI/Fai7OLQaQqsEoxW6/QqWEi1wbZOccbdritOkL5b7sVUp
SU9OfuIlV8c3XMLaWSIluy+0ImtRJ49jDCI4KtQESHrqfQRZcc1C/avZvNED3U4b10U6N3SY+59b
fm2Vlwacwp+8ESTp49DsLcJqc4U/0rUZxLWtgPokzS+ovX+JAu8zx1SmOzUC4hj4Bp6Vnfd5KWUK
JJQBmQHXii+acSeTgHmPWUYs3tYQ0uIX0Yy8LUWPdGbEq+KWepzY2otC+iVWdngCCv8Nf1Xo1jki
AGJ6hrlWFE0qJVWv25sxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hB
MjU2IC0gRzMCDBmG1a14/wFg8qBhUjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
yHTOiKEtbUG49s6pFu/clEbw+eWPKYv/mSMLQB7xP9MwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjAxMDA5MTcxNDQxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFCJKU0fGwMVmUezd1bj
Zl7ejb+MO7KIXVEbCdWl9vdsly5BUyvuIHVPFblcCsC463RAKQqGmLI/OfiG1fQYz56Y4wgHPGFC
5LE4e7UYW7iSKjOwVj7K2f7bjpKzDtfJGB1+XWU/SNporKhO3CixJ5dIA+PvZ3NM1lPJ0skhTLOL
hLFcd1bL3XB386XFRU7L3QUJvA7J9+rV9LqTwqALcJ17cSBuoOLuiM1g3ohDz/NLtSDrHJJkO4gB
k3Sb5XuY2l3b3T7sX7dnijJ8+T4/VH+HLN8Xbp6y2TlQ21yWha82dx3Wxov+XZ7v4fkahmjyRI3u
FeoHYUxsRE/3g6pX7aA=
--0000000000008c775a05b1401582--
