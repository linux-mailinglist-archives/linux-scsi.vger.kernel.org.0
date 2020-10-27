Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51DD29ACD3
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 14:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbgJ0NIl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Oct 2020 09:08:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbgJ0NIl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Oct 2020 09:08:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so745118pgd.12
        for <linux-scsi@vger.kernel.org>; Tue, 27 Oct 2020 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hfqCKRckxrrzOwggH/TOoty5GuNnaDCeUHf8tUcMNjQ=;
        b=fZsA3uBBte8o59It44IPXQ88CgRSqlgE784gkz94HxGMau4atho2iokkxCW7lY2l7R
         GCf1sNydZT7T3B7GmmRp/DiSttSEz74jvRlVVokYCDWWVhHsEtBRc1znkXdkNLegseZ1
         oa9YCT4PMcHtADE2N0RDBeFHmPcqr2UTGsPSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hfqCKRckxrrzOwggH/TOoty5GuNnaDCeUHf8tUcMNjQ=;
        b=TNk5PIe6uQLk61HnpZAajpEpGVEFKQkzmV5FTV6YfniXIIGpeMRE2/33usrCezeGBT
         /UX/4DSI2uQrpeJlq4vyoq9QvnRBR8PU69gnnFP/h2kzvCL11WABJRxY+Vwr/dAhxS3V
         I5Rwlkr4xOVSx3WqxD4Xd7Ls1afOYbHz7z5F60d6pzPPrYCmlh1NHthDJ9Ow7W+Cuaju
         uIdofQI0jvoZftnNrUXUZzIz72p3U7yVf4DDoF6g2a9+xwmHz+Sw5ztxvE1wrLNBVQCy
         zd5jNPi67wSa9Be6AU5YvYXv7Gj0za2Mc3AeRP04LnBgHjT84Orqbbzq5IFeRV0eHGfy
         h0cg==
X-Gm-Message-State: AOAM532xGwufJT9w6tI9TtD799kH4jxe3Xwio27fGZw94/+U7enTLsKw
        qxyUVbPHjtVeVqIrGZJj1XI6OQ==
X-Google-Smtp-Source: ABdhPJy+e5igyUqq7cNuQBUdgYGfOnVYozCJrRP0i1zHQJ0egQO8MzfEWNpfecipjpe4w4CFsHm4pg==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr1883905pgm.289.1603804119810;
        Tue, 27 Oct 2020 06:08:39 -0700 (PDT)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b24sm2009319pge.59.2020.10.27.06.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:08:39 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH v1 07/14] mpt3sas: Get sas_device objects using device's rphy
Date:   Tue, 27 Oct 2020 18:38:40 +0530
Message-Id: <20201027130847.9962-8-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201027130847.9962-1-sreekanth.reddy@broadcom.com>
References: <20201027130847.9962-1-sreekanth.reddy@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e0cfb905b2a6be12"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000e0cfb905b2a6be12

In below scsi_host_template & sas_function_template callback
functions, the driver won't have PhysicalPort number information
to retrieve the sas_device object using SAS Address & PhysicalPort
number. So, in these callback functions the device's rphy
object is used to retrieve sas_device object for the device.

.target_alloc,
.get_enclosure_identifier
.get_bay_identifier

