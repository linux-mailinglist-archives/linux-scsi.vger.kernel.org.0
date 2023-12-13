Return-Path: <linux-scsi+bounces-650-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D7807802
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C35F1F21089
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A446EB69
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="htFbLTE3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8938384;
	Wed,  6 Dec 2023 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1974; q=dns/txt; s=iport;
  t=1701888391; x=1703097991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cAUkkq9AKnGLq+kxdOrbr7ZaaBIeDQKT3XyG1iC0jTE=;
  b=htFbLTE3hRy5ZuV5famGeFndKua9XfoWi5FIU/cB3UcJERY0HQ0P/te1
   0Otx8+bN+jwpXNVCrsqghuJDoW191sGMnyP1aPyf2Lz3Qod933LSWhbFh
   Vnt2uxwO4ZE70UHaMjtiF52L2rCqzxZylPTbELW2kR+wh4zLD2AdwAzP4
   c=;
X-CSE-ConnectionGUID: 8I9DPCYVTJS1eCqzmIefvQ==
X-CSE-MsgGUID: pTBMEiQTTp+dvPAeeUirxA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="155092235"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:46:30 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3B6IkHCv010013
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Dec 2023 18:46:29 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5 01/13] scsi: fnic: Modify definitions to sync with VIC firmware
Date: Wed,  6 Dec 2023 10:46:03 -0800
Message-Id: <20231206184615.878755-2-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206184615.878755-1-kartilak@cisco.com>
References: <20231206184615.878755-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: alln-core-4.cisco.com

VIC firmware has updated definitions.
Modify structure and definitions to sync with the latest VIC firmware.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/vnic_scsi.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_scsi.h b/drivers/scsi/fnic/vnic_scsi.h
index 4e12f7b32d9d..f715f7942bfe 100644
--- a/drivers/scsi/fnic/vnic_scsi.h
+++ b/drivers/scsi/fnic/vnic_scsi.h
@@ -26,7 +26,7 @@
 #define VNIC_FNIC_RATOV_MAX                 255000
 
 #define VNIC_FNIC_MAXDATAFIELDSIZE_MIN      256
-#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2112
+#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2048
 
 #define VNIC_FNIC_FLOGI_RETRIES_MIN         0
 #define VNIC_FNIC_FLOGI_RETRIES_MAX         0xffffffff
@@ -55,7 +55,7 @@
 #define VNIC_FNIC_PORT_DOWN_IO_RETRIES_MAX  255
 
 #define VNIC_FNIC_LUNS_PER_TARGET_MIN       1
-#define VNIC_FNIC_LUNS_PER_TARGET_MAX       1024
+#define VNIC_FNIC_LUNS_PER_TARGET_MAX       4096
 
 /* Device-specific region: scsi configuration */
 struct vnic_fc_config {
@@ -79,10 +79,19 @@ struct vnic_fc_config {
 	u16 ra_tov;
 	u16 intr_timer;
 	u8 intr_timer_type;
+	u8 intr_mode;
+	u8 lun_queue_depth;
+	u8 io_timeout_retry;
+	u16 wq_copy_count;
 };
 
 #define VFCF_FCP_SEQ_LVL_ERR	0x1	/* Enable FCP-2 Error Recovery */
 #define VFCF_PERBI		0x2	/* persistent binding info available */
 #define VFCF_FIP_CAPABLE	0x4	/* firmware can handle FIP */
 
+#define VFCF_FC_INITIATOR         0x20    /* FC Initiator Mode */
+#define VFCF_FC_TARGET            0x40    /* FC Target Mode */
+#define VFCF_FC_NVME_INITIATOR    0x80    /* FC-NVMe Initiator Mode */
+#define VFCF_FC_NVME_TARGET       0x100   /* FC-NVMe Target Mode */
+
 #endif /* _VNIC_SCSI_H_ */
-- 
2.31.1


