Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18F42566AB
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Aug 2020 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH2JuC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 29 Aug 2020 05:50:02 -0400
Received: from smtp.h3c.com ([60.191.123.50]:28641 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgH2JuB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 29 Aug 2020 05:50:01 -0400
X-Greylist: delayed 6269 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2020 05:50:00 EDT
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 07T85UlL029036
        for <linux-scsi@vger.kernel.org>; Sat, 29 Aug 2020 16:05:30 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 07T84e5w028045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 16:04:40 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 29 Aug 2020 16:04:43 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] scsi: qla2xxx: Fix the return value
Date:   Sat, 29 Aug 2020 15:57:46 +0800
Message-ID: <20200829075746.19166-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 07T84e5w028045
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A negative error code should be returned.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index fbb80a043..612e001cc 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3781,7 +3781,7 @@ int qlt_abort_cmd(struct qla_tgt_cmd *cmd)
 		    "multiple abort. %p transport_state %x, t_state %x, "
 		    "se_cmd_flags %x\n", cmd, cmd->se_cmd.transport_state,
 		    cmd->se_cmd.t_state, cmd->se_cmd.se_cmd_flags);
-		return EIO;
+		return -EIO;
 	}
 	cmd->aborted = 1;
 	cmd->trc_flags |= TRC_ABORT;
-- 
2.17.1