When a rphy (of type sas_rphy) object is allocated then it's
address is saved in corresponding sas_device object's rphy
field. so in __mpt3sas_get_sdev_by_rphy(), driver loops over
all the sas_device objects from sas_device_list list to
retrieve the sas_device objects who's rphy matches with
provided rphy.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
v1:
No change.

 drivers/scsi/mpt3sas/mpt3sas_base.h      |  5 +++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 41 ++++++++++++++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  7 ++--
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 24db627..047d234 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -537,6 +537,8 @@ struct _internal_cmd {
  * @chassis_slot: chassis slot
  * @is_chassis_slot_valid: chassis slot valid or not
  * @port: hba port entry containing device's port number info
+ * @rphy: device's sas_rphy address used to identify this device structure in
+ *	target_alloc callback function
  */
 struct _sas_device {
 	struct list_head list;
@@ -564,6 +566,7 @@ struct _sas_device {
 	u8	connector_name[5];
 	struct kref refcount;
 	struct hba_port *port;
+	struct sas_rphy *rphy;
 };
 
 static inline void sas_device_get(struct _sas_device *s)
@@ -1681,6 +1684,8 @@ void mpt3sas_port_enable_complete(struct MPT3SAS_ADAPTER *ioc);
 struct _raid_device *
 mpt3sas_raid_device_find_by_handle(struct MPT3SAS_ADAPTER *ioc, u16 handle);
 void mpt3sas_scsih_change_queue_depth(struct scsi_device *sdev, int qdepth);
+struct _sas_device *
+__mpt3sas_get_sdev_by_rphy(struct MPT3SAS_ADAPTER *ioc, struct sas_rphy *rphy);
 
 /* config shared API */
 u8 mpt3sas_config_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 4542d66..afb381d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -638,6 +638,44 @@ mpt3sas_get_pdev_from_target(struct MPT3SAS_ADAPTER *ioc,
 	return ret;
 }
 
+
+/**
+ * __mpt3sas_get_sdev_by_rphy - sas device search
+ * @ioc: per adapter object
+ * @rphy: sas_rphy pointer
+ *
+ * Context: This function will acquire ioc->sas_device_lock and will release
+ * before returning the sas_device object.
+ *
+ * This searches for sas_device from rphy object
+ * then return sas_device object.
+ */
+struct _sas_device *
+__mpt3sas_get_sdev_by_rphy(struct MPT3SAS_ADAPTER *ioc,
+	struct sas_rphy *rphy)
+{
+	struct _sas_device *sas_device;
+
+	assert_spin_locked(&ioc->sas_device_lock);
+
+	list_for_each_entry(sas_device, &ioc->sas_device_list, list) {
+		if (sas_device->rphy != rphy)
+			continue;
+		sas_device_get(sas_device);
+		return sas_device;
+	}
+
+	sas_device = NULL;
+	list_for_each_entry(sas_device, &ioc->sas_device_init_list, list) {
+		if (sas_device->rphy != rphy)
+			continue;
+		sas_device_get(sas_device);
+		return sas_device;
+	}
+
+	return NULL;
+}
+
 /**
  * mpt3sas_get_sdev_by_addr - get _sas_device object corresponding to provided
  *				sas address from sas_device_list list
@@ -1815,8 +1853,7 @@ scsih_target_alloc(struct scsi_target *starget)
 	/* sas/sata devices */
 	spin_lock_irqsave(&ioc->sas_device_lock, flags);
 	rphy = dev_to_rphy(starget->dev.parent);
-	sas_device = __mpt3sas_get_sdev_by_addr(ioc,
-	   rphy->identify.sas_address, NULL);
+	sas_device = __mpt3sas_get_sdev_by_rphy(ioc, rphy);
 
 	if (sas_device) {
 		sas_target_priv_data->handle = sas_device->handle;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 560ce32..3cc78c2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -733,6 +733,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
 	mpt3sas_port->port = port;
 	if (mpt3sas_port->remote_identify.device_type == SAS_END_DEVICE) {
 		rphy = sas_end_device_alloc(port);
+		sas_device->rphy = rphy;
 		if (sas_node->handle <= ioc->sas_hba.num_phys)
 			hba_port->sas_address = sas_device->sas_address;
 	} else {
@@ -1342,8 +1343,7 @@ _transport_get_enclosure_identifier(struct sas_rphy *rphy, u64 *identifier)
 	int rc;
 
 	spin_lock_irqsave(&ioc->sas_device_lock, flags);
-	sas_device = __mpt3sas_get_sdev_by_addr(ioc,
-	    rphy->identify.sas_address, 0);
+	sas_device = __mpt3sas_get_sdev_by_rphy(ioc, rphy);
 	if (sas_device) {
 		*identifier = sas_device->enclosure_logical_id;
 		rc = 0;
@@ -1372,8 +1372,7 @@ _transport_get_bay_identifier(struct sas_rphy *rphy)
 	int rc;
 
 	spin_lock_irqsave(&ioc->sas_device_lock, flags);
-	sas_device = __mpt3sas_get_sdev_by_addr(ioc,
-	    rphy->identify.sas_address, 0);
+	sas_device = __mpt3sas_get_sdev_by_rphy(ioc, rphy);
 	if (sas_device) {
 		rc = sas_device->slot;
 		sas_device_put(sas_device);
-- 
2.18.4


--000000000000e0cfb905b2a6be12
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
REjfKITQ1lMFLuSrkFudrVVNbuHNrpZFRTaGmTYdOskwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjAxMDI3MTMwODQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGNcTSY0HE04Kd/JkF7U
wBknXjZYpHtbGbYNn7/RxlHVa95tiFE2BxCk5Iq/9V3WYUp5KaO6O+uao8ZtJeMaZbOdyouNJOdd
vGYgcEjf8dci+o3f7/2vIU7AWppHsr38L29Gx+xfgYJOfsVXAE5m4iMJIMwBx/c7R4Ia+JseiKrG
/070F+05evIp4SWxCB51W9M9dihRMHwbk8MmTCtbwOoqiMavjjVvZxejKNLwtQSgIeneHMwOaYbL
rFZm8iau3aC44BZWn8c0yBQGFG+G6n9c2hhxA24Ls63eha7MuJenZQbq9ISRVb7njDhdZdyGzqA2
6UZlN7pEKf5JY/FmsvA=
--000000000000e0cfb905b2a6be12--
