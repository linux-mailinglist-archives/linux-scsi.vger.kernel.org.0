Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41692E0663
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Dec 2020 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgLVHGP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Dec 2020 02:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLVHGO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Dec 2020 02:06:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED724C0611C5
        for <linux-scsi@vger.kernel.org>; Mon, 21 Dec 2020 23:05:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g15so2896829pgu.9
        for <linux-scsi@vger.kernel.org>; Mon, 21 Dec 2020 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rj3B8dlAZkU1GvZ5mo07/zGEWG+wxk3cKKDY2pwSH4o=;
        b=Kl8WJbbmreEXa546eX80cRFqwbgFGl9nmw0TLaNJYnDHL5thGxU56zCrPhfUKj6nKF
         TU85CIjwjllIXU4drrQiDpqBCMG6HBspj4y0lLHZpeU0ELLM8FfxrMk5Xd7OZuY4AbAM
         tgvMWBsCIT4g2g1HTeaz5uDQVRofMuLJhJQT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Rj3B8dlAZkU1GvZ5mo07/zGEWG+wxk3cKKDY2pwSH4o=;
        b=p1bOQ3yDFh3VYj7QyhW8lkRFAvxZemqRQrFbrpnQjMMtedQY3dh2YKpas8nJ2QxFQM
         qVSQigjdHCUBXg/vrEE4oibK3mD+oTy4T83P0XHvCfnSKGmDjoUVLtidELrbJarKGCnQ
         /udRGDawFSCzQ3GcHkhBXbLaZd3Gwlbs0CW+yN5wzneIGuaaKf7o7gbpBgLhbiNN+eu1
         nHFQkmSKnmaiRcenZk6cXQnku8+eWS1IrWSQuhgEpfPdeR73E8+WBDIjXKooqQStXfF3
         v/xyvhKZKUmWJ8pHRqG4gjOoZip421PG4I0SC8FLEz0oM5O2pkqmBRAknU+uNjlJ5rV3
         Wqnw==
MIME-Version: 1.0
X-Gm-Message-State: AOAM532f8v9cw0dGC2rPSOp1mqF/5GMV9bOxA93pqFqEXZxSToGPBdDn
        A9cfpDXZjh/TGUNz2+5QjBMpFgDayIvJSc5xZq2qJ8mhpZrrknJuA8/g+4kMvPhIX5HrQFLy/uJ
        2YKtvOzjbTL4cXQKGW59L7hs=
X-Google-Smtp-Source: ABdhPJzl1tBL2RsR9v6fzkc2l6hlsiV7+GmUEvxwCzT00IFIgql6b8zxPh3bCH+sflXVGu+yM9vW4g==
X-Received: by 2002:a63:2f05:: with SMTP id v5mr18689049pgv.3.1608620711359;
        Mon, 21 Dec 2020 23:05:11 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t9sm12466082pgh.41.2020.12.21.23.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 23:05:10 -0800 (PST)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v6 04/16] lpfc: vmid: Add the datastructure for supporting VMID in lpfc
Date:   Tue, 22 Dec 2020 05:41:46 +0530
Message-Id: <1608595918-21954-5-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001a60fe05b70832db"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000001a60fe05b70832db
Content-Type: text/plain; charset="US-ASCII"

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the primary datastructures needed to implement VMID in lpfc
driver. It maintains the capability, current state, hash table for the
vmid/appid along with other information.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v6:
No change

