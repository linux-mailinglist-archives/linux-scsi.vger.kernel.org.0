Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D754BCBF1
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Feb 2022 04:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbiBTDTc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Feb 2022 22:19:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiBTDT3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Feb 2022 22:19:29 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031C340D4
        for <linux-scsi@vger.kernel.org>; Sat, 19 Feb 2022 19:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645327135; x=1676863135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGTIk9a9W86uP2S6P+cS9aSUW2EM1MAfKsxYZSQSKjY=;
  b=mQn6K8TAv/9xgqrmSO/njXmyUkuW/s/Q8ZdvS+kcQVJD4PCdg48nvxtD
   67BD06/0p2trDQ1ATUaLru65dcB11OMZa2F6sH7yPc7WcO5Q6CVTfzR8u
   nhc2LohfVSmTgMb+w3W+9Cmwjw0zneREYJMg6cOY+27DH585maau95DbL
   9YsnOk98wH8wuLEgfKll5EdCxZs7cryvvc4mNaLENGH4e2V9gZoux6Hvn
   MyhSJLsjPdsLA+vLhnXb5A4mjIAHAIpfwkrNg1gYIDJk81/p5vHGuTP0B
   K8cxkXJUmUqFWX+0q0yWenxeQTWTnRAd1XA1sE0JQo1fWE2GfzkBgsOba
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,382,1635177600"; 
   d="scan'208";a="193405820"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2022 11:18:54 +0800
IronPort-SDR: hPqGTPx7Ceq7LPF1ZbhxgYvKY5jeaoQQzsnfRPZS7ewObX6zj2j7CDpHjk5xJxzVvuQJIzhADG
 gCEnHeQP2Mg6ZUkjoHsOy/VoZUgxwDzASthV6NLh6DuZ1evfgPUo32SHsAGES2ylwLtk+Mjdm7
 QhJBvorW2L5hGW3NpGb4YZTaLyQD0ZCUR2LWcaEDjANwcT/0P8oH70p427V/7Pc3TFcTM8Dl1s
 uXAYN4Lnf/LJnSWKgSfnpFLzKLhgixhQJWhJXgOXW8iZTr4PgqekiZFCc+aAp8t5c7dLhPa3mh
 CLSnr1wtG4SiyXb9Vs9VoEhv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 18:50:30 -0800
IronPort-SDR: ofSo6ynMXZjZpDvABLVGXsOqRaEys5YbBObh3Bdfr/EBGCzb33SRJz59HskWem2vLlS4XHJcK0
 7Ad7HWRe4rtWJdp4oxaOGFONWptN6rPJRfw5vkD9JC6oveKjeR7TsX+D/yKRb55F03Lntn7ZZ3
 rOJEkyxXOJsAZdlmmOnPcgS4EP+9aZtuodZx/yemrJZ1BZMY3Kxd4V1HS6jMPvoKRTK1MmbzYm
 pQ0bNb+A+oP+HfAHXpnA0GyC6Uk3H8fVoZ42zxTUv/VnIaMFBqeHh8jXpRn5JDFCg09mSFncSt
 Wgo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 19:18:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K1VyP4f1lz1SVp4
        for <linux-scsi@vger.kernel.org>; Sat, 19 Feb 2022 19:18:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1645327131; x=1647919132; bh=JGTIk9a9W86uP2S6P+
        cS9aSUW2EM1MAfKsxYZSQSKjY=; b=NzgalUnMtlUErHfCapI3Z2LAvy2U6tccE4
        JVCm35vzalRiXAt83UD1XI+FkZU57YnipRwgCz6Oh1PjdfRHGu8oFDTzqv0mLGjr
        7/NO+w2OTYTkgkUUe6IjOdk6T1MOTfYvIyzabCqJpgh9ESNKfErOx6YY+mfQe0XI
        vYiwTou+qqefyAJNV2PluuxCBGxEl7bsOS0bR4ErygLea05JFHJ5BMaTggzup8OJ
        qUfMfyuHhE7P3sEFpNA3IwOlF96nmCltKoIDgPBLC4hx55/HsXSyWw3xXxZQHoL0
        cZ74Wbga2w2o61YB5F6OdM9w4uMvCSDtB3HKgNV249kfi4QplvkQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GYEwhzq2GW8m for <linux-scsi@vger.kernel.org>;
        Sat, 19 Feb 2022 19:18:51 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K1VyL1372z1Rvlx;
        Sat, 19 Feb 2022 19:18:49 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        John Garry <john.garry@huawei.com>
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        Luo Jiaxing <luojiaxing@huawei.com>
Subject: [PATCH v6 26/31] scsi: pm8001: Introduce ccb alloc/free helpers
Date:   Sun, 20 Feb 2022 12:18:05 +0900
Message-Id: <20220220031810.738362-27-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220031810.738362-1-damien.lemoal@opensource.wdc.com>
References: <20220220031810.738362-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce the pm8001_ccb_alloc() and pm8001_ccb_free() helpers to
replace the typical code patterns:

	res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
	if (res)
		...
	ccb =3D &pm8001_ha->ccb_info[ccb_tag];
	ccb->device =3D pm8001_ha_dev;
	ccb->ccb_tag =3D ccb_tag;
	ccb->task =3D task;
	ccb->n_elem =3D 0;

