Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462CE9A275
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393712AbfHVV4z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 17:56:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50094 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393707AbfHVV4z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Aug 2019 17:56:55 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0v4d-0005Tg-Du; Thu, 22 Aug 2019 21:56:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix spelling mistake "initializatin" -> "initialization"
Date:   Thu, 22 Aug 2019 22:56:51 +0100
Message-Id: <20190822215651.5403-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a ql_log message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qla2xxx/qla_nx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index 372355bfcbb6..65a675906188 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -1977,7 +1977,7 @@ qla82xx_check_rcvpeg_state(struct qla_hw_data *ha)
 	} while (--retries);
 
 	ql_log(ql_log_fatal, vha, 0x00ac,
-	    "Rcv Peg initializatin failed: 0x%x.\n", val);
+	    "Rcv Peg initialization failed: 0x%x.\n", val);
 	read_lock(&ha->hw_lock);
 	qla82xx_wr_32(ha, CRB_RCVPEG_STATE, PHAN_INITIALIZE_FAILED);
 	read_unlock(&ha->hw_lock);
-- 
2.20.1

