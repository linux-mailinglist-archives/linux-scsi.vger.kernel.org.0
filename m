Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF474E08D
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFUGhR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 02:37:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39283 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUGhQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Jun 2019 02:37:16 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190621063713epoutp0401c4cc377adb9cc4dc8cedee94ce0b23~qI0zRuNvt1401714017epoutp04c
        for <linux-scsi@vger.kernel.org>; Fri, 21 Jun 2019 06:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190621063713epoutp0401c4cc377adb9cc4dc8cedee94ce0b23~qI0zRuNvt1401714017epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561099033;
        bh=FUXfEF/JZH7Df1KRLWEPZkDMvrBOyREUHuamqsN/wwk=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=VayEJiU8NciideFFKQowZke/tdKrSvIws31Vi0UvfXuC9ovTpRmKOZ1nwyjI76Hgh
         2NXp06qC+YSxFCwc+ZkjJ2/3eIq5DxbshuOTv/XSzKsTEiEXodvL3SrPPKdibsXsKf
         ywudkW10xfZ9S1UhpSIaAL+pzlCrU2c3GpwdKG4Q=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.187]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190621063710epcas2p107eaab8554a6da203408dd69ba651303~qI0wV7sQ62189321893epcas2p1v;
        Fri, 21 Jun 2019 06:37:10 +0000 (GMT)
X-AuditID: b6c32a47-133ff7000000106e-70-5d0c7b15da6d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.0F.04206.51B7C0D5; Fri, 21 Jun 2019 15:37:09 +0900 (KST)
Mime-Version: 1.0
Subject: [RESEND RFC PATCH] mpt3sas: support target smid for [abort|query]
 task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
Date:   Fri, 21 Jun 2019 15:37:08 +0900
X-CMS-MailID: 20190621063708epcms2p309f4173afabe5de28942ba15d13987f7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmua5oNU+swb1+douPK3axWzx852yx
        6MY2Jou9t7QtLu+aw2bRfX0Hm8Xy4/+YLJ6dPsBsMfd1A5PFoq3vWS02zLvFYrH+0AQ2i2dn
        Yhx4PWbdP8vmMWHRAUaPj09vsXj0bVnF6PF5k1wAa1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScAkPDAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMJ6smMxfsFqo4euE3SwNjA38XIyeH
        hICJxNZb65i7GLk4hAR2MEpcmdME5HBw8AoISvzdIQxSIywQKHGiaSYbSFhIQF7ixysDiLCm
        xLvdZ1hBbDYBdYmGqa9YQMaICPxjlPi79C0TiMMscJxZYuHHRawQy3glZrQ/ZYGwpSW2L9/K
        CGGLStxc/ZYdxn5/bD5UXESi9d5ZZghbUOLBz92MIEdICEhI3HtnB2HWS2xZYQGySkKghVHi
        xpu1UK36Eo3PP4Kt4hXwlfg/aR9YnEVAVeLJvD1QY1wkDnwqBQkzA721/e0csM+Zgf5av0sf
        okJZ4sgtFogKPomOw3/ZYf7YMe8JE4StLPHx0CGoGyUlll96zQZhe0hs/zoXrEYIGICzu8+x
        TWCUn4UI2llI9s5C2LuAkXkVo1hqQXFuemqxUYExcmxuYgQnTy33HYzbzvkcYhTgYFTi4T0w
        iztWiDWxrLgy9xCjBAezkggvTw5PrBBvSmJlVWpRfnxRaU5q8SFGU6DvJzJLiSbnAxN7Xkm8
        oamRmZmBpamFqZmRhZI47ybumzFCAumJJanZqakFqUUwfUwcnFINjNlJ2855u8T5OmxkT73H
        xBVW1rREnkOhmdEl6ZxuRITq0t5okdLJ6sslNuidW7eLwyth99+1kcV/nHJEjJn8FwQvyFJ5
        m1QVMSu5wkwpaJ73z0lPJq/6tiXiStjPuzeYoucGulk/v2d+PPzzl+aOU1ft/JO6lhZPmqWV
        tMaz44npvAo78Y6DSizFGYmGWsxFxYkA+kuLG7QDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190621063708epcms2p309f4173afabe5de28942ba15d13987f7
References: <CGME20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
to /dev/mpt3ctl.  If the given task_type is either abort task or query
task, it may need a field named "Initiator Port Transfer Tag to Manage"
in the IU.

Current code does not support to check target IPTT tag from the
tm_request.  This patch introduces to check TaskMID given from the
userspace as a target tag.  We have a rule of relationship between
(struct request *req->tag) and smid in mpt3sas_base.c:

3318 u16
3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
3320         struct scsi_cmnd *scmd)
3321 {
3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
3323         unsigned int tag = scmd->request->tag;
3324         u16 smid;
3325
3326         smid = tag + 1;

So if we want to abort a request tagged #X, then we can pass (X + 1) to
this IOCTL handler.

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c14d35..5c7539dae713 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -596,15 +596,17 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
 		if (priv_data->sas_target->handle != handle)
 			continue;
 		st = scsi_cmd_priv(scmd);
-		tm_request->TaskMID = cpu_to_le16(st->smid);
-		found = 1;
+		if (tm_request->TaskMID == st->smid) {
+			tm_request->TaskMID = cpu_to_le16(st->smid);
+			found = 1;
+		}
 	}
 
 	if (!found) {
 		dctlprintk(ioc,
-			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no active mid!!\n",
+			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no matched mid(%d)!!\n",
 				    desc, le16_to_cpu(tm_request->DevHandle),
-				    lun));
+				    lun, tm_request->TaskMID));
 		tm_reply = ioc->ctl_cmds.reply;
 		tm_reply->DevHandle = tm_request->DevHandle;
 		tm_reply->Function = MPI2_FUNCTION_SCSI_TASK_MGMT;
-- 
2.16.1