and

	ccb->task =3D NULL;
	ccb->ccb_tag =3D PM8001_INVALID_TAG;
	pm8001_tag_free(pm8001_ha, tag);

With the simpler function calls:

	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
	if (!ccb)
		...

and

	pm8001_ccb_free(pm8001_ha, ccb);

The pm8001_ccb_alloc() helper ensures that all fields of the ccb info
structure for the newly allocated tag are all initialized, except the
buf_prd field. The pm8001_ccb_free() helper clears the initialized
fields and the ccb tag to ensure that iteration over the adapter
ccb_info array detects ccbs that are in use.

All call site of the pm8001_tag_alloc() function that use a ccb info
associated with an allocated tag are converted to use the new helpers.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 180 +++++++++++++------------------
 drivers/scsi/pm8001/pm8001_sas.c |  46 ++++----
 drivers/scsi/pm8001/pm8001_sas.h |  47 ++++++++
 drivers/scsi/pm8001/pm80xx_hwi.c |  64 +++++------
 4 files changed, 166 insertions(+), 171 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm800=
1_hwi.c
index 14bc4f88c6e6..d45765aac148 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1710,7 +1710,7 @@ void pm8001_work_fn(struct work_struct *work)
 					pm8001_dev->dcompletion =3D NULL;
 				}
 				complete(pm8001_ha->nvmd_completion);
-				pm8001_tag_free(pm8001_ha, ccb->ccb_tag);
+				pm8001_ccb_free(pm8001_ha, ccb);
 			}
 		}
 		/* Deregister all the device ids  */
@@ -1749,8 +1749,6 @@ int pm8001_handle_event(struct pm8001_hba_info *pm8=
001_ha, void *data,
 static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 		struct pm8001_device *pm8001_ha_dev)
 {
-	int res;
-	u32 ccb_tag;
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task =3D NULL;
 	struct task_abort_req task_abort;
@@ -1771,32 +1769,25 @@ static void pm8001_send_abort_all(struct pm8001_h=
ba_info *pm8001_ha,
=20
 	task->task_done =3D pm8001_task_done;
=20
-	res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res) {
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
+	if (!ccb) {
 		sas_free_task(task);
 		return;
 	}
=20
-	ccb =3D &pm8001_ha->ccb_info[ccb_tag];
-	ccb->device =3D pm8001_ha_dev;
-	ccb->ccb_tag =3D ccb_tag;
-	ccb->task =3D task;
-	ccb->n_elem =3D 0;
-
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
=20
 	memset(&task_abort, 0, sizeof(task_abort));
 	task_abort.abort_all =3D cpu_to_le32(1);
 	task_abort.device_id =3D cpu_to_le32(pm8001_ha_dev->device_id);
-	task_abort.tag =3D cpu_to_le32(ccb_tag);
+	task_abort.tag =3D cpu_to_le32(ccb->ccb_tag);
=20
 	ret =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
 	if (ret) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 	}
-
 }
=20
 static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
@@ -1804,7 +1795,6 @@ static void pm8001_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 {
 	struct sata_start_req sata_cmd;
 	int res;
-	u32 ccb_tag;
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task =3D NULL;
 	struct host_to_dev_fis fis;
@@ -1820,20 +1810,13 @@ static void pm8001_send_read_log(struct pm8001_hb=
a_info *pm8001_ha,
 	}
 	task->task_done =3D pm8001_task_done;
=20
-	res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res) {
-		sas_free_task(task);
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate tag !!!\n");
-		return;
-	}
-
-	/* allocate domain device by ourselves as libsas
-	 * is not going to provide any
-	*/
+	/*
+	 * Allocate domain device by ourselves as libsas is not going to
+	 * provide any.
+	 */
 	dev =3D kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
 	if (!dev) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
 		pm8001_dbg(pm8001_ha, FAIL,
 			   "Domain device cannot be allocated\n");
 		return;
