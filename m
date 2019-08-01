Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185B17E18E
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfHAR4k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41846 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so34516490pff.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TZhYe3izFrQc6kjq19onINXIPi35A2vjjAXkHrk/so=;
        b=J+W/B7ScLCT3e398a3RZxw5OHWg+ffviucC1N1YpGeyc93r+isj12OngPWRzSLASN5
         AoqwZzeVOk821kn2lDS5A1vlIcIa9WE52mE9YtD/i9cvipwUVOWUpQ2HLRngz6j6wMK/
         YsVm9+3CbMdQwV3vO77WuD+0e35/fX/qySMEHXgqHmyk1i4gB5WOY6h7P+5yo8XekEpD
         tSzUDCN/RJKSfpvWwoGa42yLd4GerWyWMTXNzFHvQpzIbKVSxC421hpF2fQLoJDjdp4n
         5DutwVYES49VEczwFAPQ0OJEh/K7SMdJLikJVEqBuYvsKjJSXAi+w8ENYbRBR1NThn93
         ypZw==
X-Gm-Message-State: APjAAAVdMF6thWcYwx9LH5s1vxKs5CRP7Xl5ajz0kfu8w+QxXtPLfsKo
        xiuXIUOnHnvvWPt0WAov33I=
X-Google-Smtp-Source: APXvYqyJtzTGYqHKYBDULYXXeqY3mJLXs40EGTMGikXqOd0YidwyP/O9S9f+BgzdaJQN95svu++UjA==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr13688200pfi.105.1564682199601;
        Thu, 01 Aug 2019 10:56:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 13/59] qla2xxx: Verify locking assumptions at runtime
Date:   Thu,  1 Aug 2019 10:55:28 -0700
Message-Id: <20190801175614.73655-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make sure that locking assumptions are verified at runtime if kernel
debugging is enabled.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index b8241d7b1f8a..ded5f13372af 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -789,6 +789,8 @@ qlt_plogi_ack_find_add(struct scsi_qla_host *vha, port_id_t *id,
 {
 	struct qlt_plogi_ack_t *pla;
 
+	lockdep_assert_held(&vha->hw->hardware_lock);
+
 	list_for_each_entry(pla, &vha->plogi_ack_list, list) {
 		if (pla->id.b24 == id->b24) {
 			ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x210d,
@@ -4713,6 +4715,8 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 	struct qlt_plogi_ack_t *pla;
 	unsigned long flags;
 
+	lockdep_assert_held(&vha->hw->hardware_lock);
+
 	wwn = wwn_to_u64(iocb->u.isp24.port_name);
 
 	port_id.b.domain = iocb->u.isp24.port_id[2];
@@ -4886,6 +4890,8 @@ static int qlt_24xx_handle_els(struct scsi_qla_host *vha,
 	int res = 0;
 	unsigned long flags;
 
+	lockdep_assert_held(&ha->hardware_lock);
+
 	wwn = wwn_to_u64(iocb->u.isp24.port_name);
 
 	port_id.b.domain = iocb->u.isp24.port_id[2];
@@ -5162,6 +5168,8 @@ static void qlt_handle_imm_notify(struct scsi_qla_host *vha,
 	int send_notify_ack = 1;
 	uint16_t status;
 
+	lockdep_assert_held(&ha->hardware_lock);
+
 	status = le16_to_cpu(iocb->u.isp2x.status);
 	switch (status) {
 	case IMM_NTFY_LIP_RESET:
-- 
2.22.0.770.g0f2c4a37fd-goog

