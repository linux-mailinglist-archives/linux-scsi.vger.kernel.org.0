Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF7297439
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Oct 2020 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbgJWQdv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbgJWQdu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFEC246A5;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=7fApo5dMk1RYvHic8Q63yPyLUo2N5fli6iXRWozmflg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMm6QTakQJr7Mn3pR5qZu4CBFKLSzpivPOhTn6Nu/ktgeBN941RCnSasdIGvPyZeB
         SN+nLSG9ISf3PirMHdvnCFd+S2d/yU4zTukxwas8lHtstfg+3ACRJcw/+aJADhZugc
         i/cMjSrQ1cWU+TDRYUBjz0RFccN1LBpD5qgqicKQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002Awa-Ul; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Leech <cleech@redhat.com>, Lee Duncan <lduncan@suse.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        open-iscsi@googlegroups.com
Subject: [PATCH v3 27/56] scsi: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:14 +0200
Message-Id: <8ed7f149f25a363eea76e514c253c4e337c59379.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/scsi/iscsi_tcp.c         | 4 ++--
 drivers/scsi/libiscsi.c          | 2 +-
 drivers/scsi/scsi_devinfo.c      | 3 ++-
 drivers/scsi/scsi_lib.c          | 6 +++---
 drivers/scsi/scsi_transport_fc.c | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index df47557a02a3..a9ce6298b935 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -180,7 +180,7 @@ static void iscsi_sw_tcp_state_change(struct sock *sk)
 }
 
 /**
- * iscsi_write_space - Called when more output buffer space is available
+ * iscsi_sw_tcp_write_space - Called when more output buffer space is available
  * @sk: socket space is available for
  **/
 static void iscsi_sw_tcp_write_space(struct sock *sk)
@@ -353,7 +353,7 @@ static int iscsi_sw_tcp_xmit(struct iscsi_conn *conn)
 }
 
 /**
- * iscsi_tcp_xmit_qlen - return the number of bytes queued for xmit
+ * iscsi_sw_tcp_xmit_qlen - return the number of bytes queued for xmit
  * @conn: iscsi connection
  */
 static inline int iscsi_sw_tcp_xmit_qlen(struct iscsi_conn *conn)
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 1e9c3171fa9f..8a4552f09dfe 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -777,7 +777,7 @@ int iscsi_conn_send_pdu(struct iscsi_cls_conn *cls_conn, struct iscsi_hdr *hdr,
 EXPORT_SYMBOL_GPL(iscsi_conn_send_pdu);
 
 /**
- * iscsi_cmd_rsp - SCSI Command Response processing
+ * iscsi_scsi_cmd_rsp - SCSI Command Response processing
  * @conn: iscsi connection
  * @hdr: iscsi header
  * @task: scsi command task
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index ba84244c1b4f..d92cec12454c 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -559,7 +559,8 @@ static int scsi_dev_info_list_add_str(char *dev_list)
 }
 
 /**
- * get_device_flags - get device specific flags from the dynamic device list.
+ * scsi_get_device_flags - get device specific flags from the dynamic
+ *	device list.
  * @sdev:       &scsi_device to get flags for
  * @vendor:	vendor name
  * @model:	model name
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 97ff31ed2a44..f74db5160f23 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1502,7 +1502,7 @@ static void scsi_softirq_done(struct request *rq)
 }
 
 /**
- * scsi_dispatch_command - Dispatch a command to the low-level driver.
+ * scsi_dispatch_cmd - Dispatch a command to the low-level driver.
  * @cmd: command block we are dispatching.
  *
  * Return: nonzero return request was rejected and device's queue needs to be
@@ -2364,7 +2364,7 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 EXPORT_SYMBOL(scsi_device_set_state);
 
 /**
- * 	sdev_evt_emit - emit a single SCSI device uevent
+ * 	scsi_evt_emit - emit a single SCSI device uevent
  *	@sdev: associated SCSI device
  *	@evt: event to emit
  *
@@ -2412,7 +2412,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
 }
 
 /**
- * 	sdev_evt_thread - send a uevent for each scsi event
+ * 	scsi_evt_thread - send a uevent for each scsi event
  *	@work: work struct for scsi_device
  *
  *	Dispatch queued events to their associated scsi_device kobjects
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 2ff7f06203da..42a6dd3bd19f 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -629,7 +629,7 @@ fc_host_post_vendor_event(struct Scsi_Host *shost, u32 event_number,
 EXPORT_SYMBOL(fc_host_post_vendor_event);
 
 /**
- * fc_host_rcv_fpin - routine to process a received FPIN.
+ * fc_host_fpin_rcv - routine to process a received FPIN.
  * @shost:		host the FPIN was received on
  * @fpin_len:		length of FPIN payload, in bytes
  * @fpin_buf:		pointer to FPIN payload
-- 
2.26.2