@@ -1841,11 +1824,13 @@ static void pm8001_send_read_log(struct pm8001_hb=
a_info *pm8001_ha,
 	task->dev =3D dev;
 	task->dev->lldd_dev =3D pm8001_ha_dev;
=20
-	ccb =3D &pm8001_ha->ccb_info[ccb_tag];
-	ccb->device =3D pm8001_ha_dev;
-	ccb->ccb_tag =3D ccb_tag;
-	ccb->task =3D task;
-	ccb->n_elem =3D 0;
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
+	if (!ccb) {
+		sas_free_task(task);
+		kfree(dev);
+		return;
+	}
+
 	pm8001_ha_dev->id |=3D NCQ_READ_LOG_FLAG;
 	pm8001_ha_dev->id |=3D NCQ_2ND_RLE_FLAG;
=20
@@ -1860,7 +1845,7 @@ static void pm8001_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 	fis.lbal =3D 0x10;
 	fis.sector_count =3D 0x1;
=20
-	sata_cmd.tag =3D cpu_to_le32(ccb_tag);
+	sata_cmd.tag =3D cpu_to_le32(ccb->ccb_tag);
 	sata_cmd.device_id =3D cpu_to_le32(pm8001_ha_dev->device_id);
 	sata_cmd.ncqtag_atap_dir_m =3D cpu_to_le32((0x1 << 7) | (0x5 << 9));
 	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
@@ -1869,7 +1854,7 @@ static void pm8001_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 			sizeof(sata_cmd), 0);
 	if (res) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		kfree(dev);
 	}
 }
@@ -3038,12 +3023,12 @@ void pm8001_mpi_set_dev_state_resp(struct pm8001_=
hba_info *pm8001_ha,
 	u32 device_id =3D le32_to_cpu(pPayload->device_id);
 	u8 pds =3D le32_to_cpu(pPayload->pds_nds) & PDS_BITS;
 	u8 nds =3D le32_to_cpu(pPayload->pds_nds) & NDS_BITS;
-	pm8001_dbg(pm8001_ha, MSG, "Set device id =3D 0x%x state from 0x%x to 0=
x%x status =3D 0x%x!\n",
+
+	pm8001_dbg(pm8001_ha, MSG,
+		   "Set device id =3D 0x%x state from 0x%x to 0x%x status =3D 0x%x!\n"=
,
 		   device_id, pds, nds, status);
 	complete(pm8001_dev->setds_completion);
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	pm8001_tag_free(pm8001_ha, tag);
+	pm8001_ccb_free(pm8001_ha, ccb);
 }
=20
 void pm8001_mpi_set_nvmd_resp(struct pm8001_hba_info *pm8001_ha, void *p=
iomb)
@@ -3053,15 +3038,14 @@ void pm8001_mpi_set_nvmd_resp(struct pm8001_hba_i=
nfo *pm8001_ha, void *piomb)
 	u32 tag =3D le32_to_cpu(pPayload->tag);
 	struct pm8001_ccb_info *ccb =3D &pm8001_ha->ccb_info[tag];
 	u32 dlen_status =3D le32_to_cpu(pPayload->dlen_status);
+
 	complete(pm8001_ha->nvmd_completion);
 	pm8001_dbg(pm8001_ha, MSG, "Set nvm data complete!\n");
 	if ((dlen_status & NVMD_STAT) !=3D 0) {
 		pm8001_dbg(pm8001_ha, FAIL, "Set nvm data error %x\n",
 				dlen_status);
 	}
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	pm8001_tag_free(pm8001_ha, tag);
+	pm8001_ccb_free(pm8001_ha, ccb);
 }
=20
 void
@@ -3086,9 +3070,7 @@ pm8001_mpi_get_nvmd_resp(struct pm8001_hba_info *pm=
8001_ha, void *piomb)
 		/* We should free tag during failure also, the tag is not being
 		 * freed by requesting path anywhere.
 		 */
-		ccb->task =3D NULL;
-		ccb->ccb_tag =3D PM8001_INVALID_TAG;
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 	if (ir_tds_bn_dps_das_nvm & IPMode) {
@@ -3132,9 +3114,7 @@ pm8001_mpi_get_nvmd_resp(struct pm8001_hba_info *pm=
8001_ha, void *piomb)
 	 */
 	complete(pm8001_ha->nvmd_completion);
 	pm8001_dbg(pm8001_ha, MSG, "Get nvmd data complete!\n");
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	pm8001_tag_free(pm8001_ha, tag);
+	pm8001_ccb_free(pm8001_ha, ccb);
 }