v5:
No Change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
Removed unused variable.
---
 drivers/scsi/lpfc/lpfc.h | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index a54c8da30273..ab61352363d4 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -303,6 +303,63 @@ struct lpfc_stats {
 struct lpfc_hba;
 
 
+#define LPFC_VMID_TIMER   300	/* timer interval in seconds. */
+
+#define LPFC_MAX_VMID_SIZE      256
+#define LPFC_COMPRESS_VMID_SIZE 16
+
+union lpfc_vmid_io_tag {
+	u32 app_id;	/* App Id vmid */
+	u8 cs_ctl_vmid;	/* Priority tag vmid */
+};
+
+#define JIFFIES_PER_HR	(HZ * 60 * 60)
+
+struct lpfc_vmid {
+	u8 flag;
+#define LPFC_VMID_SLOT_FREE     0x0
+#define LPFC_VMID_SLOT_USED     0x1
+#define LPFC_VMID_REQ_REGISTER  0x2
+#define LPFC_VMID_REGISTERED    0x4
+#define LPFC_VMID_DE_REGISTER   0x8
+	u8 host_vmid[LPFC_MAX_VMID_SIZE];
+	union lpfc_vmid_io_tag un;
+	u64 io_rd_cnt;
+	u64 io_wr_cnt;
+	u8 vmid_len;
+	u8 delete_inactive; /* Delete if inactive flag 0 = no, 1 = yes */
+	u32 hash_index;
+	u64 __percpu *last_io_time;
+};
+
+#define lpfc_vmid_is_type_priority_tag(vport)\
+	(vport->vmid_priority_tagging ? 1 : 0)
+
+#define LPFC_VMID_HASH_SIZE     256
+#define LPFC_VMID_HASH_MASK     255
+#define LPFC_VMID_HASH_SHIFT    6
+
+struct lpfc_vmid_context {
+	struct lpfc_vmid *vmp;
+	struct lpfc_nodelist *nlp;
+	u8 instantiated;
+};
+
+struct lpfc_vmid_priority_range {
+	u8 low;
+	u8 high;
+	u8 qos;
+};
+
+struct lpfc_vmid_priority_info {
+	u32 num_descriptors;
+	struct lpfc_vmid_priority_range *vmid_range;
+};
+
+#define QFPA_EVEN_ONLY 0x01
+#define QFPA_ODD_ONLY  0x02
+#define QFPA_EVEN_ODD  0x03
+
 enum discovery_state {
 	LPFC_VPORT_UNKNOWN     =  0,    /* vport state is unknown */
 	LPFC_VPORT_FAILED      =  1,    /* vport has failed */
@@ -442,6 +499,9 @@ struct lpfc_vport {
 #define WORKER_RAMP_DOWN_QUEUE         0x800	/* hba: Decrease Q depth */
 #define WORKER_RAMP_UP_QUEUE           0x1000	/* hba: Increase Q depth */
 #define WORKER_SERVICE_TXQ             0x2000	/* hba: IOCBs on the txq */
+#define WORKER_CHECK_INACTIVE_VMID     0x4000	/* hba: check inactive vmids */
+#define WORKER_CHECK_VMID_ISSUE_QFPA   0x8000	/* vport: Check if qfpa need */
+						/* to issue */
 
 	struct timer_list els_tmofunc;
 	struct timer_list delayed_disc_tmo;
@@ -452,6 +512,8 @@ struct lpfc_vport {
 #define FC_LOADING		0x1	/* HBA in process of loading drvr */
 #define FC_UNLOADING		0x2	/* HBA in process of unloading drvr */
 #define FC_ALLOW_FDMI		0x4	/* port is ready for FDMI requests */
+#define FC_ALLOW_VMID		0x8	/* Allow VMID IO's */
+#define FC_DEREGISTER_ALL_APP_ID	0x10	/* Deregister all vmid's */
 	/* Vport Config Parameters */
 	uint32_t cfg_scan_down;
 	uint32_t cfg_lun_queue_depth;
@@ -470,9 +532,36 @@ struct lpfc_vport {
 	uint32_t cfg_tgt_queue_depth;
 	uint32_t cfg_first_burst_size;
 	uint32_t dev_loss_tmo_changed;
+	/* VMID parameters */
+	u8 lpfc_vmid_host_uuid[LPFC_COMPRESS_VMID_SIZE];
+	u32 max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cur_vmid_cnt;	/* Current VMID count */
+#define LPFC_MIN_VMID	4
+#define LPFC_MAX_VMID	255
+	u32 vmid_inactivity_timeout;	/* Time after which the VMID */
+						/* deregisters from switch */
+	u32 vmid_priority_tagging;
+#define LPFC_VMID_PRIO_TAG_DISABLE	0 /* Disable */
+#define LPFC_VMID_PRIO_TAG_SUP_TARGETS	1 /* Allow supported targets only */
+#define LPFC_VMID_PRIO_TAG_ALL_TARGETS	2 /* Allow all targets */
+	unsigned long *vmid_priority_range;
+#define LPFC_VMID_MAX_PRIORITY_RANGE    256
+#define LPFC_VMID_PRIORITY_BITMAP_SIZE  32
+	u8 vmid_flag;
+#define LPFC_VMID_IN_USE		0x1
+#define LPFC_VMID_ISSUE_QFPA		0x2
+#define LPFC_VMID_QFPA_CMPL		0x4
+#define LPFC_VMID_QOS_ENABLED		0x8
+#define LPFC_VMID_TIMER_ENBLD		0x10
+	struct fc_qfpa_res *qfpa_res;
 
 	struct fc_vport *fc_vport;
 
+	struct lpfc_vmid *vmid;
+	struct lpfc_vmid *hash_table[LPFC_VMID_HASH_SIZE];
+	rwlock_t vmid_lock;
+	struct lpfc_vmid_priority_info vmid_priority;
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct dentry *debug_disc_trc;
 	struct dentry *debug_nodelist;
@@ -934,6 +1023,13 @@ struct lpfc_hba {
 	struct nvmet_fc_target_port *targetport;
 	lpfc_vpd_t vpd;		/* vital product data */
 
+	u32 cfg_max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cfg_vmid_app_header;
+#define LPFC_VMID_APP_HEADER_DISABLE	0
+#define LPFC_VMID_APP_HEADER_ENABLE	1
+	u32 cfg_vmid_priority_tagging;
+	u32 cfg_vmid_inactivity_timeout;	/* Time after which the VMID */
+						/*  deregisters from switch */
 	struct pci_dev *pcidev;
 	struct list_head      work_list;
 	uint32_t              work_ha;      /* Host Attention Bits for WT */
@@ -1175,6 +1271,7 @@ struct lpfc_hba {
 	struct list_head ct_ev_waiters;
 	struct unsol_rcv_ct_ctx ct_ctx[LPFC_CT_CTX_MAX];
 	uint32_t ctx_idx;
+	struct timer_list inactive_vmid_poll;
 
 	/* RAS Support */
 	struct lpfc_ras_fwlog ras_fwlog;
-- 
2.26.2


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000001a60fe05b70832db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCD2Nk/OcExcTf941SqrQwaQptD96/LGETyqDgjgFePzPjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEyMjIwNzA1MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASlX5nMlSS0SjnSAq
MR5xG8I6ixUvAAvNK0NCgl+Dx6nA7JzzIBy0tuMv90Cwbl2tkmLEem8x1FOa1JPgPz+2Z19+8oH7
lCHSVeNMuCbVPHJ5EQOLQ+PWGxGzzW/Tlc/T7fRzn7BotykTR6f/IZC+R4gdOmBNXtghEbZFtQCf
1DxNK//LICoOgn9uGWqUKJqcrOXxAQhwAWhpGVtTEYvG2kyFR0S/enMZLiEQBUpmcnXDCrld9zf2
RaWZXfMtpZ00OHJRZC4IWz+IgF7Ti5t0C0lOi+Gp0Y8tpRmm1o+OIIo40WdlTia6Bvi1a/InYfZE
kp6bXqZGGRgjYA55Ioeq8A==
--0000000000001a60fe05b70832db--
