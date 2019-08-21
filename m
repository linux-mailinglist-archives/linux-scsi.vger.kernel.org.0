Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF697009
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Aug 2019 05:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfHUDLT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Aug 2019 23:11:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUDLT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 20 Aug 2019 23:11:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so425893pfk.9;
        Tue, 20 Aug 2019 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VKiFEOSby4f/ETS90JOc2T6lf0TxUWde3q3IiKs2hk=;
        b=ayPOIeKRL1aXrRPT53uPHJbOPJUR3Q8qwMtQKuVyArmh6gQPfIYa4X4+BAaNtOpRNN
         j+GGT6TSgTYnrz9gSvvEWQkyFopETx0DjM+2g+8c4z3pbtg7hcj6ehLiCisCrn7x0DLe
         MtweW9FMc37NWP/TB1hWkjNA5tsMDpudE+76Di89tqC9Q0ZdOUH5+vaK1pV0Q6WZX3EU
         JVpMHtiLZqofOoUsmZ7ptxzaNRsX4lAM4zYQVa+VjokG6ZIy6OMxv/ZYJNZB0/riLLu/
         Pzpo5IZkDOR9HUfrxuIWwsoLeIMhOA6MclnKVFNKgbyuGyHtHxMj9xqdfm0D+ioIbVfQ
         46lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VKiFEOSby4f/ETS90JOc2T6lf0TxUWde3q3IiKs2hk=;
        b=EbGN7Q8j+bzZo0XUe+x2uq0Buv4GO07+7y5prk+4hpskzB2SNdoBNkFc+zCcQIANQl
         u38biu2i+a1kNF/qS2vP80MOw/fRz949w/KyoWCd2ovGxnGfnVfVqzVKek4hhiJ/7PB0
         6oyUDF3HEtJPAuLDnbIx56jFwxXLtSb0dQdZ0amc12pIUyVMH8ukpkHMBRnNP0syjypN
         h/IgfPH1q47AvOFQrO3BZM4/dHMDecpJeTv6uI9pkItyhXGyU+vOxHRd6Ds/6RRqIGgB
         5gSurHuGgKjxEAnPnfcqZosQZzVPomLvucx1x5TKiaSNYyJOKQYyms68C6Nnmv/GboOI
         xziA==
X-Gm-Message-State: APjAAAWPi6E0zndVa1YCopwJyhlabkeRd1iO6vw0ibv8CmJJdvD4CuAY
        v5v3ix4BIo4zlmQpvh+oNT8=
X-Google-Smtp-Source: APXvYqxPDAcxhu5eVbv/IncTToFfr76TLspE3K2Ax1ShxsE3gx2pOAVuvkXzYaUOrffTdMCqAiaa6Q==
X-Received: by 2002:a63:2264:: with SMTP id t36mr26267617pgm.87.1566357078520;
        Tue, 20 Aug 2019 20:11:18 -0700 (PDT)
Received: from masabert (150-66-68-21m5.mineo.jp. [150.66.68.21])
        by smtp.gmail.com with ESMTPSA id l123sm31019032pfl.9.2019.08.20.20.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 20:11:18 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id A9D012011CC; Wed, 21 Aug 2019 12:11:03 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, QLogic-Storage-Upstream@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] scsi: qla4xxx: Fix a typo in ql4_os.c
Date:   Wed, 21 Aug 2019 12:11:02 +0900
Message-Id: <20190821031102.3788-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fix a spelling typo in a printk message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f1..1ac18f93cf9a 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -6191,7 +6191,7 @@ static int qla4xxx_setup_boot_info(struct scsi_qla_host *ha)
 
 	if (ql4xdisablesysfsboot) {
 		ql4_printk(KERN_INFO, ha,
-			   "%s: syfsboot disabled - driver will trigger login "
+			   "%s: sysfsboot disabled - driver will trigger login "
 			   "and publish session for discovery .\n", __func__);
 		return QLA_SUCCESS;
 	}
-- 
2.23.0