=20
 int pm8001_mpi_local_phy_ctl(struct pm8001_hba_info *pm8001_ha, void *pi=
omb)
@@ -3545,9 +3525,7 @@ int pm8001_mpi_reg_resp(struct pm8001_hba_info *pm8=
001_ha, void *piomb)
 		break;
 	}
 	complete(pm8001_dev->dcompletion);
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	pm8001_tag_free(pm8001_ha, htag);
+	pm8001_ccb_free(pm8001_ha, ccb);
 	return 0;
 }
=20
@@ -3580,6 +3558,7 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_h=
ba_info *pm8001_ha,
 		(struct fw_flash_Update_resp *)(piomb + 4);
 	u32 tag =3D le32_to_cpu(ppayload->tag);
 	struct pm8001_ccb_info *ccb =3D &pm8001_ha->ccb_info[tag];
+
 	status =3D le32_to_cpu(ppayload->status);
 	switch (status) {
 	case FLASH_UPDATE_COMPLETE_PENDING_REBOOT:
@@ -3617,9 +3596,7 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_h=
ba_info *pm8001_ha,
 		break;
 	}
 	kfree(ccb->fw_control_context);
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	pm8001_tag_free(pm8001_ha, tag);
+	pm8001_ccb_free(pm8001_ha, ccb);
 	complete(pm8001_ha->nvmd_completion);
 	return 0;
 }
@@ -4412,7 +4389,7 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hb=
a_info *pm8001_ha,
 	u32 stp_sspsmp_sata =3D 0x4;
 	struct inbound_queue_table *circularQ;
 	u32 linkrate, phy_id;
-	int rc, tag =3D 0xdeadbeef;
+	int rc;
 	struct pm8001_ccb_info *ccb;
 	u8 retryFlag =3D 0x1;
 	u16 firstBurstSize =3D 0;
@@ -4423,13 +4400,11 @@ static int pm8001_chip_reg_dev_req(struct pm8001_=
hba_info *pm8001_ha,
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
=20
 	memset(&payload, 0, sizeof(payload));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc)
-		return rc;
-	ccb =3D &pm8001_ha->ccb_info[tag];
-	ccb->device =3D pm8001_dev;
-	ccb->ccb_tag =3D tag;
-	payload.tag =3D cpu_to_le32(tag);
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
+	if (!ccb)
+		return -SAS_QUEUE_FULL;
+
+	payload.tag =3D cpu_to_le32(ccb->ccb_tag);
 	if (flag =3D=3D 1)
 		stp_sspsmp_sata =3D 0x02; /*direct attached sata */
 	else {
@@ -4459,7 +4434,7 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hb=
a_info *pm8001_ha,
 	rc =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
 			sizeof(payload), 0);
 	if (rc)
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
=20
 	return rc;
 }
@@ -4624,7 +4599,6 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info=
 *pm8001_ha,
 	u32 opc =3D OPC_INB_GET_NVMD_DATA;
 	u32 nvmd_type;
 	int rc;
-	u32 tag;
 	struct pm8001_ccb_info *ccb;
 	struct inbound_queue_table *circularQ;
 	struct get_nvm_data_req nvmd_req;
