Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21882D15DB
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Oct 2019 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfJIRZz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Oct 2019 13:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732485AbfJIRYx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:53 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E56218AC;
        Wed,  9 Oct 2019 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641892;
        bh=XsUiFacgZc1EmsQMXFnWjIiZN8J08qKJUkr7XAuI3xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxHGIFmjjYpj96sXX/1tqDqYmf+S01dTfvs3Ztu4u7f5LZhq199ttxUGd550Gr7js
         KMVrbZzygttjlvKQYBr7cvtuw650biyyw629gELHrXnfltFixV4A2aM1kfJzKMFSJH
         JXjQwxCZbVh1+L7eOV5ISIXY/3Oa8JfWxE3I9Sks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/11] scsi: qla2xxx: Fix unbound sleep in fcport delete path.
Date:   Wed,  9 Oct 2019 13:06:37 -0400
Message-Id: <20191009170646.696-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170646.696-1-sashal@kernel.org>
References: <20191009170646.696-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit c3b6a1d397420a0fdd97af2f06abfb78adc370df ]

There are instances, though rare, where a LOGO request cannot be sent out
and the thread in free session done can wait indefinitely. Fix this by
putting an upper bound to sleep.

Link: https://lore.kernel.org/r/20190912180918.6436-3-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 824e27eec7a1e..6c4f54aa60df6 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -437,6 +437,7 @@ static void qlt_free_session_done(struct work_struct *work)
 
 	if (logout_started) {
 		bool traced = false;
+		u16 cnt = 0;
 
 		while (!ACCESS_ONCE(sess->logout_completed)) {
 			if (!traced) {
@@ -446,6 +447,9 @@ static void qlt_free_session_done(struct work_struct *work)
 				traced = true;
 			}
 			msleep(100);
+			cnt++;
+			if (cnt > 200)
+				break;
 		}
 
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf087,
-- 
2.20.1

