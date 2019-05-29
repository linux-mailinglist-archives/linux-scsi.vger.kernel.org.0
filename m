Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57E82E61E
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2U2u (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44303 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE2U2u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so1526992pll.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECvWTpDBy5CMv4eMNUDEZmCMJa40SWVksHLn9pb8yEM=;
        b=p2ewY3QAKpPuJ/860kFujiXKvtpkU4Tvs0XKJUN9iB4MuWUILPlJ58xdkuk4rd0HxC
         T0+Kp4rMwc5TXoHoWWOJgbzVmXkfbeFVDwc652QhTVYVThGgQBz61z9lwc+6/cZRIIiA
         LNQZeEfmyk3t7C3G+tfRg3WmY5KlEuPsGtDLddsjJNFyDFy8ua5XlvwEv3znAiIo11ud
         PU806x4AKMBILnMv6N8h5MebTaJf8SZFt5sF7f1//Eu42zVUg1JprGgNTUIPZzoYZojK
         SaCYr6NQfJJ+/vdyIGD1O0VE7abU/k0TzIFch8eTUoqgIAe2PQ/WTnOOl2NAX0DiB1ZP
         Nj8w==
X-Gm-Message-State: APjAAAUHxyZjIREibJvHa6C/qAacvtnzH4Lt3KiCTScLNAvxWD36O+LP
        CMaksYce0Jbdnia6AWxmmjw=
X-Google-Smtp-Source: APXvYqwGBczk0e1nOLuHe5VFnQhFJcTaKG076SoSQpDhrMAC1YQ2Q9ZISA4+M5uo0Cjc9tlc5nlh7Q==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr10120647plp.65.1559161729698;
        Wed, 29 May 2019 13:28:49 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 10/20] qla2xxx: Verify locking assumptions at runtime
Date:   Wed, 29 May 2019 13:28:16 -0700
Message-Id: <20190529202826.204499-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index c3a371d84595..d516337f5979 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -798,6 +798,8 @@ qlt_plogi_ack_find_add(struct scsi_qla_host *vha, port_id_t *id,
 {
 	struct qlt_plogi_ack_t *pla;
 
+	lockdep_assert_held(&vha->hw->hardware_lock);
+
 	list_for_each_entry(pla, &vha->plogi_ack_list, list) {
 		if (pla->id.b24 == id->b24) {
 			ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x210d,
@@ -4723,6 +4725,8 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 	struct qlt_plogi_ack_t *pla;
 	unsigned long flags;
 
+	lockdep_assert_held(&vha->hw->hardware_lock);
+
 	wwn = wwn_to_u64(iocb->u.isp24.port_name);
 
 	port_id.b.domain = iocb->u.isp24.port_id[2];
@@ -4896,6 +4900,8 @@ static int qlt_24xx_handle_els(struct scsi_qla_host *vha,
 	int res = 0;
 	unsigned long flags;
 
+	lockdep_assert_held(&ha->hardware_lock);
+
 	wwn = wwn_to_u64(iocb->u.isp24.port_name);
 
 	port_id.b.domain = iocb->u.isp24.port_id[2];
@@ -5172,6 +5178,8 @@ static void qlt_handle_imm_notify(struct scsi_qla_host *vha,
 	int send_notify_ack = 1;
 	uint16_t status;
 
+	lockdep_assert_held(&ha->hardware_lock);
+
 	status = le16_to_cpu(iocb->u.isp2x.status);
 	switch (status) {
 	case IMM_NTFY_LIP_RESET:
-- 
2.22.0.rc1