@@ -4639,15 +4613,15 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_in=
fo *pm8001_ha,
 	fw_control_context->len =3D ioctl_payload->rd_length;
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
 	memset(&nvmd_req, 0, sizeof(nvmd_req));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc) {
+
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
+	if (!ccb) {
 		kfree(fw_control_context);
-		return rc;
+		return -SAS_QUEUE_FULL;
 	}
-	ccb =3D &pm8001_ha->ccb_info[tag];
-	ccb->ccb_tag =3D tag;
 	ccb->fw_control_context =3D fw_control_context;
-	nvmd_req.tag =3D cpu_to_le32(tag);
+
+	nvmd_req.tag =3D cpu_to_le32(ccb->ccb_tag);
=20
 	switch (nvmd_type) {
 	case TWI_DEVICE: {
@@ -4708,7 +4682,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info=
 *pm8001_ha,
 			sizeof(nvmd_req), 0);
 	if (rc) {
 		kfree(fw_control_context);
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 	}
 	return rc;
 }
@@ -4719,7 +4693,6 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info=
 *pm8001_ha,
 	u32 opc =3D OPC_INB_SET_NVMD_DATA;
 	u32 nvmd_type;
 	int rc;
-	u32 tag;
 	struct pm8001_ccb_info *ccb;
 	struct inbound_queue_table *circularQ;
 	struct set_nvm_data_req nvmd_req;
@@ -4735,15 +4708,15 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_in=
fo *pm8001_ha,
 		&ioctl_payload->func_specific,
 		ioctl_payload->wr_length);
 	memset(&nvmd_req, 0, sizeof(nvmd_req));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc) {
+
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
+	if (!ccb) {
 		kfree(fw_control_context);
-		return -EBUSY;
+		return -SAS_QUEUE_FULL;
 	}
-	ccb =3D &pm8001_ha->ccb_info[tag];
 	ccb->fw_control_context =3D fw_control_context;
-	ccb->ccb_tag =3D tag;
-	nvmd_req.tag =3D cpu_to_le32(tag);
+
+	nvmd_req.tag =3D cpu_to_le32(ccb->ccb_tag);
 	switch (nvmd_type) {
 	case TWI_DEVICE: {
 		u32 twi_addr, twi_page_size;
@@ -4793,7 +4766,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info=
 *pm8001_ha,
 			sizeof(nvmd_req), 0);
 	if (rc) {
 		kfree(fw_control_context);
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 	}
 	return rc;
 }
@@ -4839,7 +4812,6 @@ pm8001_chip_fw_flash_update_req(struct pm8001_hba_i=
nfo *pm8001_ha,
 	struct fw_control_info *fw_control;
 	struct fw_control_ex *fw_control_context;
 	int rc;
-	u32 tag;
 	struct pm8001_ccb_info *ccb;
 	void *buffer =3D pm8001_ha->memoryMap.region[FW_FLASH].virt_ptr;
 	dma_addr_t phys_addr =3D pm8001_ha->memoryMap.region[FW_FLASH].phys_add=
r;
@@ -4863,19 +4835,19 @@ pm8001_chip_fw_flash_update_req(struct pm8001_hba=
_info *pm8001_ha,
 	fw_control_context->virtAddr =3D buffer;
 	fw_control_context->phys_addr =3D phys_addr;
 	fw_control_context->len =3D fw_control->len;
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc) {
+
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
+	if (!ccb) {
 		kfree(fw_control_context);
-		return -EBUSY;
+		return -SAS_QUEUE_FULL;
 	}
-	ccb =3D &pm8001_ha->ccb_info[tag];
 	ccb->fw_control_context =3D fw_control_context;
-	ccb->ccb_tag =3D tag;
+
 	rc =3D pm8001_chip_fw_flash_update_build(pm8001_ha, &flash_update_info,
-		tag);
+					       ccb->ccb_tag);
 	if (rc) {
 		kfree(fw_control_context);
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 	}
=20
 	return rc;
@@ -4967,26 +4939,25 @@ pm8001_chip_set_dev_state_req(struct pm8001_hba_i=
nfo *pm8001_ha,
 	struct inbound_queue_table *circularQ;
 	struct pm8001_ccb_info *ccb;
 	int rc;
-	u32 tag;
 	u32 opc =3D OPC_INB_SET_DEVICE_STATE;
+
 	memset(&payload, 0, sizeof(payload));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc)
-		return -1;
-	ccb =3D &pm8001_ha->ccb_info[tag];
-	ccb->ccb_tag =3D tag;
-	ccb->device =3D pm8001_dev;
+
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
+	if (!ccb)
+		return -SAS_QUEUE_FULL;
+
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
-	payload.tag =3D cpu_to_le32(tag);
+	payload.tag =3D cpu_to_le32(ccb->ccb_tag);
 	payload.device_id =3D cpu_to_le32(pm8001_dev->device_id);
 	payload.nds =3D cpu_to_le32(state);
+
 	rc =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
 			sizeof(payload), 0);
 	if (rc)
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
=20
 	return rc;
-
 }
=20
 static int
@@ -4996,25 +4967,26 @@ pm8001_chip_sas_re_initialization(struct pm8001_h=
ba_info *pm8001_ha)
 	struct inbound_queue_table *circularQ;
 	struct pm8001_ccb_info *ccb;
 	int rc;
-	u32 tag;
 	u32 opc =3D OPC_INB_SAS_RE_INITIALIZE;
+
 	memset(&payload, 0, sizeof(payload));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc)
