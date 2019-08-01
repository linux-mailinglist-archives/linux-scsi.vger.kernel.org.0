Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B427E198
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfHAR4x (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38477 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so34514640pfn.5
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v22NfJHT0fEimg45wo6VRT3q9wEY+XD4H3GTcrgmli4=;
        b=EYW/6UPBnBpMVzlZx4ih8YBpgX7sFiwu0twwSx8uDK+FWKzWRm4s+ffb+iOEc1XJsT
         AT6oF1XGBSJ+7tsk+Wh6QDiK5ugBhj68ECKRHJwS1IZd6zvLPuUtoEeHhQY24cb0S2Jq
         sDb+gLfXe86TS5h6TZgL2B7XMD+mjDOSZslq3xsC12cWTPG2xigzhdE+FG/bE/slRPzo
         uNdtKvckRP32MEITAW7RVOcefMmBWhnSTP7Ms6WIn4L4PFi7dQG1M0bZ/WcpA3FJyq2h
         /UFxoptvycGL8428J3TPqDTspAmurjBuCgHsjjlscY0Nf9x1XvQYwXkrptjQ5X6EllOC
         pOeA==
X-Gm-Message-State: APjAAAXMpTDN0+GZPW/uRsaPPWEOjZO6d7QKMyRf8cjfZOr4TAq2/U2X
        Z2JUv6TvHcBrKKf689tK4Ls=
X-Google-Smtp-Source: APXvYqzEivOrINVYIs4MgCdhbqEk/zfki1R6jSOc9xrsqwhbXUliDYilqKSQ3ikJp93tiaJC8uVCCQ==
X-Received: by 2002:a62:584:: with SMTP id 126mr55244952pff.73.1564682212726;
        Thu, 01 Aug 2019 10:56:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 23/59] qla2xxx: Complain if a mailbox command times out
Date:   Thu,  1 Aug 2019 10:55:38 -0700
Message-Id: <20190801175614.73655-24-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes the following Coverity complaint:

Unchecked return value (CHECKED_RETURN)
check_return: Calling wait_for_completion_timeout without checking return
value (as is done elsewhere 14 out of 17 times).

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index b6be7e7f2a43..9e3f2f462a2e 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -148,7 +148,8 @@ qlafx00_mailbox_command(scsi_qla_host_t *vha, struct mbx_cmd_32 *mcp)
 		QLAFX00_SET_HST_INTR(ha, ha->mbx_intr_code);
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-		wait_for_completion_timeout(&ha->mbx_intr_comp, mcp->tov * HZ);
+		WARN_ON_ONCE(wait_for_completion_timeout(&ha->mbx_intr_comp,
+							 mcp->tov * HZ) != 0);
 	} else {
 		ql_dbg(ql_dbg_mbx, vha, 0x112c,
 		    "Cmd=%x Polling Mode.\n", command);
-- 
2.22.0.770.g0f2c4a37fd-goog