-		return -ENOMEM;
-	ccb =3D &pm8001_ha->ccb_info[tag];
-	ccb->ccb_tag =3D tag;
+
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
+	if (!ccb)
+		return -SAS_QUEUE_FULL;
+
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
-	payload.tag =3D cpu_to_le32(tag);
+	payload.tag =3D cpu_to_le32(ccb->ccb_tag);
 	payload.SSAHOLT =3D cpu_to_le32(0xd << 25);
 	payload.sata_hol_tmo =3D cpu_to_le32(80);
 	payload.open_reject_cmdretries_data_retries =3D cpu_to_le32(0xff00ff);
+
 	rc =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
 			sizeof(payload), 0);
 	if (rc)
-		pm8001_tag_free(pm8001_ha, tag);
-	return rc;
+		pm8001_ccb_free(pm8001_ha, ccb);
=20
+	return rc;
 }
=20
 const struct pm8001_dispatch pm8001_8001_dispatch =3D {
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm800=
1_sas.c
index 55859d24edd3..6e5d1af12230 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -74,7 +74,7 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha,=
 u32 tag)
   * @pm8001_ha: our hba struct
   * @tag_out: the found empty tag .
   */
-inline int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_=
out)
+int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 {
 	unsigned int tag;
 	void *bitmap =3D pm8001_ha->tags;
@@ -381,7 +381,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t=
 gfp_flags)
 	struct pm8001_port *port =3D NULL;
 	struct sas_task *t =3D task;
 	struct pm8001_ccb_info *ccb;
-	u32 tag =3D 0xdeadbeef, rc =3D 0, n_elem =3D 0;
+	u32 rc =3D 0, n_elem =3D 0;
 	unsigned long flags =3D 0;
 	enum sas_protocol task_proto =3D t->task_proto;
 	struct sas_tmf_task *tmf =3D task->tmf;
@@ -427,10 +427,12 @@ int pm8001_queue_command(struct sas_task *task, gfp=
_t gfp_flags)
 				continue;
 			}
 		}
-		rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-		if (rc)
+
+		ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_dev, t);
+		if (!ccb) {
+			rc =3D -SAS_QUEUE_FULL;
 			goto err_out;
-		ccb =3D &pm8001_ha->ccb_info[tag];
+		}
=20
 		if (!sas_protocol_ata(task_proto)) {
 			if (t->num_scatter) {
@@ -440,7 +442,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t=
 gfp_flags)
 					t->data_dir);
 				if (!n_elem) {
 					rc =3D -ENOMEM;
-					goto err_out_tag;
+					goto err_out_ccb;
 				}
 			}
 		} else {
@@ -449,9 +451,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t=
 gfp_flags)
=20
 		t->lldd_task =3D ccb;
 		ccb->n_elem =3D n_elem;
-		ccb->ccb_tag =3D tag;
-		ccb->task =3D t;
-		ccb->device =3D pm8001_dev;
+
 		switch (task_proto) {
 		case SAS_PROTOCOL_SMP:
 			atomic_inc(&pm8001_dev->running_req);
@@ -480,15 +480,15 @@ int pm8001_queue_command(struct sas_task *task, gfp=
_t gfp_flags)
 		if (rc) {
 			pm8001_dbg(pm8001_ha, IO, "rc is %x\n", rc);
 			atomic_dec(&pm8001_dev->running_req);
-			goto err_out_tag;
+			goto err_out_ccb;
 		}
 		/* TODO: select normal or high priority */
 	} while (0);
 	rc =3D 0;
 	goto out_done;
=20
-err_out_tag:
-	pm8001_tag_free(pm8001_ha, tag);
+err_out_ccb:
+	pm8001_ccb_free(pm8001_ha, ccb);
 err_out:
 	dev_printk(KERN_ERR, pm8001_ha->dev, "pm8001 exec failed[%d]!\n", rc);
 	if (!sas_protocol_ata(task_proto))
@@ -548,10 +548,7 @@ void pm8001_ccb_task_free(struct pm8001_hba_info *pm=
8001_ha,
 	}
=20
 	task->lldd_task =3D NULL;
-	ccb->task =3D NULL;
-	ccb->ccb_tag =3D PM8001_INVALID_TAG;
-	ccb->open_retry =3D 0;
-	pm8001_tag_free(pm8001_ha, ccb_idx);
+	pm8001_ccb_free(pm8001_ha, ccb);
 }
=20
 /**
@@ -707,7 +704,6 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_inf=
o *pm8001_ha,
 	u32 task_tag)
 {
 	int res, retry;
-	u32 ccb_tag;
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task =3D NULL;
=20
@@ -724,23 +720,19 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_i=
nfo *pm8001_ha,
 			jiffies + PM8001_TASK_TIMEOUT * HZ;
 		add_timer(&task->slow_task->timer);
=20
-		res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-		if (res)
+		ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
+		if (!ccb) {
+			res =3D -SAS_QUEUE_FULL;
 			break;
-
-		ccb =3D &pm8001_ha->ccb_info[ccb_tag];
-		ccb->device =3D pm8001_dev;
-		ccb->ccb_tag =3D ccb_tag;
-		ccb->task =3D task;
-		ccb->n_elem =3D 0;
+		}
=20
 		res =3D PM8001_CHIP_DISP->task_abort(pm8001_ha, pm8001_dev, flag,
-						   task_tag, ccb_tag);
+						   task_tag, ccb->ccb_tag);
 		if (res) {
 			del_timer(&task->slow_task->timer);
 			pm8001_dbg(pm8001_ha, FAIL,
 				   "Executing internal task failed\n");
-			pm8001_tag_free(pm8001_ha, ccb_tag);
+			pm8001_ccb_free(pm8001_ha, ccb);
 			break;
 		}
=20
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm800=
1_sas.h
index 5082c7dc07ee..00b4470634bd 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -734,6 +734,53 @@ extern const struct attribute_group *pm8001_host_gro=
ups[];
=20
 #define PM8001_INVALID_TAG	((u32)-1)
=20
+/*
+ * Allocate a new tag and return the corresponding ccb after initializin=
g it.
+ */
+static inline struct pm8001_ccb_info *
+pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
+		 struct pm8001_device *dev, struct sas_task *task)
+{
+	struct pm8001_ccb_info *ccb;
+	u32 tag;
+
+	if (pm8001_tag_alloc(pm8001_ha, &tag)) {
+		pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
+		return NULL;
+	}
+
+	ccb =3D &pm8001_ha->ccb_info[tag];
+	ccb->task =3D task;
+	ccb->n_elem =3D 0;
+	ccb->ccb_tag =3D tag;
+	ccb->device =3D dev;
+	ccb->fw_control_context =3D NULL;
+	ccb->open_retry =3D 0;
+
+	return ccb;
+}
+
+/*
+ * Free the tag of an initialized ccb.
+ */
+static inline void pm8001_ccb_free(struct pm8001_hba_info *pm8001_ha,
+				   struct pm8001_ccb_info *ccb)
+{
+	u32 tag =3D ccb->ccb_tag;
+
+	/*
+	 * Cleanup the ccb to make sure that a manual scan of the adapter
+	 * ccb_info array can detect ccb's that are in use.
+	 * C.f. pm8001_open_reject_retry()
+	 */
+	ccb->task =3D NULL;
+	ccb->ccb_tag =3D PM8001_INVALID_TAG;
+	ccb->device =3D NULL;
+	ccb->fw_control_context =3D NULL;
+
+	pm8001_tag_free(pm8001_ha, tag);
+}
+
 static inline void
 pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
 			struct sas_task *task, struct pm8001_ccb_info *ccb,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
index 4419fdb0db78..57ea933dab66 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1767,8 +1767,6 @@ pm80xx_chip_interrupt_disable(struct pm8001_hba_inf=
o *pm8001_ha, u8 vec)
 static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 		struct pm8001_device *pm8001_ha_dev)
 {
-	int res;
-	u32 ccb_tag;
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task =3D NULL;
 	struct task_abort_req task_abort;
@@ -1790,31 +1788,25 @@ static void pm80xx_send_abort_all(struct pm8001_h=
ba_info *pm8001_ha,
=20
 	task->task_done =3D pm8001_task_done;
=20
-	res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res) {
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
+	if (!ccb) {
 		sas_free_task(task);
 		return;
 	}
=20
-	ccb =3D &pm8001_ha->ccb_info[ccb_tag];
-	ccb->device =3D pm8001_ha_dev;
-	ccb->ccb_tag =3D ccb_tag;
-	ccb->task =3D task;
-	ccb->n_elem =3D 0;
-
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
=20
 	memset(&task_abort, 0, sizeof(task_abort));
 	task_abort.abort_all =3D cpu_to_le32(1);
 	task_abort.device_id =3D cpu_to_le32(pm8001_ha_dev->device_id);
-	task_abort.tag =3D cpu_to_le32(ccb_tag);
+	task_abort.tag =3D cpu_to_le32(ccb->ccb_tag);
=20
 	ret =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
 	pm8001_dbg(pm8001_ha, FAIL, "Executing abort task end\n");
 	if (ret) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 	}
 }
=20
@@ -1823,7 +1815,6 @@ static void pm80xx_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 {
 	struct sata_start_req sata_cmd;
 	int res;
-	u32 ccb_tag;
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task =3D NULL;
 	struct host_to_dev_fis fis;
@@ -1839,20 +1830,13 @@ static void pm80xx_send_read_log(struct pm8001_hb=
a_info *pm8001_ha,
 	}
 	task->task_done =3D pm8001_task_done;
=20
-	res =3D pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res) {
-		sas_free_task(task);
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate tag !!!\n");
-		return;
-	}
-
-	/* allocate domain device by ourselves as libsas
-	 * is not going to provide any
-	*/
+	/*
+	 * Allocate domain device by ourselves as libsas is not going to
+	 * provide any.
+	 */
 	dev =3D kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
 	if (!dev) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
 		pm8001_dbg(pm8001_ha, FAIL,
 			   "Domain device cannot be allocated\n");
 		return;
@@ -1861,11 +1845,13 @@ static void pm80xx_send_read_log(struct pm8001_hb=
a_info *pm8001_ha,
 	task->dev =3D dev;
 	task->dev->lldd_dev =3D pm8001_ha_dev;
=20
-	ccb =3D &pm8001_ha->ccb_info[ccb_tag];
-	ccb->device =3D pm8001_ha_dev;
-	ccb->ccb_tag =3D ccb_tag;
-	ccb->task =3D task;
-	ccb->n_elem =3D 0;
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
+	if (!ccb) {
+		sas_free_task(task);
+		kfree(dev);
+		return;
+	}
+
 	pm8001_ha_dev->id |=3D NCQ_READ_LOG_FLAG;
 	pm8001_ha_dev->id |=3D NCQ_2ND_RLE_FLAG;
=20
@@ -1880,7 +1866,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 	fis.lbal =3D 0x10;
 	fis.sector_count =3D 0x1;
=20
-	sata_cmd.tag =3D cpu_to_le32(ccb_tag);
+	sata_cmd.tag =3D cpu_to_le32(ccb->ccb_tag);
 	sata_cmd.device_id =3D cpu_to_le32(pm8001_ha_dev->device_id);
 	sata_cmd.ncqtag_atap_dir_m_dad =3D cpu_to_le32(((0x1 << 7) | (0x5 << 9)=
));
 	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
@@ -1890,7 +1876,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_=
info *pm8001_ha,
 	pm8001_dbg(pm8001_ha, FAIL, "Executing read log end\n");
 	if (res) {
 		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		kfree(dev);
 	}
 }
@@ -4834,7 +4820,7 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hb=
a_info *pm8001_ha,
 	u32 stp_sspsmp_sata =3D 0x4;
 	struct inbound_queue_table *circularQ;
 	u32 linkrate, phy_id;
-	int rc, tag =3D 0xdeadbeef;
+	int rc;
 	struct pm8001_ccb_info *ccb;
 	u8 retryFlag =3D 0x1;
 	u16 firstBurstSize =3D 0;
@@ -4845,13 +4831,11 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_=
hba_info *pm8001_ha,
 	circularQ =3D &pm8001_ha->inbnd_q_tbl[0];
=20
 	memset(&payload, 0, sizeof(payload));
-	rc =3D pm8001_tag_alloc(pm8001_ha, &tag);
-	if (rc)
-		return rc;
-	ccb =3D &pm8001_ha->ccb_info[tag];
-	ccb->device =3D pm8001_dev;
-	ccb->ccb_tag =3D tag;
-	payload.tag =3D cpu_to_le32(tag);
+	ccb =3D pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
+	if (!ccb)
+		return -SAS_QUEUE_FULL;
+
+	payload.tag =3D cpu_to_le32(ccb->ccb_tag);
=20
 	if (flag =3D=3D 1) {
 		stp_sspsmp_sata =3D 0x02; /*direct attached sata */
@@ -4888,7 +4872,7 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hb=
a_info *pm8001_ha,
 	rc =3D pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
 			sizeof(payload), 0);
 	if (rc)
-		pm8001_tag_free(pm8001_ha, tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
=20
 	return rc;
 }
--=20
2.34.1

